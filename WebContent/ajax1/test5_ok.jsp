<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	//JSON(키:값)
	/* 
	[
	 {"id":"1","userId":"suzi","userPwd":"a123"},
	 {"id":"2","userId":"suz","userPwd":"b123"},
	 {"id":"3","userId":"su","userPwd":"c123"},
	]
	*/
	
	String result = "";
	
	for(int i=1;i<=3;i++){
		result += "{\"id\":\"" + i;
		result += "\",\"userId\":\"" + userId;
		result += "\",\"userPwd\":\"" + userPwd + "\"},";
	}
	
	result = result.substring(0,result.length()-1);
	result = "[" + result + "]";
	
	out.print(result);
%>
