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
<style>

.MyView-module__link_login___HpHMW {
    display: block;
    margin-top: 13px;
    padding: 17px 0;
    border: 1px solid rgba(0,0,0,.06);
    border-radius: 4px;
    background-color: #03c75a;
    -webkit-box-shadow: 0 2px 4px 0 rgba(3,199,90,.12);
    box-shadow: 0 2px 4px 0 rgba(3,199,90,.12);
    text-decoration: none;
    color: #fff;
}

.MyView-module__naver_logo____Y442 {
    background-image: url(https://pm.pstatic.net/resources/asset/sp_main.2b26eb67.png);
    background-size: 434px 416px;
    background-position: -120px -166px;
    background-repeat: no-repeat;
    width: 72px;
    height: 14px;
    display: inline-block;
    margin: 3px 8px 0 0;
    vertical-align: top;
}

</style>
<body>
	<a href="https://nid.naver.com/nidlogin.login?oauth_token=n6378VUgIAWVVZKccC&consumer_key=OrBv0eSYId4RE2chxvPo&logintp=oauth2&nurl=https%3A%2F%2Fnid.naver.com%2Foauth2.0%2Fauthorize%3Fresponse_type%3Dtoken%26state%3D60bb5a13-76e4-4d92-83b0-6c4e68a5cb2f%26client_id%3DOrBv0eSYId4RE2chxvPo%26redirect_uri%3Dhttp%253A%252F%252Flocalhost%253A9999%252Ftayotayo%252Fmember%252Fnaver_callback.jsp%26locale%3Dko_KR%26inapp_view%3D%26oauth_os%3D&locale=ko_KR&inapp_view=&svctype=1"
		class="MyView-module__link_login___HpHMW img" style="text-align: center; display: block; width: 320px; height: 50px;"><i
		class="MyView-module__naver_logo____Y442"><span class="blind"></span></i>로그인</a>

</body>
</html>