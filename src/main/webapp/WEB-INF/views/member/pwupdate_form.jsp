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
	
<script>
$(function(){

	$('#pwupdate').click(function(){
		
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/pwupdate2",
			data: {
				member_id:'${member.member_id}',
				pw_1:$("#pw_1").val(),
				pw_2:$("#pw_2").val()
			},
			success: function(data){
				if(data ==1){
					alert('비밀번호 변경 성공');
					location.href="${pageContext.request.contextPath}/member/login.jsp";
				}
				else if (data ==0){
					alert('새 비밀번호가 일치 하지 않습니다.');
				}
				else {
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
	<!-- header -->
	<div id="header">
		<label style="font-size: 30px">비밀번호 변경</label>
	</div>


	<!-- wrapper -->
	<div id="wrapper">

		<!-- section -->
		<section>
			<br>
			
                <!-- 새 비밀번호 -->
                <div>
                    <h3 class="join_title">
                        <label for="id">새 비밀번호</label>
                    </h3>
                    <span class="box int_id">
                        <input type="password" id="pw_1" class="int" name="pw_1" required>
                    </span>
                </div>
                
				<!-- 새 비밀번호 확인 -->
				<div>
					<h3 class="join_title">
						<label for="name">새 비밀번호 확인</label>
					</h3>
					<span class="box int_name"> <input type="password" id="pw_2"
						class="int" name="pw_2" required>
					</span> 
				</div>


				<!-- JOIN BTN-->
				<div class="btn_area">
					<button type="button" id="pwupdate">
						<span>비밀번호 변경</span>
					</button>
				</div>
		</section>
	</div>
	
</body>
</html>