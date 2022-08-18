package com.file;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import com.util.FileManager;
import com.util.MyPage;
import com.util.dao.CommonDAO;
import com.util.dao.CommonDAOImpl;

public class FileAction extends ActionSupport
	implements Preparable, ModelDriven<FileDTO>{

	private FileDTO dto;
	
	public FileDTO getDto() {
		return dto;
	}

	@Override
	public FileDTO getModel() {
		return dto;
	}

	@Override
	public void prepare() throws Exception {
		dto = new FileDTO();
	}
	private String pageNum;

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	
	public String save() throws Exception{
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(dto==null||dto.getMode()==null||dto.getMode().equals("")) {
			return INPUT;
		}
		String root = session.getServletContext().getRealPath("/");
		String savePath = root + "pds" + File.separator + "data";
		
		String newFileName = 
				FileManager.doFileUpload(dto.getUpload(), 
						dto.getUploadFileName(), savePath);
		
		if(newFileName!=null) {
			int maxNum = dao.getIntValue("file.numMax");
			
			dto.setNum(maxNum+1);
			dto.setSaveFileName(newFileName);
			dto.setOriginalFileName(dto.getUploadFileName());
			
			dao.insertData("file.insertData", dto);
		}
		return SUCCESS;
	}
	
	public String list() throws Exception{
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String cp = request.getContextPath();
		MyPage myPage = new MyPage();
		
		int numPerPage = 5;
		int totalPage = 0;
		int totalDataCount = 0;
		int currentPage = 1;
		
		if(pageNum!=null&&!pageNum.equals("")) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		totalDataCount = dao.getIntValue("file.dataCount");
		
		if(totalDataCount!=0) {
			totalPage = myPage.getPageCount(numPerPage, totalDataCount);
		}
		
		if(currentPage>totalPage) {
			currentPage = totalPage;
		}
		
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		hMap.put("start", start);
		hMap.put("end", end);
		
		//dto다섯개(numperpage지정)
		List<Object> lists = dao.getListData("file.listData", hMap);
		
		//글 리스트 번호
		int listNum, n=0;
		String str;
		
		Iterator<Object> it = lists.iterator();
		while(it.hasNext()) {
			FileDTO vo = (FileDTO)it.next();
			
			listNum = totalDataCount-(start+n-1);
			vo.setListNum(listNum);
			n++;
			
			str = cp + "/fileTest/download.action?num=" + vo.getNum();
			vo.setUrlFile(str);
		}
		//페이징에 보낼 주소
		String urlList = cp + "/fileTest/list.action";
		
		request.setAttribute("lists", lists);
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("totalDataCount", totalDataCount);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("pageIndexList", 
				myPage.pageIndexList(currentPage, totalPage, urlList));
		
		return SUCCESS;
	}
	
	public String delete() throws Exception{
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		String root = session.getServletContext().getRealPath("/");
		String savePath = root + "pds" + File.separator + "data";
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		FileDTO dto = (FileDTO)dao.getReadData("file.readData", num);
		
		FileManager.doFileDelete(dto.getSaveFileName(), savePath);
		
		dao.deleteData("file.deleteData", num);
		
		return SUCCESS;
	}
	
	public String download() throws Exception{
		

		CommonDAO dao = CommonDAOImpl.getInstance();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		
		String root = session.getServletContext().getRealPath("/");
		String savePath = root + "pds" + File.separator + "data";
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		FileDTO dto = (FileDTO)dao.getReadData("file.readData", num);
		
		FileManager.doFileDownload(response, 
				dto.getSaveFileName(), dto.getOriginalFileName(), savePath);
		
		//type=stream이 chain역할을 하므로 화면 전환 없이
		//struts-file의 success로 찾아가게됌
		return null;
	}
	
}
