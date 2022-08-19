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
<!-- cdn -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">

	$(function(){
		
		$("#container").tabs();
	
	});
	
</script>

<style type="text/css">
	body{ font: 80% "굴림", sans-serif; margin: 50px;}
	ul#icons {margin: 0; padding: 0;}
	ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
	ul#icons span.ui-icon {float: left; margin: 0 4px;}
	#container { width: 300px;}
</style>

</head>
<body>

<div id="container">
<ul>
	<li><a href="#f1">첫번째</a></li>
	<li><a href="#f2">두번째</a></li>
	<li><a href="#f3">세번째</a></li>
</ul>

<div id="f1">
테스트1입니다
</div>

<div id="f2">
테스트2입니다
</div>

<div id="f3">
테스트3입니다
</div>

</div>

</body>
</html>