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
<title>Js로 만든 Ajax</title>

<script type="text/javascript">
	//객체
	var XMLHttpRequest;

	function ajaxRequest(){
		
		//객체 생성
		XMLHttpRequest = new XMLHttpRequest();
		
		XMLHttpRequest.open("GET","helloAjax_ok.jsp",true);
		XMLHttpRequest.onreadystatechange = viewMessage;
		XMLHttpRequest.send(null);
	}

	function viewMessage(){
		
		var responseText = XMLHttpRequest.responseText;
		
		var divE = document.getElementById("printDIV");
		
		divE.innerHTML = responseText; 
	}
	
</script>

</head>
<body>
<h1>Hello Ajax</h1>
<input type="button" value="클릭" onclick="ajaxRequest();">
<br/><br/>
<div id="printDIV" style="border: 1px solid red; width: 50%"></div>

</body>
</html>