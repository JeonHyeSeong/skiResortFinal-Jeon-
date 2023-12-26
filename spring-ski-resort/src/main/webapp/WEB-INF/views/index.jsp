<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" href="/resources/css/index.css">
</head>
<body>
	<jsp:include page="common/nav.jsp"></jsp:include>
	<div class="ytLandscape" id="ytLandscape">
		<!-- 	<iframe
			src="https://www.youtube.com/embed/h1VWRkX8vD8?si=hXoOA0167YGh5z27&autoplay=1&mute=1&controls=0&loop=1&playlist=h1VWRkX8vD8&modestbranding=1"
			title="YouTube video player" frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
			allowfullscreen> </iframe> -->

		<!-- 	<iframe
			src="https://www.youtube-nocookie.com/embed/4hESncfGTyE?si=2klehek2I1xT6Nts&autoplay=1&mute=1&loop=1&amp;controls=0" 
			title="YouTube video player" 
			frameborder="0" 
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
			allowfullscreen></iframe> -->

		<iframe width="560" height="315"
			src="https://www.youtube.com/embed/fbqHK8i-HdA?si=x8stsZdudUJ74Zay&autoplay=1&mute=1&loop=1&playlist=fbqHK8i-HdA&modestbranding=1&amp;controls=0&amp;start=250"
			title="YouTube video player" frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			allowfullscreen></iframe>

		<h1 id="maintext1">好き</h1>
		<h1 id="maintext2">DAISUSKI</h1>


		<div id="wrapper">
			<div id="innerItem1"></div>
			<div id="innerItem2"></div>
			<div id="innerItem3"></div>
			<div id="innerItem4"></div>
		</div>
	</div>



	<div class="index-content">

		<!-- index 영상 아래 들어갈 내용은 여기에  -->
		

		<div id="notice-box">
			<div class="tree_img"></div>
			<h1 class="notice-logo">INFORMATION</h1>
			다이스키 스키장은 여러분을 따뜻하게 환영합니다! 여기서는 항상 최신 소식과 중요한 공지사항을 안내해드리고 있습니다. 흥미로운
			이벤트, 신선한 눈 내림 소식, 그리고 스키 조건 업데이트 등을 놓치지 마세요. 스키 체험을 더욱 풍부하게 즐기고자 노력하는
			다이스키와 함께하시어 특별한 순간들을 만들어보세요!
			<div id="notice"></div>
			<a href="/notice/list?type=g&keyword=공지사항"
				style="text-decoration: none">
				<div class="more_information_box">
					MORE INFOMATION <span class="diamond"><i
						class="bi bi-chevron-right"></i> </span>
				</div>
			</a>
			
		</div>


		<div class="rental_resrve_box">
			<div class="rental_resrve_text">
				<p class="mini_title">where to next?</p>
				<div class="box-title rental">LIFT TIKET</div>다이스키 리프트권은 여러분이 편리하게
				스키장을 이용하고 다양한 슬로프를 즐길 수 있는 티켓입니다. 합리적인 가격으로 제공되며, 스키장의 모든 트레일과 슬로프에
				빠르게 입장할 수 있어 스키 체험을 더욱 풍부하게 즐길 수 있습니다. <br><br>
				<a href="/rental/item" class="index_move_text">예약하러 가기</a>
			</div>
			<div class="rental_resrve_right_img"></div>	
		</div>
		
	



		<div class="event-box none-click">
			<p class="box-title event-title">EVENT</p>
			다이스키에서는 매월 다양한 이벤트를 개최합니다! 할인 혜택, 강의, 대회 등 다채로운 활동으로 여러분의 스키 체험을 특별하게 만들어봐요. 최신 정보는 웹사이트와 소셜 미디어를 통해 확인하세요. 흥미진진한 순간들이 기다리고 있습니다!
			<div class="contentBox">
				<div class="slide_wrapper">
					<ul class="slides" id="slides">
					</ul>
				</div>
				
				
				<p class="controls">
					<span class="prev"><i class="bi bi-chevron-compact-left"></i></span>
						 <span class="next"><i
						class="bi bi-chevron-compact-right"></i></span>
				</p>
			</div>
		</div>



	</div>
	
	<jsp:include page="common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	const isOk = parseInt('<c:out value="${isOk}" />');
	if (isOk === 1) {
		alert('쿠폰 지급 완료!!');
	} else if (isOk === 2) {
		alert('이미 받은 쿠폰입니다.');
	}
</script>
<script type="text/javascript" src="/resources/js/index.js"></script>
</html>
