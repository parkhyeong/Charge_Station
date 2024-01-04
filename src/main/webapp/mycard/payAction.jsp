<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <td>결제 카드 선택</td>            
            </tr>
                 
              
              
            <tr>
                <td>
                    충전시간  <input type="text" style="width: 50px;">시간
                    <div style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
                </td>
                <td>
                    충전량  <input type="text" style="width: 60px;">KW
                    <div style="border-left: 1px solid #000; height: 20px; display: inline-block; margin: 0 10px;"></div>
                </td>
                <td>충전금액  <input type="text" style="width: 70px;">원</td>
            </tr>
             </table>
              <br><br>
              <div class="container text-end mx-1">
                <button class="btn btn-primary">결제하기</button>
                <button class="btn btn-warning mx-1">취소하기</button>
            </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/tayotayo/resources/js/scripts.js"></script>
    </div>
    </body>
</html>