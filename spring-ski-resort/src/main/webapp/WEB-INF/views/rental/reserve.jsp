<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>

	<!-- Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

    <!-- Bootstrap 4 JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <!-- Moment.js -->
    <script src="https://cdn.jsdelivr.net/npm/moment@2.29.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.29.1/locale/ko.js"></script> <!-- 한국어 locale 파일 추가 -->

    <!-- DateRangePicker CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker@3.1.0/daterangepicker.css" />


    <!-- DateRangePicker JS -->
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker@3.1.0/daterangepicker.min.js"></script>
   	<!-- GppgleFont -->
   	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">


	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
	
	<link rel="stylesheet" href="/resources/css/rental/reserve.css">
	<link rel="stylesheet" href="/resources/css/coupon/coupon.css">
	<link rel="stylesheet" href="/resources/css/pay/pay_modal.css">
	
	

<body>
	<jsp:include page="../common/nav.jsp" />
	
		
<!-- Modal -->

			
<div class="modal fade" id="hotel-pay" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content ">
      <div class="modal-header">
      	
        <h1 class="modal-title fs-5" id="staticBackdropLabel">결제선택하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pay-info">
      	<div>상품명<div class="pay-value" id="item-name"></div></div>
      	<div>판매자  <div class="pay-value">다이스키</div></div>
      	<div>등급<div class="pay-value" id="userGradeRate"></div></div>
	    <div class="pay3-box">결제금액<div class="pay-value" id="userViewpay"></div></div> 
  
      </div>
      <div class="pay-method">
            <button id="inicis_pay" onclick="paymentGateway('html5_inicis')" type="button"> <span>통합결제 </span></button>
            <button id="kakao_pay"  onclick="paymentGateway('kakaopay.TC0ONETIME')" type="button"> <span>카카오</span> </button>            
            <button id="toss_pay" onclick="paymentGateway('tosspay.tosstest')" type="button"> <span>토스페이 </span></button>           
            <button id="payco_pay" onclick="paymentGateway('payco.AUTOPAY')" type="button"><span>페이코</span></button>
            <button id="naver_pay" ><span>네이버페이</span></button>
            <hr>
            <button id="my_coupon_list" value="openWorld" type="button"> <span>쿠폰</span></button>
            
			<div id="myCouponListBody" class="myCouponListBody">
				 <div class="myCouponListTitle">
				 	<span><i class="bi bi-envelope-paper-heart-fill"></i> 내 쿠폰함</span> 
				 </div>
				 <div class="myCouponList" id="myCouponList">
				 	
				 </div>
			</div>
			
      </div>
    </div>
  </div>
</div>
	
	
	
	<div class="back">
		<img data-v-c62ee4ac="" src="https://i.imgur.com/pclh9Jp.jpg" alt="">
		
		<div class="box">
			<p class="fs-3  rentalText"><a class="move-hotel" href="/hotel/reservation">호텔예약</a>/리프트권 예약</p>
			<form action="/rental/reserve" method="post" id="payform">
				<div class="input-box">
					<input type="hidden" name="rentalLiftStart" id="rentalLiftStart" placeholder="렌탈이용날짜">
					<input name="rentalLiftAdult" id="rentalLiftAdult" value="0" placeholder="성인인원" type="hidden">
					<input name="rentalLiftKid" id="rentalLiftKid" value="0" placeholder="어린이인원" type="hidden">
					
					
					<div class="date-group">
						<div class="input-group calendar">
		              	 	<div class="input-group-prepend">
		                		 <span class="input-group-text"><i class="bi bi-calendar"></i></span>
		                	</div>
							<input type="text" class="form-control" id="dateRangePicker" placeholder="날짜를 선택하세요" readonly="readonly">
						</div>
					</div>
					
					
					<div class="input-box1">
						<div class="input-group mb-3">
							<span class="input-group-text" id="basic-addon1"><i class="bi bi-person-fill"></i></span>
							<input type="text" id="people" class="form-control people" placeholder="인원수" aria-label="Username" readonly="readonly" aria-describedby="basic-addon1" onclick="addAudltCnt(0)">
							<button id="nextBtn" type="button" class="btn btn-light">다음</button>
						</div>
						<div class="peopleList"  id="peopleList" style="display: none;">
		  					<div class="list-Btn-Box">
		  						성인    
		  						<div class="people-Btn"> 
			  						<div>
			  							<button type="button" onclick="addAudltCnt(-1)">
			  								<svg style="width: 14px; height: 14px; xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M20.25 12.75H3.75a.75.75 0 0 1 0-1.5h16.5a.75.75 0 0 1 0 1.5z"></path></svg>
			  							</button>
			  						</div> 	 
			  						<div id="audlt-Count">
			  							1
			  						</div> 
			  						
			  						<div>
			  							<button type="button" onclick="addAudltCnt(1)">
			  							<svg style="width: 14px; height: 14px; xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M20.25 11.25h-7.5v-7.5a.75.75 0 0 0-1.5 0v7.5h-7.5a.75.75 0 0 0 0 1.5h7.5v7.5a.75.75 0 0 0 1.5 0v-7.5h7.5a.75.75 0 0 0 0-1.5z"></path></svg>
			  							</button>
			  						</div> 
		  						</div> 
		  					</div>
		  					
		  					<div class="list-Btn-Box">
		  						어린이
		  						<div class="people-Btn"> 
			  						<div>
			  							<button type="button" id="child-Btn">
			  								<svg style="width: 14px; height: 14px; xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M20.25 12.75H3.75a.75.75 0 0 1 0-1.5h16.5a.75.75 0 0 1 0 1.5z"></path></svg>
			  							</button>
			  						</div> 
			  						 
			  						<div id="child-Count">
			  							0
			  						</div> 
			  						<div>
			  							<button type="button" id="child+Btn">
			  							<svg style="width: 14px; height: 14px; xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M20.25 11.25h-7.5v-7.5a.75.75 0 0 0-1.5 0v7.5h-7.5a.75.75 0 0 0 0 1.5h7.5v7.5a.75.75 0 0 0 1.5 0v-7.5h7.5a.75.75 0 0 0 0-1.5z"></path></svg>
			  							</button>
			  						</div> 
		  						</div> 
		  					</div>
	  						<div>
	  							<button id="peoplelistClose" type="button" class="btn btn-outline-primary">닫기</button>
	  						</div>
	  					
	  					</div>
					</div>	
				</div>
				
				
				
				<div id="innerbox" class="reserveBox" style="display: none;">
					<input id="memberGradeInput" type="hidden" value="${mvo.memberGrade }">
					
					<div class="form-check" id="tiketImg1" onclick="getDivId(this)">
						<img alt="" onclick="updateFees(40000,30000,'오전권')" src="/resources/etc/티켓.png" style="width: 270px; height: 80px;"><span>오전권</span>
					  <input class="form-check-input" onclick="updateFees(40000,30000,'오전권')" type="radio" name="rentalLiftTicket" value="오전권" id="morningTicket">
					</div>
					<div class="form-check" id="tiketImg2" onclick="getDivId(this)">
						<img alt="" onclick="updateFees(50000,40000,'오후권')" src="/resources/etc/티켓.png" style="width: 270px; height: 80px;"><span>오후권</span>
					  <input class="form-check-input" onclick="updateFees(50000,40000,'오후권')" type="radio" name="rentalLiftTicket" value="오후권" id="afternoonTicket">
					</div>
					<div class="form-check" id="tiketImg3" onclick="getDivId(this)">
						<img alt="" onclick="updateFees(60000,50000,'주간권')" src="/resources/etc/티켓.png" style="width: 270px; height: 80px;"><span>주간권</span>
					  <input class="form-check-input" onclick="updateFees(60000,50000,'주간권')" type="radio" name="rentalLiftTicket" value="주간권" id="dayTimeTicket">
					</div>
					<div class="form-check" id="tiketImg4" onclick="getDivId(this)">
						<img alt="" onclick="updateFees(40000,30000,'야간권')" src="/resources/etc/티켓.png" style="width: 270px; height: 80px;"><span>야간권</span>
					  <input class="form-check-input" onclick="updateFees(40000,30000,'야간권')" type="radio" name="rentalLiftTicket" value="야간권" id="nightTimeTicket">
					</div>
					<div class="form-check" id="tiketImg5" onclick="getDivId(this)">
						<img alt="" onclick="updateFees(75000,65000,'종일권')" src="/resources/etc/티켓.png" style="width: 270px; height: 80px;"><span>종일권</span>
					  <input class="form-check-input" onclick="updateFees(75000,65000,'종일권')" type="radio" name="rentalLiftTicket" value="종일권" id="allDayTicket">
					</div>
					<div class="form-check" id="tiketImg6" onclick="getDivId(this)">
						<img alt="" onclick="updateFees(380000,350000,'시즌권')" src="/resources/etc/티켓.png" style="width: 270px; height: 80px;"><span>시즌권</span>
					  <input class="form-check-input" onclick="updateFees(380000,350000,'시즌권')" type="radio" name="rentalLiftTicket" value="시즌권" id="seasonTicket">
					</div>
					
					<div class="input-group mb-3">
						<span class="input-group-text" id="basic-addon1"><i class="bi bi-credit-card"></i></span>
						<input type="text" class="form-control" id="showadultFee" readonly="readonly" placeholder="성인요금">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="bi bi-credit-card"></i></span>
						<input type="text" class="form-control" id="showkidFee" readonly="readonly" placeholder="어린이요금">
						
					</div>
					<!-- db로 보낼 hiddem input  -->
					
						<input type="hidden" name="rentalLiftAdultFee" id="adultFee" value="0" readonly="readonly">
						<input type="hidden" name="rentalLiftKidFee" id="kidFee" value="0" readonly="readonly">
						<input type="hidden" name="rentalLiftTotalFee" id="realpayvalue">
						<input type="hidden" name="memberNum" placeholder="회원번호" value="${mvo.memberNum }">	
						<input type="hidden" name="payImpUid" id="payImpUid">	
						<input type="hidden" name="payMerchantUid" id="payMerchantUid">	
						<input type="hidden" name="payAmount" id="payAmount">
						<input type="hidden" name="payName" id="payName">		
						<input type="hidden"  id="name-type" value="리프트">	
						<input type="hidden" id="productPrice">	
						<input type="hidden" name="couponCode" id="couponCode" >

					<a href="/rental/reserve"><button type="button" class="btn btn-outline-primary">이전으로</button></a>
						<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#hotel-pay" onclick="usecoupon(0, 0, 0)">결제</button>
				</div>
			</form>
		</div>
		
		<div class="contentContainer">
			
			<div class="content1">
			
			<div class="contentBox">
				<p class="fs-1 rentalText">DAISUSKI Lift Reserve</p>
				<div class="liftTicketInfo">
					<div>
						<img src="https://i.imgur.com/gvc8s1d.png" style="width: 500px; height: 200px;">
						<p class="fs-4">리프트 오전권<br>Adult 40,000<br> Kid 30,000</p>
					</div>
					<div>
						<img src="https://i.imgur.com/gvc8s1d.png" style="width: 500px; height: 200px;">
					<p class="fs-4">리프트 오후권<br>Adult 50,000<br> Kid 40,000</p>
					</div>
					<div>
						<img src="https://i.imgur.com/gvc8s1d.png" style="width: 500px; height: 200px;">
					<p class="fs-4">리프트 주간권<br>Adult 60,000<br> Kid 50,000</p>
					</div>
					<div>
						<img src="https://i.imgur.com/gvc8s1d.png" style="width: 500px; height: 200px;">
					<p class="fs-4">리프트 야간권<br>Adult 40,000<br> Kid 30,000</p>
					</div>
					<div>
						<img src="https://i.imgur.com/gvc8s1d.png" style="width: 500px; height: 200px;">
					<p class="fs-4">리프트 종일권<br>Adult 75,000<br> Kid 65,000</p>
					</div>
					<div>
						<img src="https://i.imgur.com/gvc8s1d.png" style="width: 500px; height: 200px;">
					<p class="fs-4">리프트 시즌권<br>Adult 380,000<br> Kid 350,000</p>
					</div>
				</div>
			</div>
			<div class="liftInfo">
				<p class="fs-1 rentalText">리프트권 유의사항</p>
				<div>
					<ul>
						<li>1. 리프트권은 장비렌탈이 포함되지 않습니다.</li>
						<li>2. 리프트권은 회원당 1회만 구매 가능합니다.</li>
						<li>3. 회차당 일괄 발권만 가능하며 부분 발권 및 교환, 환불은 불가합니다</li>
						<li>4. 리프트권은 미사용 시 환불 처리되지 않습니다.</li>
						<li>5. 23/24 스노우 시즌 셔틀버스는 별도 예약이 필요합니다.</li>
						<li>6. 발권된 티켓은 당일 사용만 가능하며, 미사용 티켓에 한하여 30분내에 환불 또는 교환 가능합니다.</li>
						<li>7. 사용하신 리프트권은 티켓 수거함에 넣어주세요.</li>
					</ul>
				</div>
			</div>
			
			</div>
		</div>
		
		<div class="skiSlopeContainer">
			<div>
				<h1>슬로프 안내</h1>
				<img alt="" src="https://i.imgur.com/ecmOiSx.png">
			</div>
		</div>
		
		
	</div>
	<script type="text/javascript">
	
	const isOk = `<c:out value="${isOk}" />`;
	if(isOk == 1){
		alert('리프트권 구매후 결제해주세요.');
	}
	var itemsArray = [];
	const memberEmail= `<c:out value="${mvo.memberEmail}"/>`;
	const memberName= `<c:out value="${mvo.memberName}"/>`;
	const memberPhoneNum= `<c:out value="${mvo.memberPhoneNum}"/>`;
	const memberAddress= `<c:out value="${mvo.memberAddress}"/>`;
	let realAmount = 0;
	</script>
	<script type="text/javascript" src="/resources/js/pay/pay.js"></script>
	<script type="text/javascript" src="/resources/js/coupon/coupon.js"></script>
	<script type="text/javascript" src="/resources/js/rental/reserve.js"></script>
	
	<jsp:include page="../common/footer.jsp"></jsp:include>

	
</body>
</html>