package com.test2;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

//struts2 정규형식
public class TestAction extends ActionSupport
	implements Preparable,ModelDriven<UserDTO>{
	private static final long serialVersionUID = 1L;
	
	private UserDTO dto;
	
	//getDto에서 dto객체를 가져온다
	//req.setAttribute(dto, dto)를 매번 실행하는 과정을 생략
	public UserDTO getDto() {
		return dto;
	}

	@Override
	public void prepare() throws Exception {
		//데이터 받을 객체 생성
		dto = new UserDTO();
	}
	
	//modelDriven으로 유도
	@Override
	public UserDTO getModel() {
		return dto;
	}
	
	//메소드 구분
	//메소드가 무겁다?
	public String created() throws Exception{
	//입력창과 입력을 동시 처리	
		if(dto==null||dto.getMode()==null||dto.getMode().equals("")) {
			//dto가 null이면 input
			return INPUT;
		}
		//struts1은 메소드 안에 지정
		HttpServletRequest request = ServletActionContext.getRequest();
		
		request.setAttribute("message", "Struts2!!!");
		
		return SUCCESS;
		
	}
}
