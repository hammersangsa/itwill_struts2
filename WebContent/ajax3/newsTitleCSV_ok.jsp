<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%!
	//dao역할
	//!를 주는 이유는 지역변수(lv)가 아닌 전역변수(iv)로 데이터를 지정하여 사용하기 위해
	//서버 타임시간을 바꾸기에 기사 최신화가 쉬움
	String[] newsTitle = 
		{	
		"신현준 ''이하정♥'정준호, 결혼 안한다고 하다 아내 임신해서' 폭로에 '깜짝'",
		"광복절 앞두고 日여행 간 '미우새', 비난에도 꿋꿋한 '궁상민 여행'",
		"'애매하네' '굳이 결혼 다시 해야할까'…한정민·조예영, 폭풍 스킨십後 현실 걱정 '등장'",
		"채소영, 8년 절친에 '부동산 사기' 당해→10kg 찌고+공황장애",
		"'우영우' 강태오 ''대선배' 박은빈, 솔직한 피드백 도움받아'",
		"'자폐 변호사''심의' '멘탈코치'…韓드, 독특한 소재 찾기 혈안된 이유",
		"''커피값 또 오르면 안 되는데'…직장인 '비상''"
		};

/*		출력 예시 
		6|신현준 ''이하정♥'정준호, 결혼 안한다고 하다 아내 임신해서' 폭로에 '깜짝'[2022.08.22 오전 11:15:21]*
		7|광복절 앞두고 日여행 간 '미우새', 비난에도 꿋꿋한 '궁상민 여행'[2022.08.22 오전 11:15:21]*
*/
%>

<%	
	out.print(newsTitle.length + "|");
	for(int i=0;i<newsTitle.length;i++){
		out.print(newsTitle[i] + " [" + new Date() + "]");
		
		if(i!=(newsTitle.length-1)){
			out.print("*");
		}
	}
%>