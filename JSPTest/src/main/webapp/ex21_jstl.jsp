<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">
<style>
	body {
		padding-bottom: 50px;
	}
</style>
</head>
<body>
	<!-- ex21_jstl.jsp -->
	
	<h1>JSTL</h1>
	
	<h2>변수 선언</h2>
	<%
		int a = 10; // 지역변수
		
		pageContext.setAttribute("b", 20); // 내장 객체 변수
	%>
	<c:set var="c" value="30" /> <!-- JSTL 변수 -->
	
	<div>a: <%= a %></div>
	<div>a: ${a}</div>
	
	<div>b: <%= pageContext.getAttribute("b") %></div>
	<div>b: ${b}</div>
	
	<%-- <div>c: <%= c %></div> --%>
	<div>c: ${c}</div>
	<div>c: <%= pageContext.getAttribute("c") %></div>
	
	<h2>변수 수정하기(값 바꾸기)</h2>
	
	<c:set var="c" value="300" />
	<div>c: ${c}</div>
	
	<h2>변수 삭제하기(Map의 요소 삭제)</h2>
	<c:remove var="c" />
	<div>c: ${c}</div>
	<div>c: ${empty c}</div>
	
	<hr>
	
	<h2>조건문</h2>
	<c:set var="num" value="10" />
	<div>num: ${num}</div>
	
	<c:if test="${num > 0}">
		<div>${num}은 양수입니다.</div>
	</c:if>
	
	<c:if test="${num <= 0}">
		<div>${num}은 양수가 아닙니다.</div>
	</c:if>
	
	
	<!-- 다중 조건문 -->
	<c:choose>
		<c:when test="${num > 0}">양수</c:when>
		<c:when test="${num < 0}">음수</c:when>
		<c:otherwise>영</c:otherwise>
	</c:choose>
	
	<hr>
	<h2>반복문(일반 for + 향상된 for)</h2>
	
	<% for (int i = 0; i < 10; i++) { %>
	<div>숫자: <%= i %></div>
	<% } %>
	
	<c:forEach var="i" begin="1" end="9" step="2">
		<div>숫자: ${i}</div>
	</c:forEach>
	
	<hr>
	
	<%
		String[] names = {"홍길동", "아무개", "하하하", "호호호", "후후후"};
		pageContext.setAttribute("names", names);
	%>
	
	<c:set var="n" value="0" />
	<table>
		<tr>
			<th>이름</th>
		</tr>
		<c:forEach var="name" items="${names}" varStatus="status">
		<tr>
			<td>${name}</td>
			<td>${status.index}</td>
			<td>${n}</td>
			<td>${status.count}</td>
			<td>${status.current}</td>
			<td>${status.first}</td>
			<td>${status.last}</td>
		</tr>
		<c:set var="n" value="${n + 1}" /> <!-- n = n + 1 -->
		</c:forEach>
	</table>
	
	
	

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		
	</script>
</body>
</html>