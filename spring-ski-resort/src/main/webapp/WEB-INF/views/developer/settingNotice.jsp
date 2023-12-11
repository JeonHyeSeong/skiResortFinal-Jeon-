<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리자 게시판</title>
<link  href="/resources/css/developer/setting.css" rel="stylesheet">
</head>
<body>
	<div class="devMainContainer">
		<div class="devNav">
			<div class="marquee marquee1">
				  <p class="marquee-text"><img alt="" height="50" src="/resources/etc/line.png"></p>
				</div>
			
		</div>
		
		<div class="devBody">
			
			<jsp:include page="../common/devCategory.jsp"></jsp:include>
			

			<div class="mmmmainContainer">
			<!-- 각자 페이지 개발구역 -->
				<div>
					공지사항 등록하기
				</div>
				<a href="/notice/register">
					<button type="button">글작성</button>
				</a>
			</div>
			
			
		</div>

	
	
	
	</div>
	<script type="text/javascript" src="/resources/js/developer/setting.js"></script>
</body>
</html>