<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
   <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="../common/nav.jsp"></jsp:include>
<link  href="/resources/css/member/detail.css" rel="stylesheet">
</head>
<body>
	
	<div class="bodyContainer">
	<div class="backgroundImgList">
	
	</div>
	<!-- 왼쪽 카테고리  -->
	<div class="mainCategory">
	<jsp:include page="../common/member_category.jsp"></jsp:include>
	</div>
	<!-- 오른쪽 메인화면 -->
	<div class="mainView">
		<div class="mainViewBody2">
			<div class="mainViewBox3">
				<div class="infoBox ibox6">
					<div class="iboxList iboxList2">
						<span>결제/환불 내역</span>
						<span>
							총 결제 금액 :<font style="color:black;"> ${sum} 원 </font><br>
							<font style="font-size:20px;">(결제취소 금액은 제외됩니다.)</font>
						</span>
					</div>
					<table class="table table-hover">
						<thead>
							<tr class="table-dark">
								<th>주문번호</th>
								<th>결제은행</th>
								<th>주문명</th>
								<th>금액</th>
								<th>결제자</th>
								<th>연락처</th>
								<th>상태</th>
								<th style="display:none">결제일자</th>
								<!-- <th>요청</th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pivoList}" var="pList">
								<tr class="tr-div">
									<td>
										<p class="payMerchantUid">${pList.payMerchantUid }</p>
										<p class="payRegAt">${pList.payRegAt }</p>
										<input type="hidden" value="${pList.payImpUid }">
									</td>
									<td>${pList.payPg }</td>
									<td>${pList.payName }</td>
									<td>${pList.payAmount } 원</td>
									<td>${pList.memberName }</td>
									<td>${pList.memberPhoneNum }</td>
									<td>
										${pList.payStatus }
										<c:if test="${pList.payStatus eq '결제완료' }">
											/
											<button type="button"  class="refunds" onclick="showRowData(this)" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
											  환불요청
											</button>
										</c:if>
									</td>
									<td style="display:none">${pList.payRegAt }</td>
									<td style="display:none">${pList.payNameType}</td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>	
<!-- 					<div> -->
<!-- 						  <ul class="pagination"> -->
<!-- 						    <li class="page-item disabled"> -->
<!-- 						      <a class="page-link" href="#">&laquo;</a> -->
<!-- 						    </li> -->
<!-- 						    <li class="page-item active"> -->
<!-- 						      <a class="page-link" href="#">1</a> -->
<!-- 						    </li> -->
<!-- 						    <li class="page-item"> -->
<!-- 						      <a class="page-link" href="#">2</a> -->
<!-- 						    </li> -->
<!-- 						    <li class="page-item"> -->
<!-- 						      <a class="page-link" href="#">3</a> -->
<!-- 						    </li> -->
<!-- 						    <li class="page-item"> -->
<!-- 						      <a class="page-link" href="#">4</a> -->
<!-- 						    </li> -->
<!-- 						    <li class="page-item"> -->
<!-- 						      <a class="page-link" href="#">5</a> -->
<!-- 						    </li> -->
<!-- 						    <li class="page-item"> -->
<!-- 						      <a class="page-link" href="#">&raquo;</a> -->
<!-- 						    </li> -->
<!-- 						  </ul> -->
<!-- 						</div> -->
						<!-- 페이징 라인 -->				
						<div class="qna-paging-container">
						  <nav aria-label="Page navigation example">
						  	<!-- 이전 -->
						  	<ul class="pagination qna-paging-ul">
						  		<li class="page-item ${(ph.prev eq false) ? 'disabled' : '' }">
							  		<a class="page-link" href="/pay/memberPayList?pageNo=${ph.startPage - 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
							  		<span aria-hidden="true">&laquo;</span>
							  		</a>
						  		</li>
						  		<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
				  					<li>
				  						<a class="page-link" href="/pay/memberPayList?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a>
				  					</li>
				  				</c:forEach>
				  			<!-- 다음 -->
				  				<li class="page-item ${(ph.next eq false) ? 'disabled' : ''}">
				  					<a class="page-link" href="/pay/memberPayList?pageNo=${ph.endPage + 1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
				        			<span aria-hidden="true">&raquo;</span>
				    				</a>
				  				</li>	
						  	</ul>
						  </nav>
						</div>		
					</div>
					
						
				</div>
			</div>
				
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="staticBackdropLabel">환불 요청</h1>
	        <button type="button" data-bs-dismiss="modal" id="refund-close" aria-label="Close">X</button>
	      </div>
	      <div class="modal-body refundInfo-body">
	       	<div class="transactionInfo" id="transactionInfo">
	       		
	       	</div>
	       	<hr>
	       	<div class="refundInfo" id="refundInfo">
	       		 
	       	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="refundInfoBtn">환불 요청하기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- 영수증 모달 창 -->
	<div class="modal fade" id="receiptModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="receiptModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1>주문 내역</h1>
	        <button type="button" data-bs-dismiss="modal" id="receipt-close" aria-label="Close">X</button>
	      </div>
	      <div class="modal-body receipt-body">
	       	<div class="receiptInfo" id="receiptInfo1">
	       		<div class="receiptMainLogo">
	       			<img alt="" width="120" height="100" src="/resources/etc/logo_basic.png">
	       		</div>
	       		<h3> 주문 내역서 </h3>
	       		<hr>
	       		<div id="member-receipt-body"> 
	       		
	       		</div>
	       		<div id="member-receipt-footer">
	       		
	       		</div>
	       	</div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div id="modalEmailCheckBtn"></div>
	<div id="inputMemberEmail"></div>
	
	<script type="text/javascript" src="/resources/js/member/MemberDetail.js"></script>
	<script type="text/javascript" src="/resources/js/pay/MemberRefund.js"></script>
	
</body>
</html>