<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/header.jsp"></jsp:include>

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

#join {
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
	padding: 30px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	width: 460px;
}
</style>

<script>
/**
 *  전화번호로 찾기 관련 처리
 */
 
 function fn_join(){
		var tel = $('#tel').val();
 		const inputCode = $("#tel_auth_key").val();
 		console.log(inputCode);
 		console.log(tel)
 			const form = document.createElement('form'); // form 태그 생성
			form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
			form.setAttribute('action', '${pageContext.request.contextPath}/member/id_find_form2'); // 전송할 url 지정
			let social = document.createElement('input'); //<input>
			social.setAttribute('type', 'hidden');
			social.setAttribute('name', 'inputCode');
			social.setAttribute('value', inputCode);
			
			let social2 = document.createElement('input'); //<input>
			social2.setAttribute('type', 'hidden');
			social2.setAttribute('name', 'tel');
			social2.setAttribute('value', tel);

			form.appendChild(social);
			form.appendChild(social2);
			
			document.body.appendChild(form);
			form.submit();
 	
 }
 
 $(function() { 
 	let ok=0;
 	let check=0;
 
	$('#join').click(function(){
		
		if($('#name').val() == ""){
			alert("이름을 입력해주세요.");
			return false;
		}
		
		if($('#tel').val() == ""){
			alert("전화번호를 입력해주세요.");
			return false;
		}
	
		if (ok==1){
		fn_join();
		}
		else {
			alert('인증번호 확인을 해주세요.')
		}
	});
	
		//인증 코드 비교
    $("#tel_auth_check_btn").click(function() {
    	var tel = $('#tel').val();
    	const inputCode = $("#tel_auth_key").val(); //인증번호 입력 칸에 작성한 내용 가져오기
    	
	   	 if(check==0){
		 		alert('인증번호 전송을 눌러주세요.')
		 		return false;
		 }
	   	 
    	if(inputCode==""){
    		alert('인증번호를 입력해주세요.')
    		return false;
    	 }
    	
    	$.ajax({
    	 	type : "POST",
			url : "/tayotayo/member/telauthCodeAuth",
			data : {
			tel : tel,
			inputCode : inputCode
			},
			success: function(data){
    	 if(data!="x"){
    		alert('인증번호가 일치합니다.');
    		ok=1;
    		$("#tel").attr("disabled",true);
    		document.querySelector('#tel_auth_btn').style.display = 'none';
    		$("#tel_auth_check_btn").disabled = true;
    		document.querySelector('#tel_auth_check_btn').disabled = true;
 			document.getElementById('tel_auth_check_btn').innerText = '인증 성공';
    	}else{
        	alert('인증번호가 불일치 합니다. 다시 확인해주세요!');

    	}},error: function(data){
				alert("오류가 발생했습니다.");
		}
    	 
    	});
    });
    
	$("#tel_auth_btn").click(function(){	     	 
    	 var tel = $('#tel').val();
    	 var name = $('#name').val();

    	 
    	 if(tel == ''){
    	 	alert("전화번호를 입력해주세요.");
    	 	return false;
    	 }
    	 
    	 $.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/member/send-one",
			data : {
				tel : tel,
				name : name
			},
			success: function(data){
			if(data==0){
				alert("등록되지 않은 전화번호 입니다.");
			}
			else{
				check=1;
				alert("인증번호가 발송되었습니다.");
				}
			},
			error: function(data){
				alert("오류가 발생했습니다.");
			}
		}); 
	});
	

 });

</script>
</head>
<body>

	<section>
		<!-- header -->
	<div id="header">
		<label style="font-size: 30px"><b>아이디 찾기</b></label>
	</div>
	
		<label><b>본인확인 휴대전화로 인증</b></label>
		<br>
		
		<div>
			<h3 class="join_title">
				<label for="email">이름</label>
			</h3>
			<span class="box int_email"> <input type="text" id="name"
				class="int" name="name" maxlength="100" placeholder="이름 입력"
				required>
			</span>
		</div>
		
		<!-- tel -->
		<div>
			<h3 class="join_title">
				<label for="tel">전화번호</label>
			</h3>
			<span class="box int_email"> <input type="tel" id="tel"
				class="int" name="tel" maxlength="100" placeholder="휴대전화 입력"
				required>
			</span>
		</div>

		<br> <input type="button" class="btn btn-outline-primary" value="인증번호 전송"
			id="tel_auth_btn" style="padding-top: 9px; padding-bottom: 8px;">
		<br>
		<br>
		
		<!-- 전화번호 인증번호 -->
		<div>
			<h3 class="join_title">
				<label for="number">인증번호</label>
			</h3>
			<span class="box int_mobile"> <input type="number" id="tel_auth_key"
				class="int" name="tel_auth_key" required>
			</span>
		</div>
<br>
<button type="button" class="btn btn-outline-primary" id="tel_auth_check_btn" style="padding-top: 9px; padding-bottom: 8px;">인증번호 확인</button>
<br><br>
		<!-- JOIN BTN-->
		<div class="btn_area">
			<button type="button" id="join">
				<span>ID찾기</span>
			</button>
		</div>

	</section>
	<!-- section -->


</body>
</html>