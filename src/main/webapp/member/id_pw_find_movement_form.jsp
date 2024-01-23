<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID 및 비밀번호 찾기</title>
    <jsp:include page="/header.jsp"></jsp:include>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        h1 {
            color: #333;
        }

        .form-container {
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            height: 50vh;
        }

        .form {
            width: 300px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #217dbb;
        }
    </style>
</head>
<body>

<h3 style="
    margin-top: 40px;
    margin-bottom: 20px;">아이디 및 비밀번호 찾기</h3>

<div class="form-container">
    <!-- 아이디 찾기 양식 -->
    <div class="form">
        <h3>아이디 찾기</h3>
        <br>
        <label for="email">이메일로 아이디찾기</label>
        <a href="${pageContext.request.contextPath}/member/id_find.jsp"><button type="submit">아이디 찾기</button></a>
        <br>
        <br>
        <br>
        <label for="email">휴대전화로 아이디찾기</label>
        <a href="${pageContext.request.contextPath}/member/id_find2.jsp"><button type="submit">아이디 찾기</button></a>
    </div>

    <!-- 비밀번호 찾기 양식 -->
    <div class="form">
        <h3>비밀번호 찾기</h3>
        <br>
        <label for="email">이메일로 비밀번호 찾기</label>

         <a href="${pageContext.request.contextPath}/member/pw_find.jsp"><button type="submit">비밀번호 찾기</button></a>
    </div>
</div>

</body>
</html>