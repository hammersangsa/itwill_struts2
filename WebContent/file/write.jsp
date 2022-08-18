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
<title>파일 업로드</title>

<link rel="stylesheet" href="<%=cp %>/data/css/style.css" type="text/css"/>
<script type="text/javascript" src="<%=cp %>/data/js/util.js"></script>

<script type="text/javascript">

	function sendIt() {
		
		f = document.myForm;
		
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		if(!str){
			alert("업로드할 파일을 선택하세요.");
			f.upload.focus();
			return;
		}
				
		f.action = "<%=cp %>/fileTest/save.action";
		f.submit();
	}
	
</script>

</head>
<body>

<table width="600" border="2" cellpadding="0" cellspacing="0" 
	bordercolor="#d6d4a6" align="center">
<tr height="40">
	<td style="padding-left: 20px;">
	<strong>파일 업로드</strong>
	</td>
</tr>	
</table>

<br/>

<form action="" method="post" name="myForm" enctype="multipart/form-data">

<table width="600" border="0" cellpadding="0" cellspacing="3" align="center">

<tr><td colspan="2" class="line3" bgcolor="#dbdbdb" align="center"></td></tr>
<tr>
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	제&nbsp;&nbsp;&nbsp;&nbsp;목
	</td>
	<td width="80%" style="padding-left: 10px;">
	<input type="text" name="subject" size="74" maxlength="100" class="boxTF"/>
	</td>	
</tr>
<tr><td colspan="2" class="line3" bgcolor="#dbdbdb" align="center"></td></tr>
	
<tr>
	<td width="20%" height="30" bgcolor="#eeeeee" style="padding-left: 20px;">
	첨부파일
	</td>
	<td width="80%" style="padding-left: 10px;">
	<input type="file" name="upload" size="58" maxlength="100" class="boxTF"
	style="height: 20px;"/>
	</td>	
</tr>
<tr><td colspan="2" class="line3" bgcolor="#dbdbdb" align="center"></td></tr>

</table>

<table width="500" border="0" cellpadding="0" cellspacing="3" align="center">
<tr align="center">
	<td height="40">
	<input type="hidden" name="mode" value="save"/>

	<input type="button" value=" 등록하기 " class="btn1" onclick="sendIt();"/> 
	<input type="button" value=" 작성취소 " class="btn1" 
	onclick="location.href='<%=cp%>/fileTest/list.action';"/>
	</td> 
</tr>
</table>

</form>

</body>
</html>