<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<a href="<%=cp%>/main.action">메인</a>
<a href="<%=cp%>/bbs/list.action">게시판</a>
<a href="<%=cp%>/fileTest/list.action">파일게시판</a>