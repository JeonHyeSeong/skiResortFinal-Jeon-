<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/developer/setting.css" rel="stylesheet">
<link href="/resources/css/developer/devMember.css" rel="stylesheet">
<jsp:include page="../common/devCategory.jsp"></jsp:include>
</head>
<body>
	<div class="devMainContainer">
		<div class="devNav">
			<div class="marquee marquee1">
				<p class="marquee-text">
					<img alt="" height="50" src="/resources/etc/line.png">
				</p>
			</div>

		</div>

		<div class="devBody">


			<div class="mmmmainContainer">
				<!-- 각자 페이지 개발구역 -->
				<div class="hotelListContainer">
					<table class="table table-hover">
						<thead>
							<tr class="table-dark">
								<th>번호</th>
								<th>장비명</th>
								<th>방설명</th>
								<th>기준인원</th>
								<th>방종류</th>
								<th>방면적</th>
								<th>방요금</th>
								<th>수량</th>
					
								<th class="th-bottun"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="room" items="${roomList}">
							<form action="/developer/modifyRoom" method="post">			
								<tr class="memberTr">
									<th class="throomNum">${room.hotelRoomNum}<input type="hidden" name="hotelRoomNum" value="${room.hotelRoomNum}" readonly="readonly"></th>
									<th class="throomName"><input class="form-control roomName" type="text" name="hotelRoomName" value="${room.hotelRoomName}"></th>
									<th class="throomExplain"><input class="form-control roomExplain" type="text" name="hotelRoomExplain" value="${room.hotelRoomExplain}"></th>
									<th class="throomStandardPeople"><input class="form-control roomStandardPeople" type="number" name="hotelRoomStandardPeople" value="${room.hotelRoomStandardPeople}"></th>
									<th class="throomType"><div class="form-group"> <select class="form-select roomType" id="exampleSelect1" name="hotelRoomType">
												<option value="nomal">nomal</option>
												<c:if test="${ room.hotelRoomType eq 'vip'}">
													<option selected="selected">vip</option>
												</c:if>
												<c:if test="${ room.hotelRoomType ne 'vip'}">
													<option value="vip">vip</option>
												</c:if>
											</select>
										</div>
									<th class="throomArea"><input class="form-control roomArea" type="text" name="hotelRoomArea" value="${room.hotelRoomArea}"></th>
									<th class="throomFee"><input class="form-control roomFee"
										type="number" name="hotelRoomFee" value="${room.hotelRoomFee}"></th>
									<th class="throomCount"><input class="form-control roomCount" type="number" name="hotelInitialCount" value="${room.hotelInitialCount}"></th>
								
									<th>
										<button class="btn btn-danger" type="submit">수정</button>
										<a href="/developer/deleteRoom?hotelRoomNum=${room.hotelRoomNum}"><button class="btn btn-success" type="button">삭제</button></a>
									</th>
								</tr>
							</form>
							</c:forEach>
							 <tr class="memberTr">
                                <form action="/developer/addRoom" method="post">
                                   	 <th class="throomNum">방추가</th>
                                    <th class="throomName"><input class="form-control roomName" type="text" name="hotelRoomName"></th>
                                    <th class="throomExplain"><input class="form-control roomExplain" type="text" name="hotelRoomExplain"></th>
                                    <th class="throomStandardPeople"><input class="form-control roomStandardPeople" type="number" name="hotelRoomStandardPeople"></th>
                                    <th class="throomType">
                                        <div class="form-group">
                                            <select class="form-select roomType" id="exampleSelect1" name="hotelRoomType">
                                                <option value="nomal">nomal</option>
                                                <option value="vip">vip</option>
                                            </select>
                                        </div>
                                    </th>
                                    <th class="throomArea"><input class="form-control roomArea" type="text" name="hotelRoomArea"></th>
                                    <th class="throomFee"><input class="form-control roomFee" type="number" name="hotelRoomFee"></th>
                                    <th class="hotelInitialCount"><input class="form-control roomCount" type="number" name="hotelInitialCount"></th>
                                    <th>
                                        <button class="btn btn-success" type="submit">추가</button>
                                    </th>
                                </form>
                            </tr>
						</tbody>
					</table>

				</div>
			</div>

		</div>

	</div>
	
	
	<script type="text/javascript" src="/resources/js/developer/setting.js"></script>
</body>
</html>