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
<title>userId 유효성 검사</title>

<script type="text/javascript">

	var XMLHttp;
	
	XMLHttp = new XMLHttpRequest();
	
	function requestGet() {
		
		var f = document.myForm;
		
		var params = "?userId=" + f.userId.value;
		
		XMLHttp.open("GET","ajaxId_ok.jsp" + params, true);
		XMLHttp.onreadystatechange = viewMessage;
		XMLHttp.send(null);
	}

	function viewMessage(){
		
		if(XMLHttp.readyState==4){
			if(XMLHttp.status==200) {
				
				var str = XMLHttp.responseText;
				
				var DivE = document.getElementById("resultDIV");
				DivE.innerHTML = str;
			}
		}else{
			var DivE = document.getElementById("resultDIV");
			DivE.innerHtml =
				"<img width = '15' height='15' src='./image/loading.gif'/>"
		}
	}
	
</script>

</head>
<body>

<h1>Ajax ID 확인</h1>
<hr/>
<form action="" name="myForm">
<!-- onkeyup 키보드를 손에서 뗄 때 -->
아이디: <input type="text" name="userId" onkeyup="requestGet();"/>

</form>

<div id="resultDIV" style="color: black; border: 1px solid #000000; width: 40%">

</div>

</body>
</html>