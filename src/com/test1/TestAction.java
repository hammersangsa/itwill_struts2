package com.test1;

import com.opensymphony.xwork2.ActionSupport;

public class TestAction extends ActionSupport{
	private static final long serialVersionUID = 1L;

	private UserDTO	user;
	private String message;
	//user의 게터 세터를 설정해야 UserDTO를 가져올 수 있다.
	public UserDTO getUser() {
		return user;
	}

	public void setUser(UserDTO user) {
		this.user = user;
	}
	public String execute() throws Exception{
		
		message = user.getUserName() + "님 안녕하세요";
		
		return "ok";
	}

	public String getMessage() {
		return message;
	}
}
