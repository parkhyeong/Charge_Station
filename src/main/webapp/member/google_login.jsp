<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>구글 로그인</title>
<script src="https://accounts.google.com/gsi/client" async defer></script>

</head>


<body>
	<div id="g_id_onload" data-client_id="821346046164-9me4cvkknk4qog5du6gnqk0i62hsnjj9.apps.googleusercontent.com"
		data-callback="handleCredentialResponse"></div>
	<div class="g_id_signin" data-type="standard" data-text="signin_with" data-size="large" style="weight:80px; height:auto"></div>

	<script>
		function handleCredentialResponse(response) {
			// decodeJwtResponse() is a custom function defined by you
			// to decode the credential response.
			const responsePayload = parseJwt(response.credential);

			console.log("ID: " + responsePayload.sub);
			console.log('Full Name: ' + responsePayload.name);
			console.log('Given Name: ' + responsePayload.given_name);
			console.log('Family Name: ' + responsePayload.family_name);
			console.log("Image URL: " + responsePayload.picture);
			console.log("Email: " + responsePayload.email);
			console.log("Email: " + responsePayload.mobile);
			
            const form = document.createElement('form'); // form 태그 생성
            form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
            form.setAttribute('action', 'socialinsert'); // 전송할 url 지정
            
            let social = document.createElement('input'); //<input>
            social.setAttribute('name', 'email')
            social.setAttribute('value', responsePayload.email)
            

            let social2 = document.createElement('input');
            social2.setAttribute('name','member_id');
            social2.setAttribute('value',responsePayload.sub);
            
            
            let social3 = document.createElement('input');
            social3.setAttribute('name','type');
            social3.setAttribute('value','google');
            
            
            form.appendChild(social);
            form.appendChild(social2);
            form.appendChild(social3);
            
            document.body.appendChild(form);
            form.submit();
		};

		function parseJwt(token) {
			const base64Url = token.split('.')[1];
			const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
			const jsonPayload = decodeURIComponent(atob(base64).split('').map(
					function(c) {
						return '%'
								+ ('00' + c.charCodeAt(0).toString(16))
										.slice(-2);
					}).join(''));

			return JSON.parse(jsonPayload);
		};
	</script>
</body>
</html>