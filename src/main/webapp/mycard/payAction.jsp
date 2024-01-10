<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>전기차 타요타요</title>
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />
    <style>
        .pageBox {
            max-width: 1000px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>


<!-- Responsive navbar-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">전기차 타요타요</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/tayotayo/index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Link</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">관리 및 조회</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="/tayotayo/mycard/initMemberCardAction.jsp">회원카드 관리</a></li>
                        <li><a class="dropdown-item" href="#">충전요금 조회</a></li>
                        <li><a class="dropdown-item" href="/tayotayo/mycard/payAction.jsp">요금 결제</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<br><br><br><br>

<div class="pageBox">
    <div class="container text-center">
        <h2>충전소 요금 결제</h2>
    </div>
    <br><br><br><br>
    <table align="center">
        <tr>
            <td>충전소 (불러올 충전소 이름 넣기)
            <td>
        </tr>
    </table>
    <br>
    <table align="center">
        <tr>
            <td>
    충전시간  <input type="text" id="chargingTime" style="width: 50px;">시간
    <div style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
</td>
<td>
    충전량  <input type="text" id="chargingAmount" style="width: 60px;">KW
    <div style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
</td>
	<td>
 충전금액  <input type="text" id="chargeAmountInput" style="width: 70px;">원
    <div style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
</td>
<td>포인트 <input type="text" id="pointInput" style="width: 70px;">Point</td>
        </tr>
    </table>
    <br><br>
    <div class="container text-end mx-1">
        <button class="btn btn-primary" onclick="charge()">결제하기</button>
        <button class="btn btn-warning mx-1">취소하기</button>
    </div>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/tayotayo/resources/js/scripts.js"></script>
</div>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
function charge() {
	var cardNum = "TAYOTAYO23b39a5bf52024"; //카드번호 넘겨받아서 충전금액만큼 차감하기
	console.log("카드 번호:", cardNum);
    var chargeAmount = parseInt($("#chargeAmountInput").val());

    console.log("카드 번호:", cardNum);
    console.log("충전 금액:", chargeAmount); 

    // 서버로 데이터 전송
    $.ajax({
        type: "POST",
        url: "updateCardSubtract",
        data: {
            cardNum: cardNum,
            chargeAmount: chargeAmount
        },
        success: function (response) {
            if (response === "success") {
                // 성공적으로 처리된 경우
                alert("결제가 완료되었습니다.");
            } else {
                // 처리 중 에러 발생한 경우
                alert("결제 실패: " + response);
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            // AJAX 요청 실패한 경우
            console.error("AJAX 오류:", textStatus, errorThrown);
            alert("서버와의 통신에 실패했습니다.");
            console.log("카드 번호:", cardNum);
            console.log("충전 금액:", chargeAmount);
        }
    });
}
</script>


</body>
</html>