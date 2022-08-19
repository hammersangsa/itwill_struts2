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
<title>Insert title here</title>

<script type="text/javascript">

	var XmlHttp;
	
	function getXmlHttpRequest(){
		if(window.ActioveXObject){
			try {
				XmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				XmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}else{
			XmlHttp = new XMLHttpRequest();
		}
	}
	
	function ajaxRequestGet(){
		/* XmlHttp = new XMLHttpRequest(); */
		
		var data = document.myForm.greeting.value;
		
		if(data=="") {
			alert("데이터 입력");
			document.myForm.greeting.focus();
			return
		}
		
		XmlHttp.open("GET","ajaxGetPost_ok.jsp?greeting=" + data, true);
		XmlHttp.onreadystatechange = viewMessage;
		XmlHttp.send(null);
	}

	function ajaxRequestPost(){
		var data = document.myForm.greeting.value;
		
		if(data=="") {
			alert("데이터 입력");
			document.myForm.greeting.focus();
			return
		}
		
		XmlHttp.open("POST","ajaxGetPost_ok.jsp", true);
		XmlHttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		XmlHttp.onreadystatechange = viewMessage;
		XmlHttp.send("greeting=" + data);
	}
	
	
	function viewMessage() {
		//form밖 div이므로
		var divE = document.getElementById("printDIV");
		
		if(XmlHttp.readyState==1||
				XmlHttp.readyState==2||
				XmlHttp.readyState==3){
			
			divE.innerHTML = 
				"<img src='./image/processing.gif' width='50' height='50'/>";
		}else if(XmlHttp.readyState==4){
			divE.innerHTML = XmlHttp.responseText;
		}else{
			divE.innerHTML = "<font color='red'>" +
				XmlHttp.status + " 에러발생 " + "</font>";
		}	
	}
	
	window.onload = function() {
		getXmlHttpRequest();
	}

</script>

</head>
<body>

<form action="" name="myForm">

<input type="text" name="greeting">
<input type="button" value="GET전송" onclick="ajaxRequestGet();"/>
<input type="button" value="POST전송" onclick="ajaxRequestPost();"/>

</form>

<div id="printDIV" style="border: 1px solid blue; width: 50%"></div>

</body>
</html>