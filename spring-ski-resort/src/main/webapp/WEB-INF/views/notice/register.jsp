<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이스키 공지사항 작성페이지</title>
<link rel="stylesheet" href="/resources/css/notice/notice_register.css">
<jsp:include page="../common/nav.jsp" />      	

  <!-- summernote -->
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<!--   <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
 -->  
  <!-- 서머노트를 위해 추가해야할 부분 -->
<!--   <script src="/resources/js/summernote/summernote-lite.js"></script>
  <script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="/resources/css/summernote/summernote-lite.css"> -->

</head>
<body>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.authList" var="auths"/>
	<sec:authentication property="principal.mvo.memberId" var="authId"/>
	<sec:authentication property="principal.mvo.memberEmail" var="authEmail"/>
	<sec:authentication property="principal.mvo.memberType" var="authType"/>
</sec:authorize>
<!-- <div class="notice-img-container" style="background-image: url('https://a.cdn-hotels.com/gdcs/production68/d766/4cc034a7-aeb1-4edd-b2a9-f7feaac49aec.jpg')">	</div>
 -->
 
<div class="container notice-container">
<div class="notice-header notice-header-two">   	
	<h1 class="notice-header-h1">공지 작성 페이지<span class="notice-header-span">Create Notification Page</span></h1>
</div>


<div class="notice-menu-container">
	<div class="notice-menu-container-child">
	
	<form action="/notice/register" method="post" enctype="multipart/form-data">
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
								<option value="공지사항">공지사항</option>
							  	<option value="이벤트">이벤트</option>
							  	<option value="보도자료">보도자료</option>
							  	<option value="쇼핑몰">쇼핑몰</option>
							  	<option value="채용정보">채용정보</option>
							  	<option value="기타">기타</option>
							</select>
							<div>
								<input type="text" class="form-control" id="noticeImageUrl" name="noticeImageUrl" placeholder="홈페이지 메인화면 이벤트 슬라이드에 등록될 이미지url주소를 입력해 주세요." style="display: none;">
							</div>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">제목</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-child">
						  <input type="text" class="form-control" name="noticeTitle" id="exampleFormControlInput1" placeholder="제목은 40자 이내로 작성해 주세요." style="width: 600px;" maxlength="40">
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
					  	<div class="notice-table-th-child">중요공지</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-child">
						  <input type="checkbox" name="noticePoint" id="noticePoint" value="Y"><span> 중요공지 게시 (※등록 순서대로 목록 최상단 게시)</span>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">머리글</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-content">
						  <textarea class="form-control notice-table-subcontent" name="noticeSubcontent" rows="3" placeholder="작성된 내용은 공지목록에서 표시됩니다. 200글자 이하의 짧은 글을 작성해 주세요." style="white-space: pre-line;" maxlength="200"></textarea>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">내용</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-td-content">
						  <textarea class="form-control notice-table-text-content" name="noticeContent" rows="3" placeholder="본문 게시글을 작성해 주세요." style="white-space: pre-line;"></textarea>
						</div>
					</td>
				</tr>
				<tr class="notice-table-tr">
					<th class="notice-table-th">
					  	<div class="notice-table-th-child">첨부파일</div>
					</th>
					<td class="notice-table-td">
						<div class="mb-3 notice-table-file">
						  <input type="file" class="form-control" name="files" id="files" style="display: none;" multiple="multiple">
						  <!-- input button trigger 용도의 button -->
						  <button type="button" id="trigger" class="btn btn-outline-primary">첨부파일</button>
						  <span style="color: #ac0000;">※ 첫번째로 올린 이미지는 본문에 업로드 되지 않고 썸네일용으로 등록 됩니다.</span>
						  <div style="color: #ac0000; padding-left: 95px;">※ 첨부파일은 20MB 이하의 png, gif, jpg 형식의 파일만 등록이 가능.</div>
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
				<button type="submit" class="notice-btn mynotice-btn" id="regBtn">등록</button>
			<a href="/notice/list">
				<button type="button" class="notice-btn mynotice-btn">취소</button>
			</a>
			<a href="/developer/settingNotice">
				<button type="button" class="notice-btn my-admin-btn">관리자페이지</button>
			</a>
		</div>
	</form>

	</div>
  </div>	
</div>






<script type="text/javascript" src="/resources/js/notice/noticeFileUpload.js"></script>


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




<!-- 썸머노트 잔재 -->
<!-- <script type="text/javascript">
//summernote 부분 
$(document).ready(function textEdit(){
	jsonArray = [];
	$('#summernote').summernote({
		  height: 600,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		  toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
			callbacks: {
		         onImageUpload : function(files, editor, welEditable){

		               // 파일 업로드(다중업로드를 위해 반복문 사용)
		               for (var i = files.length - 1; i >= 0; i--) {
		                   uploadSummernoteImageFile(files[i],
		               this);
		                   }
		               }
		           } 
			
		});
	
</script> -->


<jsp:include page="../common/footer.jsp" />
</body>
</html>