<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#bi-gear-fill{
		font-size: 10px;
	}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
 
 <link rel="stylesheet" href="/resources/css/nav.css">

 <!-- Moment.js -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.29.1/locale/ko.js"></script> <!-- 한국어 locale 파일 추가 -->
</head>
<body>
<div class="navContainer">
	
	<div class="weatherContainer">
		<div class="weatherBox" id="weatherBox">
			<button class="half-moon-btn" id="half-moon-btn" onclick="weatherBtn()"> <img alt="" src="/resources/etc/눈사람.png" width="40" height="65"> </button>
			<div class="weatherList" id="weatherList">
				
			</div>
		
		</div>
	</div>

	<nav class="ski-navbar" id="ski-navbar">
	<nav id="hide"></nav>
  
  <div class="ski-collapse">
<!--     <a class="ski-navbar-brand" id="ski-navbar-brand" href="/">
    	<img width="40" height="40" src="/resources/etc/icons/ski-icon.png">다이스키<span class="nav-ani"></span>
    </a> -->
       <div class="ski-nav-link" id="ski-nav-link"><a href="/notice/list"> NEWS <span class="nav-ani"></span></a></div>
       <div class="ski-nav-link" id="ski-nav-link"><a href="/resort/resortForm"> RESORT <span class="nav-ani"></span></a></div>
       <div class="ski-nav-link" id="ski-nav-link"><a href="/rental/item">SKI / RENTAL <span class="nav-ani"></span></a></div>
    		<span class="main-title-logo"><a href="/"><img alt="" width="110" height="90" src="/resources/etc/logo_white.png"></a> </span>
       <div class="ski-nav-link" id="ski-nav-link"><a href="/hotel/reservation"> RESERVATION <span class="nav-ani"></span></a></div>
       <div class="ski-nav-link" id="ski-nav-link"><a href="/qna/list"> SERVICE <span class="nav-ani"></span></a></div>
       <div class="ski-nav-link" id="ski-nav-link"><a href="/bus/busReserve"> BUS <span class="nav-ani"></span></a></div>
       <!-- <div class="ski-nav-link" id="ski-nav-link"><a href="/pay/testForm"> 작업실 <span class="nav-ani"></span></a></div> -->
       <ul class="ski-side-navbar">
       	<sec:authorize access="isAnonymous()">
	       	<li><a href="/member/login">로그인</a></li>
	       	<li><a href="/member/register">회원가입</a></li>
	    </sec:authorize>
        <sec:authorize access="isAuthenticated()">
        	<sec:authentication property="principal.mvo.memberNum" var="authNum"/>
        	<sec:authentication property="principal.mvo.memberId" var="authId"/>
        	<sec:authentication property="principal.mvo.memberEmail" var="authEmail"/>
        	<sec:authentication property="principal.mvo.memberAlias" var="authAlias"/>
        	<sec:authentication property="principal.mvo.memberType" var="authType"/>
        	<sec:authentication property="principal.mvo.authList" var="auths"/>
        	
        	<c:if test="${authType == 'normal' }">
	       		<li>${authId}님 환영합니다.</li>
		       	<li><a href="/member/detail">회원정보</a></li>
        	</c:if>
        	<c:if test="${authType == 'naver' }">
	       		<li>(네이버)${authEmail}님 환영합니다.</li>
	       		<li><a href="/member/detail">| 회원정보</a></li>
        	</c:if>
        	<c:if test="${authType == 'kakao' }">
	       		<li>(카카오)${authEmail}님 환영합니다.</li>
	       		<li><a href="/member/detail">| 회원정보</a></li>
        	</c:if>
        	<c:if test="${authType == 'google' }">
	       		<li>(구글)${authEmail}님 환영합니다.</li>
		       	<li><a href="/member/detail">| 회원정보</a></li>
        	</c:if>
	       	<li><a href="/member/logout">| 로그아웃</a></li>
     
	      	<div class="member-alarm" id="alarm-bell">
	      		<i class="bi bi-bell-fill position-relative" id=""><span class="alarm-bell-deco" id="alarm-mini-bell"></span></i>
	      	</div>
			
			<div class="member-alarm-board" id="alarm-board">
				<div ><a class="alarm-board-title" id="alarm-board-title" href="/alarm/memberAlarmList">자세히보기</a></div>
				
				<div class="alarm-board-body" id="alarm-spread">
					
				
				</div>
				
			</div>
			
	       	<!-- admin 관리페이지 -->
            <c:if test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">
	       	  <li class="admin-page-icon">
			   		<a class="developer_page" href="/developer/settingMain" ><i class="bi bi-gear-fill" id="bi-gear-fill"></i></a>
               </li>  
            </c:if>
			
     
		</sec:authorize>
       </ul>
  </div>
</nav>
</div>
<!-- <div class="ski-blank" id="ski-blank"></div> -->
<script type="text/javascript" src="/resources/js/nav.js" ></script>
