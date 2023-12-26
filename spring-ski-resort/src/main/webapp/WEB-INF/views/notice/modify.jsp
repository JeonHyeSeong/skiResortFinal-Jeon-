<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이스키 공지사항 수정페이지</title>
<jsp:include page="../common/nav.jsp" />
<link rel="stylesheet" href="/resources/css/notice/notice_register.css">
</head>
<body>
<c:set value="${ndto.nvo }" var="nvo"></c:set>
<c:set value="${ndto.flist }" var="flist"></c:set>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.authList" var="auths"/>
	<sec:authentication property="principal.mvo.memberId" var="authId"/>
	<sec:authentication property="principal.mvo.memberEmail" var="authEmail"/>
	<sec:authentication property="principal.mvo.memberType" var="authType"/>
</sec:authorize>


<div class="container notice-container">
<div class="notice-header notice-header-two">   	
<h1 class="notice-header-h1">공지 수정 페이지<span class="notice-header-span">Modify Notification Page</span></h1>
</div>


<div class="notice-menu-container">
	<div class="notice-menu-container-child">
	
	<form action="/notice/modify" method="post" enctype="multipart/form-data">
		<table class="notice-table">
			<colgroup>
				<col style="width: 150px; background: #f8f8f8;">
				<col>
			</colgroup>
			<tbody>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  <div class="notice-table-th-child">카테고리</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-child-category">
							<select class="form-select" name="noticeCategory" id="inputGroupSelect01" onchange="showEventInput()">
								<option ${nvo.noticeCategory ne null }>${nvo.noticeCategory }</option>
							  	<c:choose>
							  		<c:when test="${nvo.noticeCategory == '공지사항'}">
							  		<option value="이벤트">이벤트</option>
							  		<option value="보도자료">보도자료</option>
							  		<option value="쇼핑몰">쇼핑몰</option>
							  		<option value="채용정보">채용정보</option>
							  		<option value="기타">기타</option>
							  		</c:when>
							  	</c:choose>
							  	<c:choose>
							  		<c:when test="${nvo.noticeCategory == '이벤트'}">
							  		<option value="공지사항">공지사항</option>
							  		<option value="보도자료">보도자료</option>
							  		<option value="쇼핑몰">쇼핑몰</option>
							  		<option value="채용정보">채용정보</option>
							  		<option value="기타">기타</option>
							  		</c:when>
							  	</c:choose>
							  	<c:choose>
							  		<c:when test="${nvo.noticeCategory == '보도자료'}">
							  		<option value="공지사항">공지사항</option>
							  		<option value="이벤트">이벤트</option>
							  		<option value="쇼핑몰">쇼핑몰</option>
							  		<option value="채용정보">채용정보</option>
							  		<option value="기타">기타</option>
							  		</c:when>
							  	</c:choose>
							  	<c:choose>
							  		<c:when test="${nvo.noticeCategory == '쇼핑몰'}">
							  		<option value="공지사항">공지사항</option>
							  		<option value="이벤트">이벤트</option>
							  		<option value="보도자료">보도자료</option>
							  		<option value="채용정보">채용정보</option>
							  		<option value="기타">기타</option>
							  		</c:when>
							  	</c:choose>
							  	<c:choose>
							  		<c:when test="${nvo.noticeCategory == '채용정보'}">
							  		<option value="공지사항">공지사항</option>
							  		<option value="이벤트">이벤트</option>
							  		<option value="보도자료">보도자료</option>
							  		<option value="쇼핑몰">쇼핑몰</option>
							  		<option value="기타">기타</option>
							  		</c:when>
							  	</c:choose>
							  	<c:choose>
							  		<c:when test="${nvo.noticeCategory == '기타'}">
							  		<option value="공지사항">공지사항</option>
							  		<option value="이벤트">이벤트</option>
							  		<option value="보도자료">보도자료</option>
							  		<option value="쇼핑몰">쇼핑몰</option>
							  		<option value="채용정보">채용정보</option>
							  		</c:when>
							  	</c:choose>
							</select>
							<div>
								<c:if test="${nvo.noticeCategory == '이벤트' }">
									<input type="text" value="${nvo.noticeImageUrl}" class="form-control" id="noticeImageUrl" name="noticeImageUrl" placeholder="홈페이지 메인화면 이벤트 슬라이드에 등록될 이미지url주소를 입력해 주세요." style="display: block;">
								</c:if>
								<c:if test="${nvo.noticeCategory != '이벤트' }">
									<input type="text" value="${nvo.noticeImageUrl}" class="form-control" id="noticeImageUrl" name="noticeImageUrl" placeholder="홈페이지 메인화면 이벤트 슬라이드에 등록될 이미지url주소를 입력해 주세요." style="display: none;">
								</c:if>
							</div>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
						<input type="hidden" name="noticeNum" value="${nvo.noticeNum}" readonly="readonly">
					  	<div class="notice-table-th-child">제목</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-child">
						  <input type="text" value="${nvo.noticeTitle }" class="form-control" name="noticeTitle" id="exampleFormControlInput1" placeholder="제목은 30자 이내로 작성해 주세요." style="width: 600px;" maxlength="30">
						</div>  
					</td>	
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">작성자</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-child">
						  <sec:authorize access="isAuthenticated()">
							  <c:if test="${authType == 'normal' }">
							  	<input type="hidden" class="form-control" name="noticeWriter" id="exampleFormControlInput1" value="${authId }" readonly="readonly">
							  	<span style="padding: 10px;">${authId }</span>
							  </c:if>
							  <c:if test="${authType != 'normal' }">
							  	<input type="hidden" class="form-control" name="noticeWriter" id="exampleFormControlInput1" value="${authEmail }" readonly="readonly">
							  	<span style="padding: 10px;">${authEmail }</span>
							  </c:if>
						  </sec:authorize> 
						  <sec:authorize access="isAnonymous()"> <!-- 로그인 x -->
						  	<input type="hidden" class="form-control" name="noticeWriter" id="exampleFormControlInput1" value="비회원" readonly="readonly">
						  	<span style="padding: 10px;">비회원</span>
						  </sec:authorize>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">작성일</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-child">
						  <span>등록일:${nvo.noticeRegAt } / 마지막수정일:${nvo.noticeModAt }</span>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">머리글</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-content">
						  <textarea class="form-control notice-table-subcontent" name="noticeSubcontent" rows="3" placeholder="작성된 내용은 공지목록에서 표시됩니다. 200글자 이하의 짧은 글을 작성해 주세요." style="white-space: pre-line;" maxlength="200">${nvo.noticeSubcontent }</textarea>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">내용</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-content">
						  <textarea class="form-control notice-table-text-content" name="noticeContent" rows="3" placeholder="본문 게시글을 작성해 주세요." style="white-space: pre-line;">${nvo.noticeContent }</textarea>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">첨부파일</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-file">
						<!-- 첨부파일 표시 영역 -->
							<div>
								<ul>
									<c:forEach items="${flist }" var="fvo">
										<li>
											<c:choose>
												<c:when test="${fvo.fileType > 0 }">
													<div>
														<img alt="그림이 없음." src="/upload/${fn: replace(fvo.fileSave,'\\','/')}/${fvo.fileUuid}_th_${fvo.fileName}">
													</div>
												</c:when>
											</c:choose>
											<div>
												<div><B>${fvo.fileName }</B></div>
									 			<div class="badge text-bg-secondary">${fvo.fileRegAt }</div>
									 		</div>
									 		<span class="badge rounded-pill text-bg-success">${fvo.fileSize }Byte</span>
									 		<div>
									 			<button type="button" class="file-x btn btn-outline-secondary" data-uuid="${fvo.fileUuid }">X</button>
											</div>
											<br>
										</li>
									</c:forEach>
								</ul>
							</div>
							
							
						  <input type="file" class="form-control" name="files" id="files" style="display: none;" multiple="multiple">
						  <!-- input button trigger 용도의 button -->
						  <button type="button" id="trigger" class="btn btn-outline-primary">첨부파일</button>
						  <span style="color: #ac0000;">※ 첫번째로 올린 이미지는 본문에 업로드 되지 않고 썸네일용으로 등록 됩니다.</span>
						  <div style="color: #ac0000;">※ 첨부파일은 20MB 이하의 png, gif, jpg 형식의 파일만 등록이 가능.</div>
						  <div class="mb-3" id="fileZone">
						  <!-- 첨부파일 표시 영역 -->
						  </div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	
		
		<!-- 버튼 -->
		<div class="notice-detail-btn">
		<c:if test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">
				<button type="submit" class="notice-btn mynotice-btn" id="regBtn">수정완료</button>
			<a href="/notice/list">
				<button type="button" class="notice-btn mynotice-btn">취소</button>
			</a>
			<a href="/notice/remove?noticeNum=${nvo.noticeNum }">
				<button type="button" class="notice-btn mynotice-btn-delete">삭제하기</button>
			</a>
			<a href="/developer/settingNotice">
				<button type="button" class="notice-btn my-admin-btn">관리자페이지</button>
			</a>
		</c:if>	
		</div>
	</form>

	</div>
  </div>	
</div>




<script type="text/javascript">
		const isOk = `<c:out value="${isOk}"></c:out>`
		if(isOk=="2"){
			alert('제목을 입력해 주세요.');
		}
</script>
<script>
        function showEventInput() {
            var selectedValue = document.getElementById("inputGroupSelect01").value;

            if (selectedValue === "이벤트") {
                document.getElementById("noticeImageUrl").style.display = "block";
            } else {
                document.getElementById("noticeImageUrl").style.display = "none";
            }
        }
</script>
<script type="text/javascript" src="/resources/js/notice/noticeFileModify.js"></script>
<script type="text/javascript" src="/resources/js/notice/noticeFileUpload.js"></script>
<jsp:include page="../common/footer.jsp" />	
</body>
</html>