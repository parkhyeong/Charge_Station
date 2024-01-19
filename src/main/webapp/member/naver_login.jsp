<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>네이버 로그인</title>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>


	<!-- 아래와같이 아이디를 꼭 써준다. -->
	<a id="naverIdLogin_loginButton" href="javascript:void(0)"><img src="${pageContext.request.contextPath}/resources/img/naver.png"></a>

	<script>
	var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "OrBv0eSYId4RE2chxvPo",
				callbackUrl: "http://localhost:9999/tayotayo/member/naver_callback.jsp",
				isPopup: false, /* 팝업을 통한 연동처리 여부 */
				isPopup: false,
				callbackHandle: true
			}
		);
		
		/* 설정정보를 초기화하고 연동을 준비 */
		naverLogin.init();
	
	</script>
</body>
</html>