<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>
<style type="text/css">
	
	.formContainer{
		margin-top: 120px;
		display: flex;
		justify-content: center;
	}
	
	span{
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="../common/nav.jsp" />

	
	<div class="formContainer">
		<form action="/rental/reserve" method="post">
			<div class="input-group mb-3">
				<span class="input-group-text">이름</span>
				<input type="text" class="form-control" name="memberName">
			</div>
			<div>
				<span class="input-group-text">장비선택</span>
				<input type="checkbox" class="form-check-input">
				<label class="form-check-label">스키/보드</label>
				<input type="checkbox" class="form-check-input">
				<label class="form-check-label">헬멧/보호대</label>
				<input type="checkbox" class="form-check-input">
				<label class="form-check-label">의류</label>
			</div>
		</form>
	</div>
</body>
</html>