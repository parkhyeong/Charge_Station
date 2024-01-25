<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="/header.jsp"></jsp:include>

<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
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
  max-width: 25rem;
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
alert("연동이 되지않은 계정입니다.\n타요타요계정과 연동이 필요합니다.");
$(function() {
	$('#login').click(function(){
		  let member_id = $('#member_id').val();
		  let pw = $('#password').val();

		  $.ajax({
			type: "post",
			url: "login_peristalsis",
			data: {
				member_id: member_id,
			  	pw:pw
			},
			success: function(data){
				if (data == 1){
					 $.ajax({
						type : "post",
						url : "social_memberid_update",
						data : {
							member_id : member_id,
							pw : pw,
							id : '${social.id}',
							type : '${social.type}'
						},
						success : function(data) {
							if (data==1){
							alert('계정이 연동되었습니다.\n로그인 성공')
							location.href = "${pageContext.request.contextPath}/index.jsp"
							}
							else {
								alert('로그인 실패')
							}
						},
						error : function(request, status, error) {
							alert('오류')
						}
						
					 });
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
	var element = document.getElementById("typevalue");
	if ('${social.type}'=='naver'){
		element.innerText ='네이버'
	}
	else if ('${social.type}'=='kakao'){
		element.innerText ='카카오'
	}
	else if ('${social.type}'=='google'){
		element.innerText ='구글'
	}
})//$



function goPost(){
	const form = document.createElement('form'); // form 태그 생성
	form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
	form.setAttribute('action', 'creat_account_peristalsis'); // 전송할 url 지정

	let social = document.createElement('input'); //<input>
	social.setAttribute('type', 'hidden');
	social.setAttribute('name', 'id');
	social.setAttribute('value', '${social.id}');

	let social2 = document.createElement('input');
	social2.setAttribute('type', 'hidden');
	social2.setAttribute('name', 'type');
	social2.setAttribute('value','${social.type}');

	form.appendChild(social);
	form.appendChild(social2);

	document.body.appendChild(form);
	form.submit();
	
}


</script>

</head>
<body>
<main class="main">
  <div class="container2">
    <section class="wrapper">
      <div class="heading">
        <h3><span id="typevalue"></span> 계정연동<br><b>타요타요 로그인</b></h3>
      </div>
      
      <div class="form">
        <div class="input-control">
          <label for="id" class="input-label" hidden>ID</label>
          <input type="text"  id="member_id" class="input-field" name="member_id" placeholder="ID" required>
        </div>
        <div class="input-control">
          <label for="password" class="input-label" hidden>Password</label>
          <input type="password"id="password" class="input-field" name="pw" placeholder="Password" required>
        </div>
        <div class="input-control">
          <a href="${pageContext.request.contextPath}/member/pw_find.jsp" class="text text-links">ID/PW 찾기</a>
          <a href="javascript:void(0)" class="text text-links" onClick="javascript:goPost()">회원가입</a>
          
           <input type="hidden"  id="social_id" name="id" value="${social.id}">
           <input type="hidden"  id="social_type" name="type" value="${social.type}">
         
          <Button type="button" id="login" class="input-submit">계정연동</Button>
        </div>
      </div>
      
    </section>
  </div>
</main>
</body>