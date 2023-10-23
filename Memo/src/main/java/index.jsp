<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="http://pinnpublic.dothome.co.kr/cdn/example-min.css">
<style>
	
</style>
</head>
<body>
	<!-- index.jsp -->
	
	<h1>인증/허가</h1>
	
	<fieldset>
	<% if (session.getAttribute("auth") == null) { %>
		<input type="button" value="로그인" onclick="location.href='auth/login.jsp'">
		<% } else { %>
		<input type="button" value="로그아웃" onclick="location.href='auth/logoutok.jsp'">
			<div class="message">
				<div>아이디: <%= session.getAttribute("auth") %></div>
				<div>이름: <%= session.getAttribute("name") %></div>
				<div>등급: <%= session.getAttribute("lv").toString().equals("1") ? "일반회원" : "관리자" %></div>
			</div>
		<% } %>
	</fieldset>
	
	<div><%= session.getAttribute("auth") %></div>
	
	<hr>
	<!-- 회원 전용 페이지 -->
	<% if (session.getAttribute("auth") != null) { %>
	<a href="member/member.jsp">회원 페이지</a>
	<% } %>
	
	<hr>
	<% if (session.getAttribute("auth") != null) { %>
		<div><a href="member/member.jsp">회원 페이지</a></div>
		<% } else { %>
		<div><a href="#!" onclick="alert('로그입한 회원만 접근 가능합니다.')">회원 페이지</a></div>
		<% } %>
		
	<!-- 관리자 전용 페이지 -->
	<%if (session.getAttribute("aut") != null && session.getAttribute("lv").toString().equals("2"))  {%>
	<div><a href="admin/admin.jsp">관리자 페이지</a></div>
	<%}  %>
	

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="http://pinnpublic.dothome.co.kr/cdn/example-min.js"></script>
	<script>
		
	</script>
</body>
</html>