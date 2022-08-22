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
<title>check serverTime</title>

<script type="text/javascript">
	
	var XMLHttp;

	XMLHttp = new XMLHttpRequest();
	
	function printClientTime() {
		
		//time client
		var clientTimeSpan = document.getElementById("clientTimeSpan")
		//util Date
		var now = new Date();
		
		var timeStr = now.getFullYear() + "년 "
						+ (now.getMonth()+1) + "월 "
						+ now.getDate() + "일 "
						+ now.getHours() + "시 "
						+ now.getMinutes() + "분 "
						+ now.getSeconds() + "초";
		
		clientTimeSpan.innerHTML = timeStr;
		
		setTimeout("printClientTime()", 1000);
	}

	function requestTime(){
		//set value dummy(null)
		//?dummy=" + new Data().toString; 부분은 오류 처리 위해 가끔 회사에서 사용
		XMLHttp.open("GET","clock_ok.jsp",true);
		
		XMLHttp.onreadystatechange = printServerTime;
		
		XMLHttp.send(null);
		
		setTimeout("requestTime()",1000);
	}	
	
	function printServerTime() {
		
		if(XMLHttp.readyState==4) {
			if(XMLHttp.status==200){
				
				var serverTimeSpan = document.getElementById("serverTimeSpan");
				
				serverTimeSpan.innerHTML = XMLHttp.responseText;
			}
		}
		
	}	
	//action window open
	window.onload = function(){
		printClientTime();
		
		requestTime();
		printServerTime();
	}
</script>

</head>
<body>

<h1>Clock</h1>
<br/>
<hr/>

1.현재 클라이언트의 시간은 <strong><span id="clientTimeSpan"></span></strong> 이다.<br/>
2.서버 시간은 <strong><span id="serverTimeSpan"></span></strong> 이다.<br/>
</body>
</html>