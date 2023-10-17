<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 무슨 변수?
	// 1. 멤버 변수
	// 2. 지역 변수
	int a = 10; // 지역 변수 > 어떤 메소드 영역
	
	/* 안됨
	public void test() {
		
	}
	*/
%>
<%!
	int b = 20; // 지역 변수(X), 클래스 멤버 변수(O)
	
	// 이 메소드의 호출 영역 > 이 JSP 페이지 내에서만
	public int sum(int a, int b) {
		return a + b;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- ex06.jsp -->
	
	<div><%= sum(10, 20) %></div>
</body>
</html>