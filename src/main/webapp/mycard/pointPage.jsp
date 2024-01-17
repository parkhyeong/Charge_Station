<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요 - 포인트</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap">

<style>
body {
	font-family: 'Nanum Gothic', sans-serif;
	background-color: #f8f9fa;
	color: #333;
	margin: 0;
	padding: 0;
}

.navbar {
	background-color: #343a40;
	color: #ffffff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand {
	font-size: 1.5rem;
}

.navbar-toggler-icon {
	background-color: #ffffff;
}

.nav-link {
	color: #ffffff !important;
}

.nav-link:hover {
	color: #ffc107 !important;
}

.pageBox {
	max-width: 800px;
	margin: 20px auto;
	background-color: #ffffff;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.point-policy {
	font-size: 0.9em;
	font-weight: bold;
	color: #007bff;
	margin-top: 20px;
}

.table th, .table td {
	text-align: center;
}

.srchBox {
	border: 1px solid #ddd;
	background-color: #f8f8f8;
	padding: 25px;
	margin-bottom: 30px;
	padding-left: 200px;
}

.srchBox button {
	display: inline-block;
	border-radius: 5px;
	color: #fff;
	background-color: #011533;
	padding: 2px 10px;
	margin-left: 1rem;
}

.srchBox select {
	display: inline-block;
	background: #fff;
	appearance: none;
	height: 30px;
	width: 230px;
	border: 1px solid #d9d9d9;
	border-radius: 5px;
	padding-left: 10px;
}

.tableBox {
	margin-top: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	overflow: hidden;
}

.contentList {
	margin-top: 10px;
	opacity: 1;
	transform: translateY(0px);
}

.table01 {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 700px;
}

.table01 caption {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
}

.table01 colgroup col {
	width: auto;
}

.table01 th, .table01 td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

.table01 th.bdNone {
	border: none;
}

.table01 tbody td[colspan="9"] {
	text-align: center;
	font-weight: bold;
	color: #777;
}
</style>
</head>

<body>
	<div id="top">
		<jsp:include page="../header.jsp"></jsp:include>
	</div>

	<div class="pageBox">
		<div class="container text-center">
			<h2>내 포인트</h2>
		</div>
		<br> <br> <br> <br>
		<div class="searchWrap">
			<div class="srchBox">
				<div>
					<span> <em>멤버십카드리스트</em> <select id="card_num"
						name="card_num" title="멤버십카드리스트 선택">
							<c:forEach var="card"
								items="${getMembershipCardListForBillSearch}">
								<option value="${card.card_num}">${card.card_num}</option>
							</c:forEach>
					</select>
					</span>
				</div>
				<div></div>
			</div>
		</div>

		<table align="center" class="table table-bordered">
			<tr class="tr-flex">
				<th>내 포인트</th>
				<td id="currentPoint">내 포인트 얼마 있는지</td>
			</tr>
		</table>
		<div class="contentList">
			<table class="table01">
				<colgroup>
					<col style="width: 50px;">
					<col style="width: 50px;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">사용 날짜</th>
						<th scope="col">사용 포인트</th>
					</tr>
				</thead>
				<tbody id="cardInfoTableBody">
					<tr>
						<td colspan="3">조회된 내역이 없습니다</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="point-policy">30000원 이상 결제 시 5% 포인트 적립</div>

		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		
		<script type="text/javascript">
			var c_memberid = "<c:out value='${c_memberid}'/>";
			console.log(c_memberid);

			$(document)
					.ready(
							function() {
								function getMembershipCardListForBillSearch() {
									$
											.ajax({
												type : "GET",
												url : "getMembershipCardListForBillSearch",
												success : function(data) {
													var dropdown = $("#card_num");
													dropdown.empty();

													$
															.each(
																	data,
																	function(
																			index,
																			card) {
																		dropdown
																				.append($(
																						'<option>')
																						.val(
																								card.card_num)
																						.text(
																								card.card_num));
																	});

													dropdown
															.change(function() {
																var selectedCardNum = $(
																		this)
																		.val();
																getUsePointCardInformation(selectedCardNum);
															});

													var selectedCardNum = $(
															"#card_num").val();
													getUsePointCardInformation(selectedCardNum);
												},
												error : function() {
													console
															.error("Failed to load membership card list.");
												}
											});
								}

								function getCurrentDate() {
									var today = new Date();
									var year = today.getFullYear();
									var month = (today.getMonth() + 1)
											.toString().padStart(2, '0');
									var day = today.getDate().toString()
											.padStart(2, '0');
									return year + '-' + month + '-' + day;
								}

								function getUsePointCardInformation(
										selectedCardNum) {
									$
											.ajax({
												type : "GET",
												url : "getUsePointCardInformation",
												data : {
													card_num : selectedCardNum
												},
												success : function(cardInfoList) {
													console.log("포인트카드 정보:",
															cardInfoList);

													var tableBody = $("#cardInfoTableBody");
													var currentPointElement = $("#currentPoint");

													tableBody.empty();

													if (cardInfoList.length > 0) {
														var lastItemIndex = cardInfoList.length - 1;
														var currentPoint = cardInfoList[lastItemIndex].card_point; 
														currentPointElement
																.text(currentPoint);

														$.each(cardInfoList, function (index, cardInfo) {
									                        if (cardInfo.used_point === 0) {
									                            // 사용 포인트가 0인 경우 해당 행을 숨김
									                            return;
									                        }

									                        var formattedChargeDay = cardInfo.point_day ? new Date(
									                            cardInfo.point_day).toLocaleDateString() : getCurrentDate();

									                        var newRow = $("<tr>")
									                            .append($("<td>").text(formattedChargeDay))
									                            .append($("<td>").text(cardInfo.used_point));

									                        tableBody.append(newRow);
									                    });

													} else {
														currentPointElement
																.text("조회된 내역이 없습니다");
														lastRowPointElement
																.text("포인트 얼마 썼는지 불러오는 곳");
													}
												},
												error : function() {
													console
															.error("카드 정보를 불러오는 데 실패했습니다.");
												}
											});
								}

								getMembershipCardListForBillSearch();
							});
		</script>
</body>
</html>