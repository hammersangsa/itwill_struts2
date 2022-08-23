package com.iguest;

import java.util.HashMap;
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

public class GuestAction extends ActionSupport
	implements Preparable,ModelDriven<GuestDTO>{

	private static final long serialVersionUID = 1L;
	private GuestDTO dto;
	
	@Override
	public GuestDTO getModel() {
		return dto;
	}

	@Override
	public void prepare() throws Exception {
		dto = new GuestDTO();
	}

	public String created() throws Exception{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		int maxNum = dao.getIntValue("iguest.numMax");
		
		dto.setNum(maxNum + 1);
		dto.setIpAddr(request.getRemoteAddr());
		
		dao.insertData("iguest.insertData", dto);
		
		return list();
	}
	public String list() throws Exception{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		MyPage myPage = new MyPage();
		
		int numPerPage = 3;
		int totalPage = 0;
		int totalDataCount = 0;
		
		String pageNum = request.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null&&!pageNum.equals("")) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		totalDataCount = dao.getIntValue("iguest.dataCount");
		
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
		
		List<Object> lists = dao.getListData("iguest.listData", hMap);
		
		String pageIndexList = myPage.pageIndexList(currentPage, totalPage);
		
		request.setAttribute("lists", lists);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("totalDataCount", totalDataCount);
		request.setAttribute("pageNum", pageNum);
		
		return SUCCESS;
	}
	public String deleted() throws Exception{
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		CommonDAO dao = CommonDAOImpl.getInstance();
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		dao.deleteData("iguest.deleteData", num);
		
		return list();
	}
	
}
