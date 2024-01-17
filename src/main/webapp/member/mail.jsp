<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
	<title>filetable</title>
</head>
<body>
<div id="container" class="container">
	<div class="content">
		<div class="join_wrap">
			<form id="join_frm">
				<div class="join_title">회원가입</div>
				<div class="join_box">
					<input type="text" placeholder="아이디" name="id" id="id" style="margin: 0;">
					<span id="id_ck" class="dpn">이미 사용중인 아이디입니다.</span>
					<input type="text" placeholder="닉네임" name="nickname" id="nickname">
					<span id="nickname_ck" class="dpn">이미 사용중인 닉네임입니다.</span>
					<input type="password" placeholder="비밀번호" name="password" id="password">
					<input type="password" placeholder="비밀번호  확인" id="password_ck">				
					<div class="email_auth">
						<input type="text" placeholder="이메일" name="email" id="email" class="email">
						<button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 받기</button>
					</div>
					<input type="text" placeholder="인증번호 입력" id="email_auth_key">
				</div>
				<button type="button" id="join" class="join_btn">가입하기</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>