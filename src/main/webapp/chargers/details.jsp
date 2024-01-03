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
			
			$.ajax({
				url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerStatus',
				data: {
					serviceKey: 'zutr+3KJ/EBSrJ4x/HLtr37BE2/zH0Uivb1tFG7Skl4UPhI5rUSUznwKHaMk317tK9mwP/89PRB4WJG36p+cZg==',
					pageNo: '1',
					numOfRows: '500',
					period: '5',
					zcode: '11',
					dataType: 'JSON'
				},
				dataType: 'json',
				success: function(json) {
					statList = json.items.item
					
					console.log(statList)
				}
					
			})
			
		})
		
		
		$('#b2').click(function() {
			
			$.ajax({
				url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerStatus',
				data: {
					serviceKey: 'zutr+3KJ/EBSrJ4x/HLtr37BE2/zH0Uivb1tFG7Skl4UPhI5rUSUznwKHaMk317tK9mwP/89PRB4WJG36p+cZg==',
					pageNo: '1',
					numOfRows: '10',
					period: '5',
					zcode: '11',
					statId: 'HS001452',
					dataType: 'JSON'
				},
				dataType: 'json',
				success: function(json) {
					statList = json.items.item
					
					console.log(json)
					console.log(statList)
					
					for(let i = 0; i < statList.length; i++) {
						$('#result').append('<tr>')
						$('#result').append('<td>' + statList[i].chgerId + '</td>')
						$('#result').append('<td>' + statList[i].stat + '</td>')
						$('#result').append('<td>' + statList[i].statUpdDt + '</td>')
						$('#result').append('<td>' + statList[i].lastTsdt + '</td>')
						$('#result').append('<td>' + statList[i].lastTedt + '</td>')
						$('#result').append('<td>' + statList[i].nowTsdt + '</td>')
						$('#result').append('</tr>')
					}
				}
					
			})
			
		})
		
		
		$('#b3').click(function() {
			
			stationID = $('#stationId').val()
			$('#result').html('')
			
			$.ajax({
				url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerStatus',
				data: {
					serviceKey: 'zutr+3KJ/EBSrJ4x/HLtr37BE2/zH0Uivb1tFG7Skl4UPhI5rUSUznwKHaMk317tK9mwP/89PRB4WJG36p+cZg==',
					pageNo: '1',
					numOfRows: '10',
					period: '5',
					zcode: '11',
					statId: stationID,
					dataType: 'JSON'
				},
				dataType: 'json',
				success: function(json) {
					statList = json.items.item
					
					console.log(json)
					console.log(statList)
					
					for(let i = 0; i < statList.length; i++) {
						$('#result').append('<tr>')
						$('#result').append('<td>' + statList[i].chgerId + '</td>')
						$('#result').append('<td>' + statList[i].stat + '</td>')
						$('#result').append('<td>' + statList[i].statUpdDt + '</td>')
						$('#result').append('<td>' + statList[i].lastTsdt + '</td>')
						$('#result').append('<td>' + statList[i].lastTedt + '</td>')
						$('#result').append('<td>' + statList[i].nowTsdt + '</td>')
						$('#result').append('</tr>')
					}
				}
					
			})
			
		})
	})
</script>

</head>
<body>

	<div>
		<!-- 헤더 삽입 위치 -->
	</div>

	<div>
		<div>
			<!-- 충전소 명칭 -->
		</div>
		<div class="container mt-5">
			<button id="b1">충전소 상태 api 테스트</button>
			<button id="b2">충전소 상태 api 테스트(특정 statId만)</button>
			<br>
			statID : <input id="stationId"><button id="b3">충전소 상태정보 불러오기</button>
		</div>
		<div class="container mt-5">
			<button type="button" class="btn btn-primary" onclick="location.href='/tayotayo/chargers/details?es_statId=HS001452'">HS001452 뷰페이지로 이동</button>
		</div>
		<div>
			<!-- 충전소 정보(충전타입, 충전속도) -- db에서 불러오기 -->
		</div>
		<div class="container mt-5">
			<!-- 개별충전기 목록 -->
			<!-- table? -->
			<!-- api를 통해서 충전기 사용가능여부 불러오기 -->
			<h2>개별 충전기 목록</h2>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">충전기ID</th>
						<th scope="col">충전기 상태</th>
						<th scope="col">상태갱신일시</th>
						<th scope="col">마지막 충전시작일시</th>
						<th scope="col">마지막 충전종료일시</th>
						<th scope="col">충전중시작일시</th>
					</tr>
				</thead>
				<tbody id="result">
				
				</tbody>
			</table>
		</div>

	</div>

</body>
</html>