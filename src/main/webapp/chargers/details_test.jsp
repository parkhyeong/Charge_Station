<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		/*
			충전기상태(1: 통신이상, 2: 충전대기, 3: 충전중, 4: 운영중지, 5: 점검중, 9: 상태미확인)
		*/
		
		$('#b1').click(function() {
			pageNo = $('#input1').val()
			
			$.ajax({
				url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerStatus',
				data: {
					serviceKey: 'zutr+3KJ/EBSrJ4x/HLtr37BE2/zH0Uivb1tFG7Skl4UPhI5rUSUznwKHaMk317tK9mwP/89PRB4WJG36p+cZg==',
					pageNo: pageNo,
					numOfRows: '100',
					period: '5',
					zcode: '11',
					dataType: 'JSON'
				},
				dataType: 'json',
				success: function(json) {
					statList = json.items.item
					
					$('#result').empty()
					
					for(let i = 0; i < statList.length; i++) {
						if(i % 10 == 0) {
							$('#result').append('<tr>')
						}
						
						$('#result').append('<td>' + statList[i].statId + '</td>')
						
						if(i % 10 == 9) {
							$('#result').append('</tr>')
						}
						
					}
				}
					
			})
			
		})
		
		
		$('#b2').click(function() {
			statId = $('#input2').val()
			
			location.href = '${pageContext.request.contextPath}/chargers/details?es_statId=' + statId
			
		})
	})
</script>

</head>
<body>

	<%-- <jsp:include page="/header.jsp"></jsp:include> --%>

	<div>
		<div class="container mt-5">
			<input id="input1" placeholder="페이지번호"><button id="b1">충전소ID 가져오기(서울지역 100개)</button>
			<br>
			statID : <input id="input2" placeholder="충전소ID"><button id="b2">상세페이지로 이동</button>
		</div>
		<div>
			<!-- 충전소 정보(충전타입, 충전속도) -- db에서 불러오기 -->
		</div>
		<div class="container mt-5">
			<h2>충전소ID 목록</h2>
			<table class="table">
				<tbody id="result">
					
				</tbody>
			</table>
		</div>

	</div>

</body>
</html>