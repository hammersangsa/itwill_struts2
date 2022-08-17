package com.board;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import com.util.MyPage;
import com.util.dao.CommonDAO;
import com.util.dao.CommonDAOImpl;

public class BoardAction extends ActionSupport
	implements Preparable,ModelDriven<BoardDTO>{

	private BoardDTO dto;
	
	public BoardDTO getDto() {
		return dto;
	}

	@Override
	public BoardDTO getModel() {
		return dto;
	}

	@Override
	public void prepare() throws Exception {
		dto = new BoardDTO();
	}

	public String created() throws Exception{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		//���� ���� X
		//�Է�â(ȸ������)
		if(dto==null||dto.getMode()==null||dto.getMode().equals("")) {
			
			request.setAttribute("mode", "create");
			
			return INPUT;
		}
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		int maxBoardNum = dao.getIntValue("board.maxBoardNum");
		
		dto.setBoardNum(maxBoardNum + 1);
		dto.setIpAddr(request.getRemoteAddr());
		dto.setGroupNum(dto.getBoardNum());
		dto.setDepth(0);
		dto.setOrderNo(0);
		dto.setParent(0);
		
		dao.insertData("board.insertData", dto);
		
		return SUCCESS;
	}
	
	public String list() throws Exception {
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		MyPage myPage = new MyPage();
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String cp = request.getContextPath();
		
		int numPerPage = 5;
		int totalPage = 0;
		int totalDataCount = 0;
		int currentPage = 1;
		
		if(dto.getPageNum()!=null&&!dto.getPageNum().equals("")) {
			currentPage = Integer.parseInt(dto.getPageNum());
		}
		
		if(dto.getSearchValue()==null||dto.getSearchValue().equals("")) {
			dto.setSearchKey("subject");
			dto.setSearchValue("");
		}
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			dto.setSearchValue(URLDecoder.decode(dto.getSearchValue(), "UTF-8"));
		}
		
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("searchKey", dto.getSearchKey());
		hMap.put("searchValue", dto.getSearchValue());
		
		totalDataCount = dao.getIntValue("board.dataCount", hMap);
		
		if(totalDataCount!=0) {
			totalPage = myPage.getPageCount(numPerPage, totalDataCount);
		}
		
		if(currentPage>totalPage) {
			currentPage = totalPage;
		}
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		hMap.put("start", start);
		hMap.put("end", end);
		
		List<Object> lists = dao.getListData("board.listData", hMap);
		
		//�Ϸù�ȣ
		int listNum,n=0;
		
		Iterator<Object> it =  lists.iterator();
		
		while(it.hasNext()) {
			BoardDTO vo = (BoardDTO)it.next();
			listNum = totalDataCount-(start+n-1);
			
			vo.setListNum(listNum);
			n++;
		}
		
		String param = "";
		String urlList = "";
		String urlArticle = "";
		//�˻����� null�� �ƴϸ�
		if(!dto.getSearchValue().equals("")) {
			param = "&searchKey=" + dto.getSearchKey();
			param+= "&searchValue=" + 
					URLEncoder.encode(dto.getSearchValue(), "UTF-8");
		}
		
		urlList = cp + "/bbs/list.action";
		urlArticle = cp + "/bbs/article.action?pageNum=" + currentPage;
		
		//�˻� ���� ���
		if(!param.equals("")) {
			urlList += "?" + param;
			urlArticle += "&" + param;
		}
		
		request.setAttribute("lists", lists);
		request.setAttribute("totalDataCount", totalDataCount);
		request.setAttribute("pageIndexList",
				myPage.pageIndexList(currentPage, totalPage, urlList));
		request.setAttribute("urlArticle", urlArticle);
		
		return SUCCESS;
	}
	
	public String article() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		CommonDAO dao = CommonDAOImpl.getInstance();		
		
		//dto�� ���� �̸� ������ ��Ƴ��� ���
		//searchKey,searchValue�� DB�� �����Ƿ�
		String searchKey = dto.getSearchKey();
		String searchValue = dto.getSearchValue();
		String pageNum = dto.getPageNum();
		int boardNum = dto.getBoardNum();
		
		if(searchValue==null||searchValue.equals("")) {
			searchKey = "subject";
			searchValue = "";
		}
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLEncoder.encode(searchValue, "UTF-8");
		}
		
		dao.updateData("board.hitCountUpdate", boardNum);
		//���ο� �����͸� �����Ƿ� DB�� ���� ���� null�� �ʱ�ȭ
		dto = (BoardDTO)dao.getReadData("board.readData", boardNum);

		int lineSu = dto.getContent().split("\r\n").length;
		
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		
		Map<String, Object> hMap = new HashMap<>();
		hMap.put("searchKey", searchKey);
		hMap.put("searchValue", searchValue);
		hMap.put("groupNum", dto.getGroupNum());
		hMap.put("orderNo", dto.getOrderNo());
		
		BoardDTO preDTO = (BoardDTO)dao.getReadData("board.preReadData", hMap);
		int preBoardNum = 0;
		String preSubject = "";
		if(preDTO!=null) {
			preBoardNum = preDTO.getBoardNum();
			preSubject = preDTO.getSubject();
		}
		
		BoardDTO nextDTO = (BoardDTO)dao.getReadData("board.nextReadData", hMap);
		int nextBoardNum = 0;
		String nextSubject = "";
		if(nextDTO!=null) {
			nextBoardNum = nextDTO.getBoardNum();
			nextSubject = nextDTO.getSubject();
		}
		
		String params = "pageNum=" + pageNum;
		
		if(!searchValue.equals("")) {
			params += "&searchKey=" + searchKey;
			params += "&searchValue=" + 
					URLEncoder.encode(searchValue, "UTF-8");
		}
		
		request.setAttribute("preBoardNum", preBoardNum);
		request.setAttribute("preSubject", preSubject);
		request.setAttribute("nextBoardNum", nextBoardNum);
		request.setAttribute("nextSubject", nextSubject);
		request.setAttribute("params", params);
		request.setAttribute("lineSu", lineSu);
		request.setAttribute("pageNum", pageNum);
			
		return SUCCESS;
	}
	
	public String updated() throws Exception{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		//dto�� ������ �����Ƿ� dto=null�� ����
		if(dto.getMode()==null||dto.getMode().equals("")) {
			
			dto = (BoardDTO)dao.getReadData("board.readData", dto.getBoardNum());
			
			request.setAttribute("mode", "update");
			request.setAttribute("pageNum", dto.getPageNum());
			
			return INPUT;
		}
		dao.updateData("board.updateData", dto);
		
		return SUCCESS;
	}
	
	public String reply() throws Exception{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		if(dto==null||dto.getMode()==null||dto.getMode().equals("")) {
			
			//�θ��� ������ �о����
			dto = (BoardDTO)dao.getReadData("board.readData", dto.getBoardNum());
			
			String temp = "\r\n\r\n-------------------------------------\r\n\r\n";
			temp += "[�亯]\r\n";
			
			//�θ����͸� �����ؼ� �亯�����ͷ� create.jsp�� ���
			//create+update
			dto.setSubject("[�亯]" + dto.getSubject());
			dto.setContent(dto.getContent() + temp);
			dto.setName("");
			dto.setEmail("");
			dto.setPwd("");
			
			request.setAttribute("mode", "reply");
			request.setAttribute("pageNum", dto.getPageNum());
			
			return INPUT;
		}
		//orderNo ����
		Map<String, Object> hMap = new HashMap<>();
		hMap.put("groupNum", dto.getGroupNum());
		hMap.put("orderNo", dto.getOrderNo());
		
		dao.updateData("board.orderNoUpdate", hMap);
		
		//�亯 �Է�
		int maxBoardNum = dao.getIntValue("board.maxBoardNum");
		
		dto.setBoardNum(maxBoardNum + 1);
		dto.setIpAddr(request.getRemoteAddr());
		dto.setDepth(dto.getDepth() + 1);
		dto.setOrderNo(dto.getOrderNo() + 1);
		
		dao.insertData("board.insertData", dto);
		
		return SUCCESS;
	}
	
	public String deleted() throws Exception{
		
		//HttpServletRequest request = ServletActionContext.getRequest();
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		dao.deleteData("board.deleteData", dto.getBoardNum());
		
		//request.setAttribute("pageNum", dto.getPageNum());
		
		return SUCCESS;
	}
	
}
