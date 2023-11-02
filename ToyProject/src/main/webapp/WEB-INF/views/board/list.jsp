<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<style>
	#list th:nth-child(1) { width: 50px; }
	#list th:nth-child(2) { width: auto; }
	#list th:nth-child(3) { width: 70px; }
	#list th:nth-child(4) { width: 120px; }
	#list th:nth-child(5) { width: 50px; }
	
	#list td { text-align: center; height: 25px; }
	#list td:nth-child(2) { text-align: left; }
	
	.is-new {
		font-size: 14px;
		color: tomato;
	}
	
	#search-form {
		text-align: center;
		margin-bottom: 15px;
	}
</style>
</head>
<body>
	<!-- list.jsp -->
	<%@ include file="/WEB-INF/views/inc/header.jsp" %>
	<main id="main">
		<h1>게시판 <small>
		<c:if test="${map.search=='n'}">
			목록보기
		</c:if>
		<c:if test="${map.search=='y'}">
			검색결과
		</c:if>
		</small></h1>
		
		<table id="list">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>이름</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.seq}</td>
				<td>
					<a href="/toy/board/view.do?seq=${dto.seq}&search=${map.search}&column=${map.column}&word=${map.word}">${dto.subject}</a>
					<c:if test="${dto.isnew == 1}">
					<span class='is-new'>new</span>
					</c:if>
				</td>
				<td>${dto.name}</td>
				<td>${dto.regdate}</td>
				<td>${dto.readcount}</td>
			</tr>
			</c:forEach>
			
		</table>
		
		<!-- 검색 -->
		<form id="search-form" action="/toy/board/list.do" method="GET">
			<select name="column">
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<option value="name">이름</option>
			</select>
			<input type="text" name="word" class="long" required>
			<input type="submit" value="검색하기">
		</form>
		
		<div>
			<button type="button" class="list" onclick="location.href='/toy/board/list.do'">목록보기</button>
			<c:if test="${not empty id}">
			<button type="button" class="add primary" onclick="location.href='/toy/board/add.do'">글쓰기</button>
			</c:if>
		</div>
		
	</main>

	<script>
		<c:if test="${map.search == 'y'}">
		$('select[name=column]').val('${map.column}');
		$('input[name=word]').val('${map.word}');
		</c:if>
	</script>
</body>
</html>