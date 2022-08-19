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
 
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <style>
  #draggable { width: 200px; height: 150px; padding: 0.5em; }
  #datepciker { padding-left: 40px;}
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#draggable" ).draggable();
  } );
  
  $( function() {
	    $( "#datepicker" ).datepicker();
	} );
  </script>
</head>
<body>
 
<div id="draggable" class="ui-widget-content">
  <p>Drag me around</p>
  
  <p>Date: <input type="text" id="datepicker"></p>
  
</div>


</body>
</html>