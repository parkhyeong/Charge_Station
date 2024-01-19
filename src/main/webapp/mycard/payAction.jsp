<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%
	HttpSession sessionPayAction = request.getSession(false);
if (sessionPayAction == null || sessionPayAction.getAttribute("member_id") == null) {
%>
<script>
	alert('로그인 후 결제가 가능합니다.');
	window.location.href = '/tayotayo/member/login.jsp';
</script>
<%
	return;
}
%>
<%
String statId = request.getParameter("statId");
session.setAttribute("statId", statId);
String es_statNm = request.getParameter("es_statNm");
session.setAttribute("es_statNm", es_statNm);
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

<style>
.srchBox {
	border: 1px solid #ddd;
	background-color: #f8f8f8;
	padding: 25px;
	margin-bottom: 30px;
	padding-left: 300px;
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

.pageBox {
	max-width: 1000px;
	margin: 20px auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

#cardInfo {
	display: flex;
	align-items: center;
	margin-top: 15px;
	margin-left: 20px;
}

.btn_search {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #212529;
	margin: 5px;
}

.btn_search1 {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #212529;
	margin: 5px;
	border-radius: 40px;
}

.stat-id-container {
	background-color: #f2f2f2;
	padding: 10px;
	border-radius: 5px;
}

.stat-id-label {
	font-weight: bold;
	margin-right: 10px;
}

</style>
</head>
<body>

	<div id="top">
		<jsp:include page="../header.jsp"></jsp:include>
	</div>

	<br>
	<br>

	<div class="pageBox">
		<div class="container text-center">
			<h2>충전소 요금 결제</h2>
		</div>
		<br> <br>
		<table align="center">
			<tr>
				<td class="stat-id-container"><span class="stat-id-label">충전소
						아이디</span> <%=statId%>  <span class="stat-id-label"> 충전소
						이름 </span> <%=es_statNm%> </td>
			</tr>
		</table>
		<br> <br>
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
					<div id="cardInfo" class="text-center"></div>
				</div>
				<div></div>
			</div>
		</div>
		<div id="cardInfo" class="text-center"></div>
		<br>
		<table align="center">
			<tr>
				<td>충전시간 <span id="chargingTime">0</span>시간
					<div
						style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
				</td>
				<td>충전량 <span id="chargingAmount">0</span>KW
					<div
						style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
				</td>
				<td>총 금액 <input type="text" id="TotlePriceInput"
					style="width: 70px; border-radius: 5px;">원
					<div
						style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
				</td>
				<td colspan="3">
					<button class="btn_search1" onclick="calculateAndFill()">계산하기</button>
					<button class="btn_search1" onclick="resetFields()">초기화</button>
				</td>
			</tr>
		</table>
		<br><br>
		<table align="center">
			<tr>
				<td>사용할 금액 <input type="text" id="chargeAmountInput"
					style="width: 70px; border-radius: 5px;">원
					<div
						style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
				</td>
				<td>포인트 <input type="text" id="pointInput"
					style="width: 70px; border-radius: 5px;">Point
				</td>
			</tr>
		</table>
		<br> <br>
		<div class="container text-end mx-1">
			<button class="btn_search" onclick="charge()">결제하기</button>
			<button class="btn_search" onclick="goBack()">취소하기</button>
		</div>
	</div>
	<script>
		var c_memberid = "<c:out value='${c_memberid}'/>";
		console.log(c_memberid);
		var statId = "<%=session.getAttribute("statId")%>";
		console.log("statId:", statId);
		var es_statNm = "<%=session.getAttribute("es_statNm")%>";
		console.log("es_statNm:", es_statNm);
		function charge() {
			var cardNum = $("#card_num").val();
			var chargeAmountInput = parseFloat($("#chargeAmountInput").val()) || 0;
			var pointInput = parseFloat($("#pointInput").val()) || 0;
			var totalPriceInput = parseFloat($("#TotlePriceInput").val()) || 0;

			if (!checkBalance(cardNum, chargeAmountInput, pointInput)) {
				return;
			}
			
			if (!validateInput(totalPriceInput, chargeAmountInput, pointInput)) {
		        return;
		    }

			getUsePointCardInformation(cardNum);
			
			 var chargingTime = parseFloat($("#chargingTime").text());
	         var chargingAmount = parseFloat($("#chargingAmount").text());
	         var statId = "<%=session.getAttribute("statId")%>";

			console.log("Card Number:", cardNum);
			console.log("Charge Amount:", chargeAmountInput);
			console.log("Point Input:", pointInput);
			console.log("Charging Time:", chargingTime);
			console.log("Charging Amount:", chargingAmount);
			console.log("Stat ID:", statId);
			console.log("es_statNm :", es_statNm);

			$.ajax({
				type : "POST",
				url : "updateCardSubtract",
				data : {
					cardNum : cardNum,
					chargeAmountInput : chargeAmountInput,
					pointInput : pointInput,
					chargingTime : chargingTime,
					chargingAmount : chargingAmount,
					statId : statId,
					es_statNm : es_statNm
				},
				success : function(response) {
					if (response.status === "success") {
						alert("결제가 완료되었습니다.");
						location.reload(true);
					} else {
						alert("결제 실패: " + response);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					console.error("AJAX 오류:", textStatus, errorThrown);
					alert("서버와의 통신에 실패했습니다.");
					console.log("카드 번호:", cardNum);
					console.log("충전 금액:", chargeAmountInput);
				}
			});
		}

		function validateInput(totalPrice, chargeAmount, point) {
			if (totalPrice !== chargeAmount + point) {
				alert("입력한 금액이 총 금액과 일치하지 않습니다.");
				return false;
			}

			if (totalPrice > parseFloat($("#TotlePriceInput").val())) {
				alert("입력한 금액이 총 금액보다 많습니다.");
				return false;
			}

			return true;
		}

		$("#card_num").change(function() {
			var selectedCardNum = $(this).val();
			getUsePointCardInformation(selectedCardNum);
		});

		function getUsePointCardInformation(selectedCardNum) {
			$.ajax({
				type : "GET",
				url : "getMembershipCardInfo",
				data : {
					cardNum : selectedCardNum
				},
				success : function(cardInfo) {
					var cardInfoDiv = $("#cardInfo");
					cardInfoDiv.empty();

					cardInfoDiv
							.append("<p>현재 잔액: " + cardInfo.card_balance
									+ "원, 현재 포인트: " + cardInfo.card_point
									+ "Point</p>");

					console.log("카드 잔액:", cardInfo.card_balance);
					console.log("포인트:", cardInfo.card_point);
				},
				error : function() {
					console.error("카드 정보를 불러오는 데 실패했습니다.");
				}
			});
		}

		/// 결제 전에 카드 잔액과 포인트를 확인하는 함수
		function checkBalance(cardNum, chargeAmount, pointInput) {
			var isBalanceOk = false;
			var isPointsOk = false;

			$.ajax({
				type : "GET",
				async : false,
				url : "getMembershipCardInfo",
				data : {
					cardNum : cardNum
				},
				success : function(cardInfo) {
					var cardBalance = cardInfo.card_balance;
					var cardPoint = cardInfo.card_point;

					if (cardBalance >= chargeAmount) {
						isBalanceOk = true;
					} else {
						alert("카드 잔액이 부족합니다.");
					}

					if (cardPoint >= pointInput) {
						isPointsOk = true;
					} else {
						alert("포인트 잔액이 부족합니다.");
					}
				},
				error : function() {
					console.error("카드 정보를 불러오는 데 실패했습니다.");
				}
			});

			return isBalanceOk && isPointsOk;
		}

		function calculateAndFill() {
			var totalPriceInput = parseFloat(document
					.getElementById("TotlePriceInput").value) || 0;

			var chargingTime = parseFloat((totalPriceInput / 15000).toFixed(1));
			var chargingAmount = Math.floor(totalPriceInput / 336);

			document.getElementById("chargingTime").innerText = chargingTime;
			document.getElementById("chargingAmount").innerText = chargingAmount;
			document.getElementById("TotlePriceInput").value = chargingAmount * 336;
		}
		// 초기화
		function resetFields() {
			document.getElementById("chargingTime").innerHTML = "0";
			document.getElementById("chargingAmount").innerHTML = "0";
			document.getElementById("TotalPriceInput").value = "";
		}
		// 뒤로가기
		function goBack() {
			window.history.back();
		}

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
																function(index,
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
																	this).val();
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

							getMembershipCardListForBillSearch();
						});
	</script>


</body>
</html>