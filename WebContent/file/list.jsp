<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 리스트</title>
<link rel="stylesheet" href="<%=cp%>/data/css/style.css" type="text/css"/>
</head>
<body topmargin="20" marginwidth="20" leftmargin="20" marginheight="20">

<table width="600" border="2" cellpadding="0" cellspacing="0" 
	bordercolor="#d6d4a6" align="center">
<tr height="40">
	<td style="padding-left: 20px;">
	<strong>파일 리스트</strong>
	</td>
</tr>
</table>

<br/>

<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
<tr height="30">
	<td align="left" width="50%">
	Total ${totalDataCount } articles, ${totalPage } pages / Now Page is ${pageNum }
	</td>
	<td align="right">
	<input type="button" value=" 파일 올리기 " class="btn1"
	 onclick="location.href='<%=cp%>/fileTest/save.action';">
	 </td>
</tr>	 
</table>

<table width="600" border="0" cellpadding="3" cellspacing="1"
	bgcolor="#cccccc" align="center">
<tr align="center" bgcolor="#e6e4e6" height="25">
	<td width="40">번호</td>
	<td width="200">제목</td>
	<td width="320">첨부파일</td>
	<td width="40">수정</td>
</tr>

<c:forEach var="dto" items="${lists }">
<tr onmouseover="this.style.backgroundColor='#e4e4e4'"
	onmouseout="this.style.backgroundColor=''" bgcolor="#ffffff" height="25">
	<td width="40" align="center">${dto.listNum }</td>
	<td width="200" align="left">${dto.subject }</td>
	<td width="320" align="left">
	<a href="${dto.urlFile }">${dto.originalFileName }</a>
	</td>
	<td width="40" align="center">
	<a href="<%=cp%>/fileTest/delete.action?num=${dto.num }&pageNum=${pageNum }">
	삭제
	</a>
	</td>
</tr>	
</c:forEach>

<c:if test="${totalDataCount==0 }">
<tr bgcolor="#ffffff" height="30">
	<td align="center" colspan="4">등록된 자료가 없습니다!!!</td>
</tr>
</c:if>

</table>

<c:if test="${totalDataCount!=0 }">
<table width="600" border="0" cellpadding="3" cellspacing="0" align="center">
<tr align="center" >
	<td align="center" headers="30">${pageIndexList }</td>
</tr>
</table>
</c:if>

</body>
</html>