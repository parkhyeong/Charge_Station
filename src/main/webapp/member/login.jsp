<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타요타요 로그인</title>

<jsp:include page="/header.jsp"></jsp:include>

<style type="text/css">
	:root {
  --color-white: #ffffff;
  --color-light: #f1f5f9;
  --color-black: #121212;
  --color-night: #001632;
  --color-red: #f44336;
  --color-blue: #1a73e8;
  --color-gray: #80868b;
  --color-grayish: #dadce0;
  --shadow-normal: 0 1px 3px 0 rgba(0, 0, 0, 0.1),
    0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --shadow-medium: 0 4px 6px -1px rgba(0, 0, 0, 0.1),
    0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-large: 0 10px 15px -3px rgba(0, 0, 0, 0.1),
    0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

html {
  font-size: 100%;
  font-size-adjust: 100%;
  box-sizing: border-box;
  scroll-behavior: smooth;
}

*,
*::before,
*::after {
  padding: 0;
  margin: 0;
  box-sizing: inherit;
  list-style: none;
  list-style-type: none;
  text-decoration: none;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}

body {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-size: 1rem;
  font-weight: normal;
  line-height: 1.5;
  color: var(--color-black);
  background: var(--color-light);
}

a,
button {
  font-family: inherit;
  font-size: inherit;
  line-height: inherit;
  cursor: pointer;
  border: none;
  outline: none;
  background: none;
  text-decoration: none;
}

img {
  display: block;
  width: 370px;
  height: 60px;

}

.container2 {
  display: flex;
  justify-content: center;
  align-items: center;
  max-width: 80rem;
  min-height: 100vh;
  width: 100%;
  padding: 0 2rem;
  margin: 0 auto;
}
<!--
.ion-logo-apple {
  font-size: 1.65rem;
  line-height: inherit;
  margin-right: 0.5rem;
  color: var(--color-black);
}
.ion-logo-google {
  font-size: 1.65rem;
  line-height: inherit;
  margin-right: 0.5rem;
  color: var(--color-red);
}
.ion-logo-facebook {
  font-size: 1.65rem;
  line-height: inherit;
  margin-right: 0.5rem;
  color: var(--color-blue);
}
-->
.text {
  font-family: inherit;
  line-height: inherit;
  text-transform: unset;
  text-rendering: optimizeLegibility;
}
.text-large {
  font-size: 2rem;
  font-weight: 600;
  color: var(--color-black);
}
.text-normal {
  font-size: 1rem;
  font-weight: 400;
  color: var(--color-black);
}
.text-links {
  font-size: 1rem;
  font-weight: 400;
  color: var(--color-blue);
}
.text-links:hover {
  text-decoration: underline;
}

.main .wrapper {
  max-width: 28rem;
  width: 100%;
  margin: 2rem auto;
  padding: 2rem 2.5rem;
  border: none;
  outline: none;
  border-radius: 0.25rem;
  color: var(--color-black);
  background: var(--color-white);
  box-shadow: var(--shadow-large);
}
.main .wrapper .form {
  width: 100%;
  height: auto;
  margin-top: 2rem;
}
.main .wrapper .form .input-control {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.25rem;
}
.main .wrapper .form .input-field {
  font-family: inherit;
  font-size: 1rem;
  font-weight: 400;
  line-height: inherit;
  width: 100%;
  height: auto;
  padding: 0.75rem 1.25rem;
  border: none;
  outline: none;
  border-radius: 2rem;
  color: var(--color-black);
  background: var(--color-light);
  text-transform: unset;
  text-rendering: optimizeLegibility;
}
.main .wrapper .form .input-submit {
  font-family: inherit;
  font-size: 1rem;
  font-weight: 500;
  line-height: inherit;
  cursor: pointer;
  min-width: 40%;
  height: auto;
  padding: 0.65rem 1.25rem;
  border: none;
  outline: none;
  border-radius: 2rem;
  color: var(--color-white);
  background: var(--color-blue);
  box-shadow: var(--shadow-medium);
  text-transform: capitalize;
  text-rendering: optimizeLegibility;
}
.main .wrapper .striped {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  margin: 1rem 0;
}
.main .wrapper .striped-line {
  flex: auto;
  flex-basis: auto;
  border: none;
  outline: none;
  height: 2px;
  background: var(--color-grayish);
}
.main .wrapper .striped-text {
  font-family: inherit;
  font-size: 1rem;
  font-weight: 500;
  line-height: inherit;
  color: var(--color-black);
  margin: 0 1rem;
}
.main .wrapper .method-control {
  margin-bottom: 1rem;
}
.main .wrapper .method-action {
  font-family: inherit;
  font-size: 0.95rem;
  font-weight: 500;
  line-height: inherit;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: auto;
  padding: 0.35rem 1.25rem;
  outline: none;
  border: 2px solid var(--color-grayish);
  border-radius: 2rem;
  color: var(--color-black);
  background: var(--color-white);
  text-transform: capitalize;
  text-rendering: optimizeLegibility;
  transition: all 0.35s ease;
}
.main .wrapper .method-action:hover {
  background: var(--color-light);
}

</style>

<script type="text/javascript">

$(function() {

	$('#login').click(function(){
		  let member_id = $('#member_id').val();
		  let pw = $('#password').val();

		  $.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/login",
			data: {
				member_id: member_id,
			  	pw:pw
			},
			success: function(data){
				if (data == 1){
					alert('로그인 성공')
					location.href="${pageContext.request.contextPath}/mainpage/MainPage.jsp"
					
				}
				else {
					alert('아이디 또는 비밀번호가 틀렸습니다.')
				}
			},
			error : function(request, status, error) {
				alert('오류')
			}
		})
	  
	})
})//$

$(document).ready(function(){
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var idkey = getCookie("idkey");
    $("#member_id").val(idkey); 
     
    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    if($("#member_id").val() != ""){ 
        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("idkey", $("#id").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("idkey");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#member_id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("idkey", $("#member_id").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});

// 쿠키 저장하기 
function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value)
			+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
}

// 쿠키 삭제
function deleteCookie(cookieName) {
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires="
			+ expireDate.toGMTString();
}
 
// 쿠키 가져오기
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if (start != -1) { // 쿠키가 존재하면
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
			end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}
</script>
</head>

<body>

<main class="main">
  <div class="container2">
    <section class="wrapper">
      <div class="heading">
        <h1 class="text text-large">Login</h1>
      </div>
      
      <div class="form">
        <div class="input-control">
          <label for="id" class="input-label" hidden>ID</label>
          <input type="text"  id="member_id" class="input-field" name="member_id" value=""placeholder="ID" required>
        </div>
        <div class="input-control">
          <label for="password" class="input-label" hidden>Password</label>
          <input type="password"id="password" class="input-field" name="pw" placeholder="Password" value="" required>
        </div>
        
        <input type="checkbox" class="save_id" name="checkId" id="checkId">
		<label for="saveId">아이디 저장</label>
        
        
        <div class="input-control">
          <a href="${pageContext.request.contextPath}/member/pw_find.jsp" class="text text-links">ID/PW 찾기</a>
          <a href="${pageContext.request.contextPath}/member/create_account.jsp" class="text text-links">회원가입</a>
          <Button type="button" id ="login" class="input-submit">로그인</Button>
        </div>
        
      </div>
      
      <div class="striped">
        <span class="striped-line"></span>
        <span class="striped-text">Or</span>
        <span class="striped-line"></span>
      </div>
      <div class="method">
        <%@ include file="naver_login.jsp" %><br>

		<%@ include file="kakao_login.jsp" %><br>

        <%@ include file="google_login.jsp" %><br>

      </div>
    </section>
  </div>
</main>

</body>
</html>