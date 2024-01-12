<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String c_memberid = "root";
session.setAttribute("c_memberid", c_memberid);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />
<style>
.subPage {
	background-color: #f4f4f4;
}

.pageBox {
	max-width: 800px;
	margin: 20px auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.pageTit {
	font-size: 36px;
	color: #333;
	text-align: center;
	margin-bottom: 25px;
}

.subPageTab {
	list-style: none;
	padding: 0;
	margin: 0;
	text-align: center;
}

.subPageTab li {
	display: inline-block;
	margin-right: 10px;
}

.subPageTab a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	display: block;
	padding: 10px;
	text-align: center;
	border: 2px solid #ccc;
	border-radius: 5px;
}

.subPageTab li.on a {
	background-color: #ddd;
}

.tabPage {
	display: none;
}

.tabPage.on {
	display: block;
}

.formBox {
	margin-top: 20px;
}

.nece {
	color: red;
}

.selectBox, .inputBox {
	margin-top: 10px;
}

.btnBox {
	margin-top: 20px;
}

.btn_agree_next {
	display: inline-block;
	padding: 10px 20px;
	background-color: #212529;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	cursor: pointer;
}

.btn_agree_next:hover {
	background-color: #0056b3;
}

.srchBox {
	margin-top: 30px;
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
	width: 220px;
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

.card-num {
	color: #0d6efd;
	cursor: pointer;
}

.card-num:hover {
	color: #084298;
}

.modal-content {
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
	background-color: #212529;
	color: #fff;
	border-bottom: 1px solid #dee2e6;
}

.modal-title {
	font-size: 1.5rem;
}

.modal-body {
	padding: 20px;
}

.btn-close {
	color: #fff;
}

.refundButton {
	display: inline-block;
	padding: 5px 10px;
	background-color: #212529;
	color: #fff;
	border-radius: 3px;
	cursor: pointer;
}

.refundButton:hover {
	background-color: #fff;
	color: #212529;
}
</style>
</head>
<body>
	<!-- Responsive navbar-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="#">전기차 타요타요</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/tayotayo/index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="managementDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">관리
							및 조회</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="managementDropdown">
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/initMemberCardAction.jsp">회원카드 관리</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/initBillSeachAction.jsp">충전요금 조회</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/pointPage.jsp">포인트 조회</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#">Something else
									here</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="communityDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							커뮤니티 </a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="communityDropdown">
							<li><a class="dropdown-item" href="#">공지 게시판</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/review/initReviewBoard.jsp">리뷰 게시판</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="pageBox">
		<h3 class="pageTit js-scrollmotion_up"
			style="opacity: 1; transform: translateY(0px);">이용요금 조회</h3>
		<div class="subWrap js-scrollmotion_up scrolldelay1"
			style="opacity: 1; transform: translateY(0px);">
			<input type="hidden" id="spageId" name="spageId" value=""> <input
				type="hidden" id="srecordCountPerPage" name="srecordCountPerPage"
				value="10">
			<!-- 페이지에 표시되는 라인 수 -->
			<input type="hidden" id="spageNo" name="spageNo" value="1"> <input
				type="hidden" id="spageSize" name="spageSize" value="10"> <input
				type="hidden" id="excelPage" name="excelPage" value=""> <input
				type="hidden" id="excelCnt" name="excelCnt" value="">

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

			<div class="contentList">
				<table class="table01">
					<colgroup>
						<col style="width: 40px;">
						<col style="width: 100px;">
						<col style="width: 50px;">
						<col style="width: 50px;">
						<col style="width: 50px;">
						<col style="width: 50px;">
						<col style="width: 50px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">결제날짜</th>
							<th scope="col">총전소명</th>
							<th scope="col">충전시간</th>
							<th scope="col">충전량(kWh)<br>
							</th>
							<th scope="col">결제금액<br>
							</th>
							<th scope="col">결제<br>포인트<br>
							</th>
							<th scope="col">환불</th>
						</tr>
					</thead>
					<tbody id="cardInfoTableBody">
						<tr>
							<td colspan="7">조회된 내역이 없습니다</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/tayotayo/resources/js/scripts.js"></script>

	<script type="text/javascript">
		var c_memberid = "<c:out value='${c_memberid}'/>";
		console.log(c_memberid);

		$(document).ready(function () {
		    function getMembershipCardListForBillSearch() {
		        $.ajax({
		            type: "GET",
		            url: "getMembershipCardListForBillSearch",
		            success: function (data) {
		                var dropdown = $("#card_num");
		                dropdown.empty();

		                $.each(data, function (index, card) {
		                    dropdown.append($('<option>')
		                        .val(card.card_num)
		                        .text(card.card_num));
		                });

		                dropdown.change(function () {
		                    var selectedCardNum = $(this).val();
		                    getUseCardInformation(selectedCardNum);
		                });

		                var selectedCardNum = $("#card_num").val();
		                getUseCardInformation(selectedCardNum);
		            },
		            error: function () {
		                console.error("Failed to load membership card list.");
		            }
		        });
		    }

		    function getUseCardInformation(selectedCardNum) {
		        $.ajax({
		            type: "GET",
		            url: "getUseCardInformation",
		            data: {
		                card_num: selectedCardNum
		            },
		            success: function (cardInfoList) {
		                console.log("카드정보:", cardInfoList);

		                var tableBody = $("#cardInfoTableBody");
		                tableBody.empty();

		                if (cardInfoList.length > 0) {
		                    $.each(cardInfoList, function (index, cardInfo) {
		                        var chargeDay = new Date(cardInfo.charge_day);
		                        var formattedChargeDay = chargeDay.getFullYear() + '-' + (chargeDay.getMonth() + 1) + '-' + chargeDay.getDate();

		                        var newRow = $("<tr>")
		                            .append($("<td>").text(formattedChargeDay))
		                            .append($("<td>").text(cardInfo.station_name))
		                            .append($("<td>").text(cardInfo.charge_time))
		                            .append($("<td>").text(cardInfo.charge_amount))
		                            .append($("<td>").text(cardInfo.payment_amount))
		                            .append($("<td>").text(cardInfo.payment_point));

		                        var refundButton = $("<button>")
		                            .text("환불")
		                            .addClass("refundButton")
		                            .click(function () {
		                                alert("환불");
		                            });

		                        newRow.append($("<td>").append(refundButton));
		                        tableBody.append(newRow);
		                    });
		                } else {
		                    var newRow = $("<tr>")
		                        .append($("<td colspan='6'>").text("조회된 내역이 없습니다"));
		                    tableBody.append(newRow);
		                }
		            },
		            error: function () {
		                console.error("카드 정보를 불러오는 데 실패했습니다.");
		            }
		        });
		    }

		getMembershipCardListForBillSearch();
});
	</script>
</body>
</html>