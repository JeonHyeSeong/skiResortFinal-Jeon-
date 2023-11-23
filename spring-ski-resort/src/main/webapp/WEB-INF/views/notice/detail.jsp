<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/notice/notice_detail.css">
</head>
<body>
<jsp:include page="../common/nav.jsp" />
	<div class="notice-img-container" style="background-image: url('https://a.cdn-hotels.com/gdcs/production68/d766/4cc034a7-aeb1-4edd-b2a9-f7feaac49aec.jpg')">	</div>
	
	<div class="container notice-container">
	<br>
	<h2>공지사항</h2>
	<br>
	<table class="table table-hover">
		<tr>
			<th>카테고리</th>
			<td>${nvo.noticeCategory}</td>
		</tr>	
		<tr>
			<th>제목</th>
			<td>${nvo.noticeTitle }</td>
		</tr>	
		<tr>
			<th>작성자</th>
			<td>${nvo.noticeWriter }</td>
		</tr>	
		<tr>
			<th>등록일</th>
			<td>${nvo.noticeRegAt }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${nvo.noticeContent }</td>
		</tr>

	</table>	
	
	<a href="/notice/list">
		<button type="button" class="btn btn-dark">리스트</button>
	</a>
	<a href="/notice/modify?noticeNum=${nvo.noticeNum }">
		<button type="button" class="btn btn-dark">수정</button>
	</a>
	</div>
<jsp:include page="../common/footer.jsp" />	
</body>
</html>