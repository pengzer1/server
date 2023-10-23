<%@page import="java.sql.ResultSet"%>
<%@page import="com.test.jdbc.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// edit.jsp
	
	// 1. 데이터 가죠오기(seq)
	// 2. DB 작업 > update
	// 3. 피드백
	
	// 1.
	String seq = request.getParameter("seq");
	
	// 2.
	Connection conn = null;
	PreparedStatement stat = null;
	
	try {
		
		conn = DBUtil.open();
		
		// n > y
		// y > n
		
		String sql = "";
		
		sql = "select state from tblTodo where seq = ?";
		
		stat = conn.prepareStatement(sql);
		stat.setString(1, seq);
		
		ResultSet rs = stat.executeQuery();
		String state = "";
		
		if (rs.next()) {
			state = rs.getString("state");
		}
		
		if (state.equals("n")) {
			state = "y";
		} else {
			state = "n";
		}
		
		sql = "update tblTodo set state = ? where seq = ?";
		
		stat = conn.prepareStatement(sql);
		stat.setString(1, state);
		stat.setString(2, seq);
		
		int result = stat.executeUpdate();
		
		if (result == 1) {
			response.sendRedirect("list.jsp");
		} else {
			out.println("<script>");
			out.println("alert('failed');");
			out.println("location.href= 'list.jsp';");
			out.println("</script>");
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="inc/asset.jsp" %>
<style>
	
</style>
</head>
<body class="narrow">
	<!-- template.jsp -->
	<%@ include file="inc/header.jsp" %>

	<script>
		
	</script>
</body>
</html>