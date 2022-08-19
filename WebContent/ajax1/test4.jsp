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
<title>Ajax</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	$("#saveButton").click(function(){
		param = "userId=" + $("#userId").val() +
				"&userPwd=" + $("#userPwd").val();
		
		$.ajax({
			type:"post",
			url:"test4_ok.jsp",
			data:param,
			success:function(data){
				$("#resultDIV").html(data);
			},
			beforeSend:showRequest,
			error:function(e){
				alert(e.responseText);
			}
		});
	});
	
	function showRequest(){
		var flag = true;
		
		if(!$("#userId").val()){
			alert("아이디을 입력하세요.");
			$("#userId").focus();
			return false;
		}
		if(!$("#userPwd").val()){
			alert("비밀번호를 입력하세요.");
			$("#userPwd").focus();
			return false;
		}
		return flag;
	}
	
	$("#clearButton").click(function(){
		$("#resultDIV").empty();
	});
});

</script>

</head>
<body>
아이디: <input type="text" id="userId"/><br/>
패스워드: <input type="text" id="userPwd"/><br/>

<button id="saveButton">전송</button>
<button id="clearButton">지우기</button>
<br/><br/>
<div id="resultDIV"></div>
</body>
</html>