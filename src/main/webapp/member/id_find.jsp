<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
	
</script>

<meta charset="UTF-8">
<title>타요타요 아이디찾기</title>

<style type="text/css">
html {
	height: 100%;
}

body {
	margin: 0;
	height: 100%;
	background: #f5f6f7;
	font-family: Dotum, '돋움', Helvetica, sans-serif;
}

#logo {
	width: 240px;
	height: 44px;
	cursor: pointer;
}

#header {
	padding-top: 62px;
	padding-bottom: 20px;
	text-align: center;
}

#wrapper {
	position: relative;
	height: 100%;
}

/* 입력폼 */
input:focus {
	outline: none;
}

h3 {
	margin: 19px 0 8px;
	font-size: 14px;
	font-weight: 700;
}

.box {
	display: block;
	width: 100%;
	height: 51px;
	border: solid 1px #dadada;
	padding: 10px 14px 10px 14px;
	box-sizing: border-box;
	background: #fff;
	position: relative;
}

.int {
	display: block;
	position: relative;
	width: 100%;
	height: 29px;
	border: none;
	background: #fff;
	font-size: 15px;
}

input {
	font-family: Dotum, '돋움', Helvetica, sans-serif;
}

.box.int_id {
	padding-right: 110px;
}

.box.int_pass {
	padding-right: 40px;
}

.box.int_pass_check {
	padding-right: 40px;
}

.step_url {
	/*@naver.com*/
	position: absolute;
	top: 16px;
	right: 13px;
	font-size: 15px;
	color: #8e8e8e;
}

.pswdImg {
	width: 18px;
	height: 20px;
	display: inline-block;
	position: absolute;
	top: 50%;
	right: 16px;
	margin-top: -10px;
	cursor: pointer;
}

#bir_wrap {
	display: table;
	width: 100%;
}

#bir_yy {
	display: table-cell;
	width: 147px;
}

#bir_mm {
	display: table-cell;
	width: 147px;
	vertical-align: middle;
}

#bir_dd {
	display: table-cell;
	width: 147px;
}

#bir_mm, #bir_dd {
	padding-left: 10px;
}

select {
	width: 100%;
	height: 29px;
	font-size: 15px;
	background: #fff
		url(https://static.nid.naver.com/images/join/pc/sel_arr_2x.gif) 100%
		50% no-repeat;
	background-size: 20px 8px;
	-webkit-appearance: none;
	display: inline-block;
	text-align: start;
	border: none;
	cursor: default;
	font-family: Dotum, '돋움', Helvetica, sans-serif;
}

/* 에러메세지 */
.error_next_box {
	margin-top: 9px;
	font-size: 12px;
	color: red;
	display: none;
}

#alertTxt {
	position: absolute;
	top: 19px;
	right: 38px;
	font-size: 12px;
	color: red;
	display: none;
}

/* 버튼 */
.btn_area {
	margin: 30px 0 91px;
}

#btnJoin {
	width: 100%;
	padding: 21px 0 17px;
	border: 0;
	cursor: pointer;
	color: #fff;
	background-color: #195bb1;
	font-size: 20px;
	font-weight: 400;
	font-family: Dotum, '돋움', Helvetica, sans-serif;
}

section {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	width: 460px;
}
</style>
</head>
<body>

	<!-- header -->
	<div id="header">
		<label style="font-size: 30px">ID찾기</label>
	</div>


	<!-- wrapper -->
	<div id="wrapper">

		<!-- section -->
		<section>
			<form action="insert" method="post" accept-charset="utf-8">



				<input type="radio" name="chk_info" value="회원정보에 등록한 휴대전화로 인증">회원정보에
				등록한 휴대전화로 인증

				<!-- NAME -->
				<div>
					<h3 class="join_title">
						<label for="name">이름</label>
					</h3>
					<span class="box int_name"> <input type="text" id="name"
						class="int" maxlength="20" name="name" required>
					</span> <span class="error_next_box"></span>
				</div>

				<!-- MOBILE -->
				<div>
					<h3 class="join_title">
						<label for="phoneNo">휴대전화</label>
					</h3>
					<span class="box int_mobile"> <input type="tel" id="mobile"
						class="int" maxlength="16" placeholder="전화번호 입력" name="tel"
						required>
					</span> <span class="error_next_box"></span>
				</div>
				<br> <input class="btn btn-primary" type="button"
					value="인증번호 전송"  style="  padding-top: 9px;
    padding-bottom: 8px;">
				<!-- 휴대폰 인증번호 -->
				<div>
					<h3 class="join_title">
						<label for="number">인증번호</label>
					</h3>
					<span class="box int_mobile"> <input type="number"
						id="number" class="int" maxlength="16" placeholder="전화번호 입력"
						name="tel" required>
					</span> <span class="error_next_box"></span>
				</div>

				<!-- JOIN BTN-->
				<div class="btn_area">
					<button type="submit" id="btnJoin">
						<span>ID찾기</span>
					</button>
				</div>
				<br> <br> <br> <input type="radio" name="chk_info"
					value="본인확인 이메일로 인증">본인확인 이메일로 인증
				<!-- EMAIL -->
				<div>
					<h3 class="join_title">
						<label for="email">이메일</label>
					</h3>
					<span class="box int_email"> <input type="text" id="email"
						class="int" maxlength="100" placeholder="필수입력" name="email"
						required>
					</span> <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>
				</div>

				<input type="hidden" id="type" name="type" value="tayotayo">

				<!-- 이메일 인증번호 -->
				<div>
					<h3 class="join_title">
						<label for="number">인증번호</label>
					</h3>
					<span class="box int_mobile"> <input type="number"
						id="number" class="int" maxlength="16" placeholder="전화번호 입력"
						name="tel" required>
					</span> <span class="error_next_box"></span>
				</div>
				<br> <input class="btn btn-primary" type="button"
					value="인증번호 전송"
					style="
    padding-top: 9px;
    padding-bottom: 8px;">
<br>
				<!-- JOIN BTN-->
				<div class="btn_area">
					<button type="submit" id="btnJoin">
						<span>ID찾기</span>
					</button>
				</div>


			</form>
		</section>
		<!-- section -->

	</div>

</body>
</html>