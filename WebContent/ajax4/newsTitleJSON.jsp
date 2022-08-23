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
<title>뉴스 타이틀 JSON</title>
<style type="text/css">
.news{
font-size: 10pt;
display: block;
margin: 0 auto;
background: silver;
color: black;
border: 1px dashed black;
width: 60%;
}
</style>
<script type="text/javascript" src="<%=cp%>/data/js/ajaxUtil.js"></script>
<script type="text/javascript">
	function newsTitle(){
		sendRequest("newsTitleJSON_ok.jsp",null,displayTitle,true);
		setTimeout("newsTitle()",3000);
	}
	function displayTitle(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				var jsonStr = httpRequest.responseText;
				//alert(jsonStr);
				//script명령어 "eval"
				//변수를 javascript의 함수처럼 사용하는 명령어
				//변수의 내용을 읽어서 객체화
				var jsonObject = window.eval('(' + jsonStr + ')');
				//alert(jsonObject);
				//alert(jsonObject.count);//7
				var count = jsonObject.count;
				if(count>0){
					var htmlData = "<ol>";
					for(var i=0;i<jsonObject.titles.length;i++){
						var publisherStr = 
							jsonObject.titles[i].publisher;
						var headlineStr =
							jsonObject.titles[i].headline;
						
						htmlData += "<li>" + headlineStr +
						" [" + publisherStr + "]</li>";
					}
					htmlData += "</ol>";
					
					var newsDiv = document.getElementById("newsDiv");
					newsDiv.innerHTML = htmlData;
				}
			}
		}
		
	}
	window.onload = function(){
		newsTitle();
	}
</script>
</head>
<body>
<h2>헤드라인 뉴스</h2>
<hr/>
<br/>
<div style="width: 60%; margin: 0 auto;">뉴스보기</div>
<div id="newsDiv" class="news"></div>
</body>
</html>