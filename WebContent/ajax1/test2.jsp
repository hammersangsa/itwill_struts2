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

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript">

	$(function(){
		
		$("#sendButton").click(function(){
		
			var param = "subject=" + $("#subject").val() +
				"&content=" + $("#content").val();
			
			$.ajax({
				
				type:"post",
				url:"test2_ok.jsp",
				data:param,
				dataType:"xml",
				success:function(args){
					
					//alert(args);
					//each: script의 반복문
					$(args).find("status").each(function(){
						//데이터가 넘어온 것을 확인
						alert($(this).text());
					});
					
					var str = "";
					//attr: 속성
					//누적데이터 출력
					$(args).find("record").each(function(){
						var id = $(this).attr("id");
						var subject = $(this).find("subject").text();
						var content = $(this).find("content").text();
						
						str += "id=" + id + 
								"<br/> subject=" + subject +
								", content=" + content + "<br/>";
					});
					
					$("#resultDIV").html(str);
					
				},
				beforeSend:showRequest,
				error:function(e){
					alert(e.responseText);
				}
			});
		});
	});

	function showRequest(){
	
		var flag = true;
		
		if(!$("#subject").val()){
			alert("제목을 입력하세요.");
			$("#subject").focus();
			return false;
		}
		
		if(!$("#content").val()){
			alert("내용을 입력하세요.");
			$("#content").focus();
			return false;
		}
	}
	
</script>

</head>
<body>

제목: <input type="text" id="subject"/><br/>
내용: <input type="text" id="content"/><br/>
<input type="button" id="sendButton" value="보내기"/>

<div id="resultDIV"></div>

</body>
</html>