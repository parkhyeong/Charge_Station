<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc000838267eca6928506435ba12fcc9"></script>
<script type="text/javascript">
	$(function() {
		queryString = window.location.search.substring(1)
		urlParams = new URLSearchParams(queryString)
	    stationID = urlParams.get('es_statId')
		
		$.ajax({
			url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerInfo',
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
				statInfo = statList[0]
				
				console.log(json)
				console.log(statList)
				
				/* 충전요금 어디서 가져오지 */
				
				
				$('#statNm').append(statInfo.statNm)
				
				chgerType = null
				if(statInfo.chgerType = '01') {
					chgerType = 'DC차데모'
				} else if(statInfo.chgerType = '02') {
					chgerType = 'AC완속'
				} else if(statInfo.chgerType = '03') {
					chgerType = 'DC차데모+AC3상'
				} else if(statInfo.chgerType = '04') {
					chgerType = 'DC콤보'
				} else if(statInfo.chgerType = '05') {
					chgerType = 'DC차데모+DC콤보'
				} else if(statInfo.chgerType = '06') {
					chgerType = 'DC차데모+AC3상+DC콤보'
				} else if(statInfo.chgerType = '07') {
					chgerType = 'AC3상'
				} else if(statInfo.chgerType = '08') {
					chgerType = 'DC콤보(완속)'
				}
				$('#chgerType').append(chgerType)
				
				
				$('#addr').append(statInfo.addr)
				$('#busiCall').append(statInfo.busiCall)
				$('#busiNm').append(statInfo.busiNm)
				if(statInfo.parkingFree == 'Y'){
					$('#parkingFree').append('유료')
				} else if(statInfo.parkingFree == 'N'){
					$('#parkingFree').append('무료')
				} else {
					$('#parkingFree').append('현장확인바람')
				}
				$('#useTime').append(statInfo.useTime)
				if(statInfo.limitYn == 'N'){
					$('#limit').append('제한 없음')
				} else {
					$('#limit').append(statInfo.limitDetail)
				}
				$('#location').append(statInfo.location)
				
				
				for(let i = 0; i < statList.length; i++) {
					$('#chargersInfo').append('<tr>')
					$('#chargersInfo').append('<td>' + statList[i].chgerId + '</td>')
					
					stat = null
					if(statList[i].stat == 1) {	// 충전기상태(1: 통신이상, 2: 충전대기, 3: 충전중, 4: 운영중지, 5: 점검중, 9: 상태미확인)
						stat = '통신이상'
					} else if(statList[i].stat == 2) {
						stat = '충전대기'
					} else if(statList[i].stat == 3) {
						stat = '충전중'
					} else if(statList[i].stat == 4) {
						stat = '운영중지'
					} else if(statList[i].stat == 5) {
						stat = '점검중'
					} else if(statList[i].stat == 9) {
						stat = '상태미확인'
					}
					
					$('#chargersInfo').append('<td>' + stat + '</td>')
					$('#chargersInfo').append('<td>' + dateFormat(statList[i].statUpdDt) + '</td>')
					$('#chargersInfo').append('<td>' + dateFormat(statList[i].lastTsdt) + '</td>')
					$('#chargersInfo').append('<td>' + dateFormat(statList[i].lastTedt) + '</td>')
					$('#chargersInfo').append('<td>' + dateFormat(statList[i].nowTsdt) + '</td>')
					$('#chargersInfo').append('</tr>')
				}
				
				
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(statInfo.lat, statInfo.lng), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

				// 마커가 표시될 위치입니다 
				var markerPosition = new kakao.maps.LatLng(statInfo.lat, statInfo.lng);

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					position : markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
			}
				
		})
	})
	
	
	function dateFormat(date) {
		if(date.length < 14) {
			return ''
		}
		
		var year = date.substring(0, 4);
		var month = date.substring(4, 6);
		var day = date.substring(6, 8);
		var hour = date.substring(8, 10);
		var minute = date.substring(10, 12);
		var second = date.substring(12, 14);

		var parsedDate = new Date(year, month - 1, day, hour, minute, second);

		var formattedDate = ("0" + parsedDate.getFullYear()).slice(-2) + '-' +
		                    ("0" + (parsedDate.getMonth() + 1)).slice(-2) + '-' +
							("0" + parsedDate.getDate()).slice(-2) + ' ' +
		                    ("0" + parsedDate.getHours()).slice(-2) + ':' +
		                    ("0" + parsedDate.getMinutes()).slice(-2) + ':' +
		                    ("0" + parsedDate.getSeconds()).slice(-2);
		                    
		return formattedDate
	}
</script>
</head>
<body>

	<jsp:include page="/header.jsp"></jsp:include>

	<div class="container mt-5">
		<h4>테스트용 페이지 이동 버튼</h4>
		<button type="button" class="btn btn-primary" onclick="location.href='/tayotayo/chargers/details?es_statId=HS001452'">HS001452</button>
		<button type="button" class="btn btn-primary" onclick="location.href='/tayotayo/chargers/details?es_statId=CSCS1023'">CSCS1023</button>
		<button type="button" class="btn btn-primary" onclick="location.href='/tayotayo/chargers/details?es_statId=HS001456'">HS001456</button>
		<button type="button" class="btn btn-primary" onclick="location.href='/tayotayo/chargers/details?es_statId=HY000552'">HY000552</button>
	</div>
	<div class="container mt-5">
		<h2 id="statNm"></h2>
		<button type="button" class="btn btn-secondary">즐겨찾기 버튼 넣을 임시 위치</button>
		<button type="button" class="btn btn-warning">이 충전소를 즐겨찾기 등록했다면 이런 모습으로</button>
		<table class="table">
			<tr>
				<td>충전기 타입</td>
				<td id="chgerType"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td id="addr"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td id="busiCall"></td>
			</tr>
			<tr>
				<td>운영기관</td>
				<td id="busiNm"></td>
			</tr>
			<tr>
				<td>주차비</td>
				<td id="parkingFree"></td>
			</tr>
			<tr>
				<td>충전요금</td>
				<td></td>
			</tr>
			<tr>
				<td>영업시간</td>
				<td id="useTime"></td>
			</tr>
			<tr>
				<td>이용자제한</td>
				<td id="limit"></td>
			</tr>
		</table>
	</div>
	<div class="container mt-5">
		<h2>충전기 상태정보</h2>
		<h6 id="location">충전기 위치 : </h6>
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
			<tbody id="chargersInfo">
				
			</tbody>
		</table>
	</div>
	<div class="container mt-5">
		<h2>리뷰목록</h2>
		<button>최근순</button> <button>좋아요순</button>
		<table class="table">
			<thead>
					<tr>
						<th scope="col">별점</th>
						<th scope="col">좋아요</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
			<tbody id="reviews">
				
			</tbody>
		</table>
	</div>

	<div class="container mt-5" style="height: 500px;">
		<div id="map" style="width: 100%; height: 350px;"></div>
	</div>

</body>
</html>
	