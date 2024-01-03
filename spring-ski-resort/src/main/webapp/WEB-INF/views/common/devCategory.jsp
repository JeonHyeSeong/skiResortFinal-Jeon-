<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>
<body>

		<div class="devCategory">
				<div class="ul-magin">
					<a href="/developer/settingMain"><img alt="" width="230" height="220" src="/resources/etc/logo_white.png"></a>
				</div>
				
				<div class="category-menu menu1">
					<button class="menu-btn btn btn-light" id="menu-Btn1">
						<i class="bi bi-person-fill-gear"></i>
						<span>회원/쿠폰 관리</span>
					</button>
					<ul id="ul-menu1">
						<li>
							<a href="/developer/settingMember"><span>회원목록</span></a>
						</li>
						<li>
							<a href="/developer/settingCoupon"><span>쿠폰관리</span></a>
						</li>
					</ul>
				</div>
				<div class="category-menu menu2">
					<button class="menu-btn btn btn-light" id="menu-Btn2">
						<i class="bi bi-house-gear-fill"></i>
						<span>호텔 관리</span>
					</button>
					<ul id="ul-menu2">
						<li>
						
							<a href="/developer/settingHotel"><span>객실관리</span></a>
						</li>
						<li>
							<a href=""><span>호텔정산</span></a>
						</li>
					</ul>
				</div>
				<div class="category-menu menu3">
					<button class="menu-btn btn btn-light" id="menu-Btn3">
						<i class="bi bi-box2-fill"></i>
							<span>렌탈/리프트 관리</span>
						</button>
					<ul id="ul-menu3">
						<li>
							<a href="/developer/settingRental"><span>렌탈관리</span></a>
						</li>
						<li>
							<a href=""><span>리프트관리</span></a>
						</li>
						<li>
							<a href=""><span>렌탈/리프트정산</span></a>
						</li>
					</ul>
				</div>
				<div class="category-menu menu4">
					<button class="menu-btn btn btn-light" id="menu-Btn4">
						<i class="bi bi-clipboard-plus-fill"></i>
						<span>게시판 관리</span>
					</button>
					<ul id="ul-menu4">
						<li>
							<a href="/developer/settingNotice"><span>공지사항</span></a>
						</li>
						<li>
							<a href="/developer/settingQna"><span>문의</span></a>
						</li>
						<li>
							<a href=""><span>버스</span></a>
						</li>
					</ul>
				</div>
				<div class="category-menu">
					 <a href="/"><button type="button" class="btn btn-danger menu5"><span>메인으로</span></button></a>
				</div>
			</div>


</body>
</html>