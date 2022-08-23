<%@ page contentType="text/plain; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%!
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
	String[] newsPublisher = 
		{"중앙","CNN","JTBC","한겨레","동아","BBC","SBS",};
%>
{
	"count":<%=newsTitle.length%>,
	"titles":[
<%
	for(int i=0;i<newsTitle.length;i++){
		out.print("{");
		out.print("headline:\""+newsTitle[i]+"\"");
		out.print(",");
		out.print("publisher:\""+newsPublisher[i]+"\"");
		out.print("}");
		
		if(i!=(newsTitle.length-1)){
			out.print(",");
		}
	}
%>
	]
}