<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	
<jsp:include page="../common/nav.jsp"></jsp:include>
	<link  href="/resources/css/member/register.css" rel="stylesheet">
</head>
<body>

<div class="bodyContainer">
<video width="100%" height="auto" autoplay loop muted>
<source src="https://www.chamonix.com/sites/default/files/media/videos/homepage-houches%201.mp4" type="video/mp4">
</video>
	<div class="registerContainer">
		
		<div class="registerBody">
			<form:form action="/member/register" modelAttribute="mvo" method="post" onsubmit="return registerLastCheck(event);">
			<c:set var="idError"><form:errors class="errorFont" path="memberId" /></c:set>
			<c:set var="pwdError"><form:errors class="errorFont" path="memberPwd" /></c:set>
			<c:set var="aliasError"><form:errors class="errorFont" path="memberAlias" /></c:set>
			<c:set var="emailError"><form:errors class="errorFont" path="memberEmail" /></c:set>
			<c:set var="addressError"><form:errors class="errorFont" path="memberAddress" /></c:set>
			<c:set var="nameError"><form:errors class="errorFont" path="memberName" /></c:set>
			<c:set var="phoneNumError"><form:errors class="errorFont" path="memberPhoneNum" /></c:set>
				
				<div class="registerMainBox">
				
					<div class="form-group registerBox rb-1">
					    <div class=" mb-3">
					      <form:input type="text" path="memberId"  onkeyup='chaekId()' class="form-control ${empty idError ? '' : 'is-invalid'}" id="inputMemberId" name="memberId" placeholder="아이디" aria-label="Recipient's username" aria-describedby="button-addon2"/>
					      <button class="btn btn-primary" type="button" id="MemberIdCheck" style="display: none">중복확인</button>
					      <form:errors class="errorFont" path="memberId"></form:errors>
					   	  <small class="" id="duplicateIdCheck"></small>
					    </div>
				    </div>
				    
					<div class="form-group registerBox rb-2">
					    <form:input type="password" path="memberPwd" class="form-control ${empty pwdError ? '' : 'is-invalid'}" name="memberPwd" id="exampleInputPassword1" placeholder="비밀번호" autocomplete="off" />
					    <form:errors class="errorFont" path="memberPwd"></form:errors>
						<input type="password" class="form-control" id="exampleInputPassword2" placeholder="비밀번호 확인" autocomplete="off" />
				    </div>

					<div class="form-group registerBox rb-4">
					    <div>
					      <form:input type="text" class="form-control ${empty aliasError ? '' : 'is-invalid'}" path="memberAlias" name="memberAlias" id="inputMemberAlias" placeholder="닉네임" aria-label="Recipient's username" aria-describedby="button-addon2" />
					      <form:errors class="errorFont" path="memberAlias"></form:errors>
					    </div>
				    </div>
				    
					<div class="form-group registerBox rb-5">
						     <form:input type="email" path="memberEmail" readonly="true" class="form-control" name="memberEmail" id="inputMemberEmail" aria-describedby="emailHelp" placeholder="이메일" />
						 	<form:errors class="errorFont" path="memberEmail"></form:errors>
						     <button type="button" class="btn btn-primary" id="MemberEmailCheck" data-bs-toggle="modal" data-bs-target="#staticBackdrop" style="display: none;">
							 	이메일 인증
							 </button>
				    </div>
				    
				    
				    <!-- 주소 -->

			    <div class="registerBox rb-6">
					<div class="addressBox">
						<div class="mb-3 postNum">
					    <input type="text" class="form-control post" onclick="clickAddr()" id="inputMemberPostcode" readonly="readonly" placeholder="우편번호">
						</div>
					    <div class="adressNum">
					       <form:input type="text" path="memberAddress" onclick="clickAddr()"  class="form-control ${empty addressError ? '' : 'is-invalid'}" name="memberAddress"  id="inputMemberAddress" placeholder="주소를 입력해주세요." aria-label="Recipient's username" aria-describedby="button-addon2" />
					      <button class="btn btn-primary" type="button"  id="button-addon2" onclick="sample6_execDaumPostcode()" style="display: none;" >주소 찾기</button>
					    </div>
				    </div>
					<form:errors class="errorFont" path="memberAddress"></form:errors>
				    <div class="form-group registerBox rb-7">
						<input type="text" class="form-control" name="memberAddressDetail" id="inputMemberAddressDetail" placeholder="상세주소 입력..." />
					</div>
			    </div>
			
			    
			    <div class="form-group registerBox rb-9">
					 <form:input type="text" path="memberName" class="form-control ${empty nameError ? '' : 'is-invalid'}" name="memberName" placeholder="이름" id="inputMemberName" />
					 <form:errors class="errorFont" path="memberName"></form:errors>
				</div>   
			    
			    
			    
			    <div class="form-group registerBox rb10">
			    
			    <div class="input-group mb-3">
					 <select class="num-select" id="phoneNum1" onchange="printNum()">
			    		<option value="010">010</option>
			    		<option value="011">011</option>
			    		<option value="016">016</option>
			    		<option value="017">017</option>
			    		<option value="018">018</option>
			    		<option value="019">019</option>
			    		<option value="070">070</option>
			    		<option value="053">053</option>
			    	</select>
			    	<input type="text" class="form-control" placeholder="휴대번호" onkeyup='printNum()' id="phoneNum2" maxlength='8' 
			    	oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
				</div>
			    
			    
			    
			    	
					 <form:input type="text" path="memberPhoneNum" class="form-control ${empty phoneNumError ? '' : 'is-invalid'}" name="memberPhoneNum"  id="inputMemberPhone" />
				
					  <form:errors class="errorFont" path="memberPhoneNum"></form:errors>
				</div>    
				
			</div>
			
			
			<!-- 체크박스 -->
				<div class="egloo">
					<img alt="" src="/resources/etc/logo_detail.png" width="200" height="180">
				</div>
				<div class="termsMainBox">
					
				 	<div class="form-check all-check">
				        <input class="form-check-input" type="checkbox" id="flexCheckDefault">
				        <label class="form-check-label" for="flexCheckDefault">
				          전체동의
				        </label>
				        <!-- 약관 보기 버튼 -->
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#termsModal">
						  약관 상세보기
						</button>
				    </div>
					    <form:errors class="errorFont2" path="memberTerms1"></form:errors><br>
					    <form:errors class="errorFont2" path="memberTerms2"></form:errors>
				    <hr>
				    <div class="termsBox">
				    	<div class="tbBox tb-1">
					    	<input class="form-check-input" name="memberTerms1" type="checkbox" value="terms1check" id="flexCheckDefault-1">
					    	<form:input type="hidden" path="memberTerms1" name="memberTerms1" id="terms1" value="" />
					    	<label class="form-check-label" for="flexCheckDefault-1">
					          만 14세 이상입니다. (필수)
					        </label>
				        </div>
				        <div class="tbBox tb-2">
					        <input class="form-check-input" name="memberTerms2" type="checkbox" value="terms2check" id="flexCheckDefault-2">
					    	<form:input type="hidden" path="memberTerms2" name="memberTerms2" id="terms2" value="" />
					    	<label class="form-check-label" for="flexCheckDefault-2">
					          이용약관 (필수)
					        </label>
				        </div>
				        <div class="tbBox tb-3">
					        <input class="form-check-input" name="memberTerms3" type="checkbox" value="terms3check" id="flexCheckDefault-3">
					    	<input type="hidden" name="memberTerms3" id="terms3" value="non-check">
					    	<label class="form-check-label" for="flexCheckDefault-3">
					          마케팅 동의 (선택)
					        </label>
				        </div>
				    
				    </div>

					<div class="btnMainBox">
						<button type="submit" class="btn btn-primary bb-1">가입완료</button> 
						<a href="/"><button type="button" class="btn btn-primary bb-2">메인으로</button></a>
					</div>
				</div>
			
			</form:form>
			
		</div>
	</div>	
	
		<!-- 약관 모달 -->
	<div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="termsModalLabel">이용약관</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" id="modalCloseClick" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        가. 수집하는 개인정보의 항목첫째, 회사는 회원가 입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다. <br>
			회원가입<br>
			- 이름, 생년월일, 성별, 아이디, 비밀번호, 별명, 연락처(메일주소, 휴대폰 번호 중 선택), 가입인증정보<br>
			만14세 미만 아동 회원가입<br><br>
			- 이름, 생년월일, 성별, 법정대리인 정보, 아이디, 비밀번호, 연락처 (메일주소, 휴대폰 번호 중 선택), 가입인증정보<br><br>
			단체아이디 회원가입 <br><br>
			- 단체아이디, 회사명, 대표자명, 대표 전화번호, 대표 이메일 주소, 단체주소, 관리자 아이디, 관리자 연락처, 관리자 부서/직위<br>
			- 선택항목 : 대표 홈페이지, 대표 팩스번호<br><br>
			둘째, 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.<br>
			- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록<br><br>
			셋째, 네이버 아이디를 이용한 부가 서비스 및 맞춤식 서비스 이용 또는 이벤트 응모 과정에서 해당 서비스의 이용자에 한해서만 개인정보 추가 수집이 발생할 수 있으며, 이러한 경우 별도의 동의를 받습니다.<br><br>
			넷째, 성인컨텐츠, 유료/게임 등 일부 서비스 이용시 관련 법률 준수를 위해 본인인증이 필요한 경우, 아래와 같은 정보들이 수집될 수 있습니다.<br><br>
			- 이름, 생년월일, 성별, 중복가입확인정보(DI), 암호화된 동일인 식별정보(CI), 휴대폰 번호(선택), 아이핀 번호(아이핀 이용시), 내/외국인 정보<br><br>
			다섯째, 유료 서비스 이용 과정에서 아래와 같은 결제 정보들이 수집될 수 있습니다.<br>
			- 신용카드 결제시 : 카드사명, 카드번호 등<br>
			- 휴대전화 결제시 : 이동전화번호, 통신사, 결제승인번호 등<br> 
			- 계좌이체시 : 은행명, 계좌번호 등<br>
			- 상품권 이용시 : 상품권 번호<br><br>
			나. 개인정보 수집방법회사는 다음과 같은 방법으로 개인정보를 수집합니다.<br>
			- 홈페이지, 서면양식, 팩스, 전화, 상담 게시판, 이메일, 이벤트 응모, 배송요청<br>
			- 협력회사로부터의 제공<br>
			- 생성정보 수집 툴을 통한 수집<br><br>
	      </div>
	     	<div class="modal-footer">
		      <div class="form-check all-check" >
		      	<input class="form-check-input" type="checkbox" id="ModalflexCheckDefault">
			        <label class="form-check-label" for="ModalflexCheckDefault">
			         전체동의
			        </label>
			  </div>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- 이메일 인증 팝업 -->
	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog" tabindex="-1">
		    <div class="modal-content" tabindex="-1">
		      <div class="modal-header" tabindex="-1">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel" tabindex="-1">이메일 인증하기</h1>
		        <button type="button" class="btn-close" id="modalClose" data-bs-dismiss="modal" aria-label="Close" tabindex="-1"></button>
		      </div>
		      <div class="modal-body" tabindex="-1">
		        <div class="form-group registerBox rb-5 emailModalBody" tabindex="-1">
				     <label for="modalEmailCheck" class="form-label mt-4" tabindex="-1">Email</label>
				     <div class="input-group mb-3" tabindex="-1">
					     <input type="email" class="form-control" id="modalEmailCheck" aria-describedby="emailHelp" placeholder="이메일"  tabindex="-1" />
					     <button type="button" class="btn btn-primary" id="modalEmailCheckBtn" tabindex="-1">
						 	인증번호 받기
						 </button>
				  		 </div>
					 <div id="emailDuplicateCheck" tabindex="-1"></div>
		      </div>
		      <div class="modal-body" id="modal-body2" tabindex="-1">
		       
		      </div>
		      <div class="modal-footer" tabindex="-1">
		        <input type="button" class="btn btn-primary" id="emailCheckSuccess" value="인증완료" tabindex="-1">
		      </div>
		    </div>
		  </div>
		</div>

	</div>
</div>



<script type="text/javascript" src="/resources/js/member/MemberRegister.js"></script>

<!-- 주소 scrpit -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/member/MemberAddress.js"></script>


</body>
</html>