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
<title>JSON형태의 데이터</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
  $( function() {
    $( "#draggable" ).draggable();
  } );
 </script>
<script type="text/javascript">

$(document).ready(function(){
	$("#saveButton").click(function(){
		param = "userId=" + $("#userId").val() +
				"&userPwd=" + $("#userPwd").val();
		
		$.ajax({
			type:"post",
			url:"test5_ok.jsp",
			data:param,
			dataType:"json",
			success:function(data){
				
				var str = "";
				
				for(var i=0;i<data.length;i++){
					
					str += "id=" + data[i].id;
					str += "<br/> userId=" + data[i].userId;
					str += "/userPwd=" + data[i].userPwd + "<br/>";
				}
				
				$("#resultDIV").html(str);
								                                                 
			},
			error:function(e){
				alert(e.responseText);
			}
		});
	});
});

</script>

</head>
<body>
<div id="draggable" class="ui-widget-content" align="center">
	<p>JSON</p>
	아이디: <input type="text" id="userId"/><br/>
	패스워드: <input type="text" id="userPwd"/><br/>
	
	<button id="saveButton">전송</button>
	<br/><br/>
	<div id="resultDIV"></div>
</div>
</body>
</html>