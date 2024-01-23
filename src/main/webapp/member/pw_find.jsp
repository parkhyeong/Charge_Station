<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/header.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
	/**
	 *  비밀번호 찾기 이메일로 찾기 관련 처리
	 */

	function fn_join() {
		var email = $('#email').val();
		const inputCode = $("#email_auth_key").val();

		const form = document.createElement('form'); // form 태그 생성
		form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
		form.setAttribute('action', '${pageContext.request.contextPath}/member/pwupdate_form'); // 전송할 url 지정
		let social = document.createElement('input'); //<input>
		social.setAttribute('type', 'hidden');
		social.setAttribute('name', 'inputCode');
		social.setAttribute('value', inputCode);

		let social2 = document.createElement('input'); //<input>
		social2.setAttribute('type', 'hidden');
		social2.setAttribute('name', 'email');
		social2.setAttribute('value', email);

		form.appendChild(social);
		form.appendChild(social2);

		document.body.appendChild(form);
		form.submit();

	}

	$(function() {
		let check = 0; //인증번호전송을 했을때 1
		let ok = 0; //인증번호확인을 했을때 1

		$('#join2').click(function() {

			if ($('#member_id2').val() == "") {
				alert("아이디를 입력해주세요.");
				return false;
			}

			if ($('#email').val() == "") {
				alert("이메일을 입력해주세요.");
				return false;
			}

			if (ok == 1) {
				fn_join();
			} else {
				alert('인증번호 확인을 눌러주세요.')
			}
		});

		//인증 코드 비교
		$("#email_auth_check_btn2")
				.click(
						function() {
							var email = $('#email').val();
							const inputCode = $("#email_auth_key").val(); //인증번호 입력 칸에 작성한 내용 가져오기

							if (check == 0) {
								alert('인증번호 전송을 눌러주세요.')
								return false;
							}
							if (inputCode == "") {
								alert('인증번호를 입력해주세요.')
								return false;
							}

							$
									.ajax({
										type : "POST",
										url : "${pageContext.request.contextPath}/member/authCodeAuth",
										data : {
											email : email,
											inputCode : inputCode
										},
										success : function(data) {
											if (data != "x") {
												alert('인증번호가 일치합니다.');
												ok = 1;
												$("#member_id2").attr(
														"disabled", true);
												$("#email").attr("disabled",
														true);
												document
														.querySelector('#email_auth_btn').style.display = 'none';
												$("#email_auth_check_btn2").disabled = true;
												document
														.querySelector('#email_auth_check_btn2').disabled = true;
												document
														.getElementById('email_auth_check_btn2').innerText = '인증 성공';
											} else {
												alert('인증번호가 불일치 합니다. 다시 확인해주세요!');

											}
										},
										error : function(data) {
											alert("오류가 발생했습니다.");
										}

									});

						});

		//인증번호 전송
		$("#email_auth_btn").click(function() {
			var email = $('#email').val();
			var id = $('#member_id2').val();

			if (id == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}

			if (email == '') {
				alert("이메일을 입력해주세요.");
				return false;
			}

			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/member/pwemailAuth",
				data : {
					email : email,
					member_id : id
				},
				success : function(data) {
					if (data == 0) {
						alert("아이디 또는 이메일이 일치하지 않습니다.");
					} else {
						check = 1;
						alert("인증번호가 발송되었습니다.");
					}
				},
				error : function(data) {
					alert("오류가 발생했습니다.");
				}
			});
		});
	})
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
}

#logo {
	width: 240px;
	height: 44px;
	cursor: pointer;
}

#header {
	padding-bottom: 30px;
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

#join1, #join2 {
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
	max-width: 30rem;
	margin: 60px auto;
	padding: 40px;
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

	<!-- wrapper -->
	<div id="wrapper">

		<!-- section -->
		<section>
			<!-- header -->
			<div id="header">
				<label style="font-size: 30px"><b>비밀번호 찾기</b></label>
			</div>
			
			<br> <label><b>본인확인 이메일로 인증</b></label>
			<br>

			<!-- ID -->
			<div>
				<h3 class="join_title">
					<label for="id">아이디</label>
				</h3>
				<span class="box int_id"> <input type="text" id="member_id2"
					class="int" maxlength="20" required> <span class="step_url">@tayotayo.com</span>
				</span>
			</div>

			<!-- EMAIL -->
			<div>
				<h3 class="join_title">
					<label for="email">이메일</label>
				</h3>
				<span class="box int_email"> <input type="email" id="email"
					class="int" maxlength="100" placeholder="이메일 입력" name="email"
					required>
				</span>
			</div>

			<br>
			<button class="btn btn-outline-primary" type="button"
				id="email_auth_btn" style="padding-top: 9px; padding-bottom: 8px;">인증번호
				전송</button>
			<br> <br>


			<!-- 이메일 인증번호 -->
			<div>
				<h3 class="join_title">
					<label for="number">인증번호</label>
				</h3>
				<span class="box int_mobile"> <input type="text"
					id="email_auth_key" class="int" required>
				</span>
			</div>
			<br>
			<button class="btn btn-outline-primary" type="button"
				id="email_auth_check_btn2"
				style="padding-top: 9px; padding-bottom: 8px;">인증번호 확인</button>
			<br> <br>
			<!-- JOIN BTN-->
			<div class="btn_area">
				<button type="button" id="join2">
					<span>비밀번호 찾기</span>
				</button>
			</div>


		</section>
		<!-- section -->

	</div>


</body>
</html>