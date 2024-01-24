<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.multi.tayotayo.member.MemberVO"%>
<%@page import="com.multi.tayotayo.member.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page</title>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<link href="${pageContext.request.contextPath}/resources/css/mypage.css"
	rel="stylesheet" type="text/css" />

<script>
$(function(){
	$('#socialpwchange').click(function(){
		if ('${type}'=='naver'){
			window.open('https://nid.naver.com/user2/help/myInfo?m=viewChangePasswd&lang=ko_KR');
			
		}
		else if('${type}'=='kakao'){
			window.open('https://accounts.kakao.com/weblogin/find_password?continue=https%3A%2F%2Faccounts.kakao.com%2Fweblogin%2Faccount%2Finfo')
		}
		else if('${type}'=='google'){
			window.open('https://myaccount.google.com/signinoptions/password?continue=https://myaccount.google.com/personal-info?hl%3Dko&pli=1&rapt=AEjHL4MEH8eK26Lz24Suh2fr1nFnRh59SmQklXf4CGo46JOrFCXYKG7_Z7yUyG-snL0JIug8zRsr9pWvbga6yeqeiZBD1m_hZXY1pVA2szufe83sAhqcZ5w')
		}
		
	})
	
})

</script>

<script>

idok = 0;
passok = 0; 
cpassok = 0; 
nameok = 0;
nicknameok = 0; 
telok = 0;
emailok = 0; 

function checkName() {
	const name_change_button = document.getElementById('name_change_button');
	let userName = $('#name');
	let error = $('.error_next_box');
	let namePattern = /[a-zA-Z가-힣]/;

 if(userName.val() === "") {
	 name_change_button.disabled = true;
     error[0].innerHTML = "필수 정보입니다.";
     error[0].style.display = "block";
     nameok = 0
 } else if(!namePattern.test(userName.val()) || userName.val().indexOf(" ") > -1) {
	 name_change_button.disabled = true;
     error[0].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
     error[0].style.display = "block";
     nameok = 0
 } else {
	 name_change_button.disabled = false;
     error[0].style.display = "none";
     nameok = 1
 }
}

function checknickName() {
	var nickName = $('#nickname');
	const nickname_change_button = document.getElementById('nickname_change_button');
	let error = $('.error_next_box');
	
 $.ajax({
		type : "post",/* 전송 방식 */
		url : "nicknameConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
		data : {
			"nickname" : nickName.val()
		},

		success : function(data) {
			if('${result.nickname}'==nickName.val()){
				nickname_change_button.disabled = false;
				data = 1
			}
			if (data == 0) {
				 //ajax가 제대로 안됐을 때 .
			  nickname_change_button.disabled = true;
              error[1].innerHTML = "닉네임이 이미 존재합니다.";
              error[1].style.display = "block";
			  nicknameok = 0 //불가 
			}
		},
		error : function() {
			 nickname_change_button.disabled = true;
             error[1].innerHTML = "오류가 발생했습니다.";
             error[1].style.display = "block";
             nicknameok = 0 //불가 
		}
	})
	
 var namePattern = /[a-zA-Z가-힣0-9]/;
 if(nickName.val() === "") {
	 nickname_change_button.disabled = true;
     error[1].innerHTML = "필수 정보입니다.";
     error[1].style.display = "block";
     nicknameok = 0 //불가 
 } else if(!namePattern.test(nickName.val()) || nickName.val().indexOf(" ") > -1) {
	 nickname_change_button.disabled = true;
     error[1].innerHTML = "한글과 영문 대 소문자, 숫자를 사용하세요. (특수기호, 공백 사용 불가)";
     error[1].style.display = "block";
     nicknameok = 0 //불가 
 } else {
	 nickname_change_button.disabled = false;
     error[1].style.display = "none";
     nicknameok = 1 //가능 
 }
}


function isEmailCorrect() {
	const email_change_button = document.getElementById('email_change_button');
	let email = $('#email');
	let error = $('.error_next_box');
	
	 $.ajax({
			type : "post",/* 전송 방식 */
			url : "emailConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
			data : {
				"email" : email.val()
			},

			success : function(data) {
				if('${result.email}'== email.val()){
					email_change_button.disabled = false;
					data = 1
				}
				
				if (data == 0) {
				   email_change_button.disabled = true;
	               error[2].innerHTML = "이미 등록된 이메일 입니다.";
	               error[2].style.display = "block";
					emailok = 0 //불가 
				}
			},
			error : function() {
				  email_change_button.disabled = true;
	              error[2].innerHTML = "오류가 발생했습니다.";
	              error[2].style.display = "block";
	              emailok = 0 //불가 
			}
		})
		
	 var emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

	 if(email.val() === ""){ 
		 email_change_button.disabled = true;
	     error[2].innerHTML = "필수 정보입니다.";
	     error[2].style.display = "block";
	     emailok = 0 //불가 
	 } else if(!emailPattern.test(email.val())) {
		 email_change_button.disabled = true;
	     error[2].innerHTML = "잘못된 이메일 형식입니다.";
	     error[2].style.display = "block";
	     emailok = 0 //불가 
	 } else {
		 email_change_button.disabled = false;
	     error[2].style.display = "none"; 
	     emailok = 1 //가능 
			 
	 }
	 
}
	
	
function checkPhoneNum() {
	const tel_change_button = document.getElementById('tel_change_button');
	let mobile = $('#tel');
	let error = $('.error_next_box');
 $.ajax({
		type : "post",/* 전송 방식 */
		url : "telConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
		data : {
			"tel" : mobile.val()
		},

		success : function(data) {
			if('${result.tel}'==mobile.val()){
				tel_change_button.disabled = false;
				data = 1
			}
			
			if (data == 0) {
				 //ajax가 제대로 안됐을 때 .
			   tel_change_button.disabled = true;
               error[3].innerHTML = "이미 등록된 휴대전화 입니다.";
               error[3].style.display = "block";
               telok = 0 //불가 
			}
		},
		error : function() {
			tel_change_button.disabled = true;
            error[3].innerHTML = "오류가 발생했습니다.";
            error[3].style.display = "block";
            elok = 0 //불가
		}
	})
	
 var isPhoneNum = /([01]{2})([01679]{1})([0-9]{3,4})([0-9]{4})/;

 if(mobile.val() === "") {
	 tel_change_button.disabled = true;
     error[3].innerHTML = "필수 정보입니다.";
     error[3].style.display = "block";
     telok = 0 //불가 
		
 } else if(!isPhoneNum.test(mobile.val())) {
	 tel_change_button.disabled = true;
     error[3].innerHTML = "형식에 맞지 않는 번호입니다.";
     error[3].style.display = "block";
     telok = 0 //불가 
		
 } else {
	 tel_change_button.disabled = false;
     error[3].style.display = "none";
     telok = 1 //가능
		 
 }
 
}

function namesaveconfirm(){
	if(nameok == 0){
	return false;
	}
}

function nicknamesaveconfirm(){
	if(nicknameok == 0){
	return false;
	}
}

function emailsaveconfirm(){
	if(emailok == 0){
	return false;
	}
}

function telsaveconfirm(){
	if(telok == 0){
	return false;
	}
}

$(function(){
	$('.modal').on('hidden.bs.modal', function (e) {
	  $(this).find('form')[0].reset()
	});
	
	var image = new Image();
	if ('${type}'=='naver'){
		image.src="https://imweb.me/img/naver_pay_img_04.png?44251234";
		image.style.marginBottom = '8px';
		image.style.marginLeft = '2px';
		
	}
	else if ('${type}'=='kakao'){
		image.src="${pageContext.request.contextPath}/resources/img/kakao-talk-icon.png";
		image.style.marginBottom = '7px';
		image.style.marginLeft = '2px';
	}
	else if ('${type}'=='google'){
		image.src="${pageContext.request.contextPath}/resources/img/google-icon.png";
		image.style.marginBottom = '6px';
		image.style.marginRight = '6px';
	}
	
	document.getElementById('social_marker').appendChild(image);
	image.style.width = '25px';
    image.style.height = '25px';
	
})

			
</script>

</head>
<body>

	<jsp:include page="/header.jsp"></jsp:include>
	<h1 style="text-align: center;margin-top: 31px;margin-bottom: 20px;height: 70px;">마이페이지</h1>
	<section>
		<h2>기본 정보</h2>
		<div class="mb-3">

			<label for="exampleFormControlInput1" class="form-label"
				style="margin-top: 10px;"><font size="4em" color="blue">소셜로그인&nbsp;</font></label><span id="social_marker"></span>

			<br> <label for="exampleFormControlInput1" class="form-label"
				style="margin-top: 10px;"><font size="4em" color="green">타요타요 연동ID:&nbsp;</font></label> <label
				for="exampleFormControlInput1" class="form-label"><font size="4em" color="green">${result.member_id}</font></label>


		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">이름</label>
			<button class="btn btn-outline-primary tt" data-bs-toggle="modal"
				data-bs-target="#nameModal">수정</button>
			<input type="text" class="form-control" id="exampleFormControlInput1"
				placeholder="-" value="${result.name}" disabled>
		</div>

		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">닉네임</label>
			<button class="btn btn-outline-primary tt" data-bs-toggle="modal"
				data-bs-target="#nicknameModal">수정</button>
			<input type="text" class="form-control" id="exampleFormControlInput1"
				placeholder="-" value="${result.nickname}" disabled>
		</div>

	</section>



	<section>
		<h2>연락처 정보</h2>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">본인확인
				이메일</label>
			<button class="btn btn-outline-primary tt" data-bs-toggle="modal"
				data-bs-target="#emailModal">수정</button>
			<input type="email" class="form-control"
				id="exampleFormControlInput1" placeholder="-"
				value="${result.email}" disabled>
		</div>

		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">본인확인
				휴대전화</label>
			<button class="btn btn-outline-primary tt" data-bs-toggle="modal"
				data-bs-target="#telModal">수정</button>
			<input type="tel" class="form-control" id="exampleFormControlInput1"
				placeholder="-" value="${result.tel}" disabled>
		</div>
	</section>

	<section>
		<h2>개인 정보</h2>

		<div class="mb-3">
			<button id="socialpwchange" class="btn btn-outline-primary">${type}
				비밀번호 변경</button>
		</div>
	</section>
	<section>
		<h2>내 게시글</h2>
		<div class="mb-3">
			<jsp:include page="myreviewlist.jsp"></jsp:include>
		</div>
	</section>

	<section>
		<h2>내 댓글</h2>
		<div class="mb-3">
			<jsp:include page="myreplylist.jsp"></jsp:include>
		</div>
	</section>

	<div style="text-align: center;">
		<button type="button" class="btn btn-outline-danger"
			style="margin-right: 480px; margin-top: 10px;" data-bs-toggle="modal"
			data-bs-target="#deleteModal">계정연동취소</button>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="modal fade" id="nameModal" tabindex="-1"
		aria-labelledby="nameModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="nameModalLabel">이름 변경</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="nameupdate" method="post" accept-charset="utf-8"
					onsubmit="return namesaveconfirm()">
					<div class="modal-body">

						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">이름</label> <input
								type="hidden" class="form-control" id="member_id"
								value="${result.member_id}" name="member_id"> <input
								type="text" class="form-control" id="name"
								value="${result.name}" name="name" onkeyup="checkName()">
							<span class="error_next_box"></span>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button id="name_change_button" type="submit" class="btn btn-primary">변경하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div class="modal fade" id="nicknameModal" tabindex="-1"
		aria-labelledby="nicknameModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="nicknameModalLabel">닉네임 변경</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="nicknameupdate" method="post" accept-charset="utf-8"
					onsubmit="return nicknamesaveconfirm()">
					<div class="modal-body">

						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">닉네임</label> <input
								type="hidden" class="form-control" id="member_id"
								value="${result.member_id}" name="member_id"> <input
								type="text" class="form-control" id="nickname"
								value="${result.nickname}" name="nickname"
								onkeyup="checknickName()"> <span class="error_next_box"></span>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button id="nickname_change_button" type="submit" class="btn btn-primary">변경하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div class="modal fade" id="emailModal" tabindex="-1"
		aria-labelledby="emailModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="emailModalLabel">이메일 변경</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="emailupdate" method="post" accept-charset="utf-8"
					onsubmit="return emailsaveconfirm()">
					<div class="modal-body">

						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">이메일</label> <input
								type="hidden" class="form-control" id="member_id"
								value="${result.member_id}" name="member_id"> <input
								type="email" class="form-control" id="email"
								value="${result.email}" name="email" onkeyup="isEmailCorrect()">
							<span class="error_next_box"></span>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button id="email_change_button"type="submit" class="btn btn-primary">변경하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>



	<div class="modal fade" id="telModal" tabindex="-1"
		aria-labelledby="telModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="telModalLabel">휴대전화 변경</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="telupdate" method="post" accept-charset="utf-8"
					onsubmit="return telsaveconfirm()">
					<div class="modal-body">

						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">휴대전화</label> <input
								type="hidden" class="form-control" id="member_id"
								value="${result.member_id}" name="member_id"> <input
								type="tel" class="form-control" id="tel" value="${result.tel}"
								name="tel" onkeyup="checkPhoneNum()"> <span
								class="error_next_box"></span>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button id="tel_change_button" type="submit" class="btn btn-primary">변경하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div class="modal" tabindex="-1" id="deleteModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">계정연동취소</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="${pageContext.request.contextPath}/social/delete"
					method="post" accept-charset="utf-8">
					<div class="modal-body">
						<p>
							계정연동을 취소하시겠습니까?<br>연동을 취소한 계정은 다시 연동을 할 수 있습니다.
						</p>
						<input type="hidden" class="form-control" id="social_id"
							value="${social_id}" name="id">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">계정연동취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<footer> &copy; 2024 tayotayo </footer>

</body>
</html>