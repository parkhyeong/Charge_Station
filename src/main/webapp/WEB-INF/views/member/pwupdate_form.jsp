<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 변경</title>

<jsp:include page="/header.jsp"></jsp:include>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<style>
section {
	max-width: 25rem;
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
<script>
	$(function() {

		$('#pwupdate')
				.click(
						function() {
						if ($("#pw_1").val()=="" || $("#pw_2").val()==""){
							alert('비밀번호를 입력해주세요');
							return false;
						}
							$.ajax({
										type : "post",
										url : "${pageContext.request.contextPath}/member/pwupdate2",
										data : {
											member_id : '${member.member_id}',
											pw_1 : $("#pw_1").val(),
											pw_2 : $("#pw_2").val()
										},
										success : function(data) {
											if (data == 1) {
												alert('비밀번호 변경 성공');
												location.href = "${pageContext.request.contextPath}/member/login_form";
											} else if (data == 0) {
												alert('새 비밀번호가 일치 하지 않습니다.');
											} else {
												alert('비밀번호 변경 실패');
											}
										},
										error : function(request, status, error) {
											alert('오류 발생')
										}

									})//ajax

						})

	})
</script>

</head>
<body>

	<!-- wrapper -->
	<div id="wrapper">

		<!-- section -->
		<section>
			<!-- header -->
			<div id="header">
				<label style="font-size: 30px">비밀번호 변경</label>
			</div>
			<br>

			<!-- 새 비밀번호 -->
			<div>
			
					<label class="form-label" for="id">새 비밀번호</label>
			
				
				<span class="box int_id"> <input class="form-control" type="password" id="pw_1"
					placeholder="" class="int" name="pw_1" required>
				</span>
			</div>
			<br>
			<!-- 새 비밀번호 확인 -->
			<div>
			
					<label class="form-label" for="name">새 비밀번호 확인</label>
				
				<span class="box int_name"> <input class="form-control" type="password" id="pw_2"
					placeholder="" class="int" name="pw_2" required>
				</span>
			</div>

			<br>
			
			<!-- JOIN BTN-->
			<div class="btn_area">
				<button type="button" class="btn btn-outline-primary" id="pwupdate">
					<span>비밀번호 변경</span>
				</button>
			</div>
		</section>
	</div>

</body>
</html>