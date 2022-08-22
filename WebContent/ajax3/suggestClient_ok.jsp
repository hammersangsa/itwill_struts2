<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%!
	//!로 메소드(메소드 사용)
	String[] keywords = {
			"ajax","Ajax","Ajax실전 프로그래밍","AJA","AZERA",
			"자가비","자전거","자라","자바 노잼","자바 서버페이지",
			"자바를 잡아봐~","astra","aja aja 파이팅","자라니",
			"A-특공대","Apple","Amazon"
	};
	public List<String> search(String userKeyword) {
		
		if(userKeyword==null||userKeyword.equals("")){
			return null;
			//List 명령어(return null)
			//return Collections.EMPTY_LIST;
		}
		//대문자변환
		//userKeyword = userKeyword.toUpperCase();
		List<String> lists = new ArrayList<String>();
		
		for(int i=0;i<keywords.length;i++){
			if(keywords[i].startsWith(userKeyword)){
				lists.add(keywords[i]);
			}
		}
		return lists;
	}

%>
<%
	String userKeyword = request.getParameter("userKeyword");
	//search메소드처리 후 keywordLists에 담는다
	List<String> keywordLists = search(userKeyword);
	//반환된 제시어의 개수
	out.print(keywordLists.size());
	out.print("|");
	
	Iterator<String> it = keywordLists.iterator();
	while(it.hasNext()){
		String value = (String)it.next();
		out.print(value);
	
		if(keywordLists.size() -1 > 0){
			out.print(",");
		}
	}
	/*MAP 
		for(int i=0;i<keywordLists.size();i++){
			String key = (String)keywordLists.get(i);
			out.print(key);
			if(i<keywordLists.size()-1){
				out.print(",");
			}
		}
	*/
	
%>
