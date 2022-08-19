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
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp%>/data/js/ajaxUtil.js"></script>
 <script>
  $( function() {
    $( "#draggable" ).draggable();
  } );
 </script>
<script type="text/javascript">
	//js로 ajax구현
	function sendIt(){
		//XMLHttpRequest 객체,crome에서만
		//xmlHttp = new XMLHttpRequest();
		//전체 브라우저
		//1
		xmlHttp = createXMLHttpRequest();
		//2
		var query = "";
		var su1 = document.getElementById("su1").value;
		var su2 = document.getElementById("su2").value;
		var oper = document.getElementById("oper").value;
		
		//get방식으로 데이터 전송
		query = "test1_ok.jsp?su1=" + su1 + "&su2=" + su2 + "&oper=" + oper;
		//3
		//되돌아오는 데이터를 받는 함수
		xmlHttp.onreadystatechange = callback
		
		//true:비동기
		xmlHttp.open("GET",query,true);
		xmlHttp.send(null)
	}
	//4
	function callback(){
		if(xmlHttp.readyState==4){
			if(xmlHttp.status==200){
				printData();
			}
		}
	}

	function printData(){
		var result = xmlHttp.responseXML.getElementsByTagName("root")[0];
		
		var out = document.getElementById("resultDIV");
		
		out.innerHTML = "";
		out.style.display = "";
		//sum읽어옴
		var value = result.firstChild.nodeValue;
		
		out.innerHTML = value;
	}
</script>


</head>
<body>
<div id="draggable" class="ui-widget-content" align="center">
	<p>계 산 기</p>
	<input type="text" id="su1"/>
	<select id="oper">
		<option value="hap">더하기</option>
		<option value="sub">빼기</option>
		<option value="mul">곱하기</option>
		<option value="div">나누기</option>
	</select>
	<input type="text" id="su2"/>
	<input type="button" value=" = " onclick="sendIt();"/>
	<div id="resultDIV" style="display: none;"></div>
	<br/>
	
		
</div>
</body>
</html>