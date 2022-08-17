package com.test2;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

//struts2 ��������
public class TestAction extends ActionSupport
	implements Preparable,ModelDriven<UserDTO>{
	private static final long serialVersionUID = 1L;
	
	private UserDTO dto;
	
	//getDto���� dto��ü�� �����´�
	//req.setAttribute(dto, dto)�� �Ź� �����ϴ� ������ ����
	public UserDTO getDto() {
		return dto;
	}

	@Override
	public void prepare() throws Exception {
		//������ ���� ��ü ����
		dto = new UserDTO();
	}
	
	//modelDriven���� ����
	@Override
	public UserDTO getModel() {
		return dto;
	}
	
	//�޼ҵ� ����
	//�޼ҵ尡 ���̴�?
	public String created() throws Exception{
	//�Է�â�� �Է��� ���� ó��	
		if(dto==null||dto.getMode()==null||dto.getMode().equals("")) {
			//dto�� null�̸� input
			return INPUT;
		}
		//struts1�� �޼ҵ� �ȿ� ����
		HttpServletRequest request = ServletActionContext.getRequest();
		
		request.setAttribute("message", "Struts2!!!");
		
		return SUCCESS;
		
	}
}
