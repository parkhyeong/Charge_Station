<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내 아이디찾기</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>

 <!-- 내 아이디 조회 -->
                <div>
                    <h3 class="join_title">
                        <label for="id">내 타요타요 아이디</label>
                    </h3>
                    <span class="box int_id">
                        <input type="text" value="${member.member_id}">
                    </span>
                </div>
                
</body>
</html>