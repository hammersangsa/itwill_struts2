package com.test1;

import com.opensymphony.xwork2.ActionSupport;

public class TestAction extends ActionSupport{
	private static final long serialVersionUID = 1L;

	private UserDTO	user;
	private String message;
	//user�� ���� ���͸� �����ؾ� UserDTO�� ������ �� �ִ�.
	public UserDTO getUser() {
		return user;
	}

	public void setUser(UserDTO user) {
		this.user = user;
	}
	public String execute() throws Exception{
		
		message = user.getUserName() + "�� �ȳ��ϼ���";
		
		return "ok";
	}

	public String getMessage() {
		return message;
	}
}
