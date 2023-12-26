<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이스키 공지사항 목록</title>
<jsp:include page="../common/nav.jsp" />
<link rel="stylesheet" href="/resources/css/notice/notice_list.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300&display=swap" rel="stylesheet">

<c:forEach items="${plist }" var="pnvo" varStatus="status">
<style type="text/css">
	.section input[id="slide0${status.count}"]:checked ~ .slidewrap .slidelist > li {
		transform:translateX(-${status.count-1}00%);
		}
	.section input[id="slide0${status.count}"]:checked ~ .slidewrap li:nth-child(${status.count}) .slide-text-title {
		opacity:1;
		transform:translateY(0);
		transition-delay:.2s;
		}
	.section input[id="slide0${status.count}"]:checked ~ .slidewrap li:nth-child(${status.count}) .slide-main-text {
		opacity:1;
		transform:translateY(0);
		transition-delay:.1s;
		}
	.section input[id="slide0${status.count}"]:checked ~ .slidewrap li:nth-child(${status.count}) .slide-text-subcontent {
		opacity:1;
		transform:translateY(0);
		transition-delay:.4s;
		}
	.section input[id="slide0${status.count}"]:checked ~ .slidewrap .slide-control > div:nth-child(${status.count}) {
		display:block;
		}
	.section input[id="slide0${status.count}"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(${status.count}) > label > div > img{
		filter: brightness(150%);
		box-shadow: 0px 0px 9px 6px #5b5b5b;
		}
</style>
</c:forEach>
</head>


<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.authList" var="auths"/>
	<sec:authentication property="principal.mvo.memberId" var="authId"/>
	<sec:authentication property="principal.mvo.memberEmail" var="authEmail"/>
	<sec:authentication property="principal.mvo.memberType" var="authType"/>
</sec:authorize>


<!-- <div class="notice-img-container" style="background-image: url('https://www.wallpaperflare.com/static/303/362/478/snowboarding-trick-jump-snow-wallpaper.jpg')">	</div>
 -->
<!-- 슬라이드 라인 -->
<c:set value="${plist }" var="pnvo"></c:set>
 <div class="section">
 	<c:forEach items="${plist }" var="pnvo" varStatus="status">
 		<c:choose>
 			<c:when test="${status.count == 1 }">
 				<input type="radio" name="slide" id="slide01" checked>
 			</c:when>
 			<c:otherwise>
 				<input type="radio" name="slide" id="slide0${status.count}">
 			</c:otherwise>
 		</c:choose>
 	</c:forEach>
 	
	<div class="slidewrap">
		<ul class="slidelist">
			<!-- 슬라이드 영역 -->
			<c:forEach items="${plist }" var="pnvo" varStatus="status">
				<c:forEach items="${fvo }" var="fvo">					
					<c:if test="${fvo.noticeNum == pnvo.noticeNum }">
						<li class="slideitem">
						<a class="notice-a-hover" href="/notice/detail?noticeNum=${pnvo.noticeNum }">
							<img alt="그림이 없음." src="/upload/${fn: replace(fvo.fileSave,'\\','/')}/${fvo.fileUuid}_${fvo.fileName}">
							<div class="slide-main-text">
								<h1>2023-24<br>Winter Season</h1>
							</div>
							<div class="textbox">
								<h3 class="slide-text-title">${pnvo.noticeTitle }</h3>
								<div class="slide-text-subcontent">${pnvo.noticeSubcontent }
<!-- 								<p class="slide-text-subcontent"></p> -->
								</div>
							</div>
						</a>
						</li>					
					</c:if>
				</c:forEach>
			</c:forEach>

				<!-- 좌,우 슬라이드 버튼 -->
				<div class="slide-control">
					<c:forEach items="${plist }" var="pnvo" varStatus="status">
						<c:choose>
							<c:when test="${status.count == 1 }">
								<div>
									<label for="slide0${fn:length(plist) }" class="left"></label>
									<label for="slide0${(status.count)+1 }" class="right"></label>
								</div>
							</c:when>
							<c:when test="${status.count eq fn:length(plist) }">
								<div>
									<label for="slide0${(status.count)-1 }" class="left"></label>
									<label for="slide01" class="right"></label>
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<label for="slide0${(status.count)-1 }" class="left"></label>
									<label for="slide0${(status.count)+1 }" class="right"></label>
								</div>
							</c:otherwise>	
						</c:choose>	
					</c:forEach>	
				</div>
		</ul>
		
		<!-- 페이징 -->
		<ul class="slide-pagelist">
			<c:forEach items="${plist }" var="pnvo" varStatus="status">
				<li><label for="slide0${status.count}">
					<c:forEach items="${fvo }" var="fvo">					
						<c:if test="${fvo.noticeNum == pnvo.noticeNum }">
							<div class="slide-pagelist-img-box">
								<img alt="그림이 없음." src="/upload/${fn: replace(fvo.fileSave,'\\','/')}/${fvo.fileUuid}_th_${fvo.fileName}">
							</div>
						</c:if>
					</c:forEach>
				</label></li>
			</c:forEach>
		</ul>	  	
	</div>
</div>







	
<div class="container notice-container" id="notice-container">
<c:set value="${ph.pgvo.type }" var="typed"></c:set>

	<div class="notice-menu-container">
	  <div class="notice-menu-container-child">
	  
 
	  
	  
		
		

		<!-- 카테고리 라인 -->
	  <div class="notice-category-containeer">
		<div class="notice-category">
		<ul class="nav justify-content-center" id="myTab" role="tablist">	
			  <li class="nav-item" role="presentation">
			  	<form action="/notice/list" method="get">
			  	<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="">
			    <button class="nav-link active" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    All</button>
			    </form>
			  </li>
		  <li class="nav-item" role="presentation">
			  	<form action="/notice/list" method="get">
			  	<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="공지사항"> 
			    <button class="nav-link notice-category-btn" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    Notice</button>
			  	</form>
		  </li>
		  <li class="nav-item" role="presentation">
		  		<form action="/notice/list" method="get">
		  		<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="이벤트">
			    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    Event</button>
			    </form>
		  </li>
		  <li class="nav-item" role="presentation">
		  		<form action="/notice/list" method="get">
		  		<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="보도자료">
			    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    News</button>
			    </form>
		  </li>
		  <li class="nav-item" role="presentation">
		  		<form action="/notice/list" method="get">
		  		<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="쇼핑몰">
			    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    Shopping mall</button>
			    </form>
		  </li>
		  <li class="nav-item" role="presentation">
		 		<form action="/notice/list" method="get">
		  		<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="채용정보">
			    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    Recruitment</button>
			    </form>
		  </li>
		  <li class="nav-item" role="presentation">
		  		<form action="/notice/list" method="get">
		  		<input type="hidden" name="type" value="g" ${typed eq 'g' ? 'selected' : '' }>
			  	<input type="hidden" name="keyword" type="search" value="기타">
			    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="submit" role="tab" aria-controls="contact-tab-pane" aria-selected="false">
			    Other</button>
			    </form>
		  </li>
		</ul>
		</div>
	  </div>
	  
	  
	  
	  
	  
	  <%-- <!-- 임시  -->
	  <table class="table notice-table"  >
		  <thead class="table-light" >
		    <tr class="notice-table-tr">
		      <th scope="col" class="notice-table-th-no"><div class="notice-table-td-child">번호</div></th>
		      <th scope="col" class="notice-table-th-cago"><div class="notice-table-td-child">카테고리</div></th>
		      <th scope="col" class="notice-table-th-title"><div class="notice-table-td-child">제목</div></th>
		      <th scope="col" class="notice-table-th-writer"><div class="notice-table-td-child">작성자</div></th>
		      <th scope="col" class="notice-table-th-reg"><div class="notice-table-td-child">등록일</div></th>
		      <th scope="col" class="notice-table-th-count"><div class="notice-table-td-child">조회</div></th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:forEach items="${plist }" var="pvo">
		  <c:if test="${ph.pgvo.keyword == '' || ph.pgvo.keyword == null || ph.pgvo.keyword == '공지사항' || ph.pgvo.keyword == '이벤트' || ph.pgvo.keyword == '보도자료' || ph.pgvo.keyword == '쇼핑몰' || ph.pgvo.keyword == '채용정보' || ph.pgvo.keyword == '기타' }">
		    <tr class="notice-table-tr">
		      <td class="notice-table-td"><div class="notice-table-td-child"><span class="material-symbols-outlined" style="color: red;">campaign</span></div></td>
		      <td class="notice-table-td"><div class="notice-table-td-child">${pvo.noticeCategory }</div></td>
		      <td class="notice-table-td"><div class="notice-table-td-child-title"><a href="/notice/detail?noticeNum=${pvo.noticeNum }">${pvo.noticeTitle }</a></div></td>
		      <td class="notice-table-td"><div class="notice-table-td-child">${pvo.noticeWriter }</div></td>
		      <td class="notice-table-td"><div class="notice-table-td-child">${fn:replace((fn:substring(pvo.noticeRegAt,0,10)),'-','.') }</div></td>
		      <td class="notice-table-td"><div class="notice-table-td-child">${pvo.noticeCount }</div></td>
		    </tr>
		  </c:if>
		  </c:forEach>  
		  </tbody>
		</table>   --%>
	  
	  	
	  
	  
	  
		
		<!-- 리스트 라인 -->
		<article>
			<c:forEach items="${list }" var="nvo">
			<section class="notice-list-container">
			<div class="notice-list-box">
				<a href="/notice/detail?noticeNum=${nvo.noticeNum }">
					<div class="notice-list-img-container">	
				      	  <c:forEach items="${fvo }" var="fvo">
				      		<c:if test="${fvo.noticeNum == nvo.noticeNum }">
				      			<div class="notice-list-imgbox"><img alt="그림이 없음." src="/upload/${fn: replace(fvo.fileSave,'\\','/')}/${fvo.fileUuid}_th_${fvo.fileName}"></div>
				      		</c:if>
				      	  </c:forEach>		      			
					</div>						
					<div class="notice-list-inpo">
						<span class="notice-list-category">
							<c:if test="${nvo.noticeCategory=='공지사항' }">
								<span style="background-color: #005280;">${nvo.noticeCategory }</span>
							</c:if>
							<c:if test="${nvo.noticeCategory=='이벤트' }">
								<span style="background-color: #800040;">${nvo.noticeCategory }</span>
							</c:if>
							<c:if test="${nvo.noticeCategory=='보도자료' }">
								<span style="background-color: #002480;">${nvo.noticeCategory }</span>
							</c:if>
							<c:if test="${nvo.noticeCategory=='쇼핑몰' }">
								<span style="background-color: #ccb700;">${nvo.noticeCategory }</span>
							</c:if>
							<c:if test="${nvo.noticeCategory=='채용정보' }">
								<span style="background-color: #769400;">${nvo.noticeCategory }</span>
							</c:if>
							<c:if test="${nvo.noticeCategory=='기타' }">
								<span style="background-color: #086a00;">${nvo.noticeCategory }</span>
							</c:if>
						</span>
						<span class="notice-list-regat">${fn:replace((fn:substring(nvo.noticeRegAt,0,10)),'-','.') }</span>
						<c:if test="${nvo.noticePoint eq 'Y' }">
						<span class="material-symbols-outlined" style="color: red;">campaign</span>
						</c:if>
						<span class="notice-list-count">View ${nvo.noticeCount }</span>
					</div>
					<div class="notice-list-text-box">
						<h3>${nvo.noticeTitle }</h3>
						<p>${nvo.noticeSubcontent }</p>
					</div>
				</a>
			</div>
			</section>		
			</c:forEach>
		</article>
		<div style="padding: 20px; border-top: 1px solid #d8d8d8;"></div>
		
		
		
		
		<!-- 검색 라인  -->
		<div class="notice-search-form">
			<form action="/notice/list" method="get">
			<div class="notice-search-container">
				<div class="dropdown notice-search-category">
				  <select class="notice-search-category dropdown-toggle" name="type" data-bs-toggle="dropdown" aria-expanded="false">
				   	<option class="dropdown-item" value="tcw" ${typed eq 'tcw' ? 'selected' : '' }>전체</option>
				   	<option class="dropdown-item" value="t" ${typed eq 't' ? 'selected' : '' }>제목</option>
				   	<option class="dropdown-item" value="c" ${typed eq 'c' ? 'selected' : '' }>내용</option>
				   	<option class="dropdown-item" value="w" ${typed eq 'w' ? 'selected' : '' }>작성자</option>
				  </select>
				  <!-- <button class="notice-search-category dropdown-toggle" name="type" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				   		제목
				  </button>
				  <ul class="dropdown-menu">
				    <li class="dropdown-item">제목</li>
				    <li class="dropdown-item">내용</li>
				    <li class="dropdown-item">전체</li>
				  </ul> -->
				</div>
				<div class="notice-input-container">
					<input placeholder="검색어를 입력해 주세요." name="keyword" type="search" value="" class="notice-search-input">
					<input type="hidden" name="pageNo" value="1">
					<input type="hidden" name="qty" value="${ph.pgvo.qty }">
				</div>
				<div class="notice-button-container">
					<button class="notice-search-button" type="submit"><div><span class="material-symbols-outlined" style="color: white;">search</span>검색</div></button>
				</div>
			</div>
			</form>
		</div>
		
		
		<br><br>
		
		<!-- 페이징 라인 -->
		<div class="notice-paging-container">
		  <nav aria-label="Page navigation example">
		  	<!-- 이전 -->
		  	<ul class="pagination notice-paging-ul">
		  		<li class="page-item ${(ph.prev eq false) ? 'disabled' : '' }">
			  		<a class="page-link" href="/notice/list?pageNo=${ph.startPage - 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
			  		<span aria-hidden="true">&laquo;</span>
			  		</a>
		  		</li>
		  		<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
  					<li>
  						<a class="page-link" href="/notice/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a>
  					</li>
  				</c:forEach>
  			<!-- 다음 -->
  				<li class="page-item ${(ph.next eq false) ? 'disabled' : ''}">
  					<a class="page-link" href="/notice/list?pageNo=${ph.endPage + 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
        			<span aria-hidden="true">&raquo;</span>
    				</a>
  				</li>	
		  	</ul>
		  </nav>
		</div>
		
		
		<!-- 버튼 -->
		<c:if test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">			
			<div class="notice-detail-btn" style="text-align: center;">
			<!-- <a href="/notice/register">
				<button type="button">글작성</button>
			</a> -->			
			<a href="/developer/settingNotice">
				<button type="button" class="notice-btn my-admin-btn">관리자페이지</button>
			</a>
			</div>
		</c:if>
		
		
	</div>
  </div>		
</div>


<!-- 스크립트 라인  -->
<script type="text/javascript">
		const isOk = `<c:out value="${isOk}"></c:out>`
		if(isOk=="1"){
			alert('게시글이 등록 되었습니다.');
		}
</script>	
<script type="text/javascript">
		const isUp = `<c:out value="${isUp}"></c:out>`
		if(isUp=="1"){
			alert('게시글이 정상적으로 삭제 되었습니다.');
		}
</script>	
<script type="text/javascript" src="/resources/js/notice/noticeList.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>