<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.table-info {
		width: 110px;
	}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bc000838267eca6928506435ba12fcc9"></script>
<script type="text/javascript">
	$(function() {
		// 전달받은 url에서 충전소 ID를 추출
		queryString = window.location.search.substring(1)
		urlParams = new URLSearchParams(queryString)
	    stationID = urlParams.get('es_statId')
	    
	    // 페이지가 로딩중일 때 보여줄 연출 처리
	    $('#chargersInfo').append('<tr><td colspan="6"><span class="spinner-border spinner-border-sm"></span>로딩중</td></tr>')
	    $('#reviews').append('<tr><td colspan="6"><span class="spinner-border spinner-border-sm"></span>로딩중</td></tr>')
		
	    // 충전소ID를 통해 충전기 정보 획득
		$.ajax({
			url: 'https://apis.data.go.kr/B552584/EvCharger/getChargerInfo',
			data: {
				serviceKey: 'zutr+3KJ/EBSrJ4x/HLtr37BE2/zH0Uivb1tFG7Skl4UPhI5rUSUznwKHaMk317tK9mwP/89PRB4WJG36p+cZg==',
				pageNo: '1',
				numOfRows: '150',
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
				
				
				// 충전소 정보 입력 시작
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
				$('#chgerType').append('<span class="badge bg-success">' + chgerType + '</span> <span class="badge bg-primary">' + statInfo.output + ' kw</span>')
				
				
				$('#addr').append(statInfo.addr)
				$('#busiCall').append(statInfo.busiCall)
				$('#busiNm').append(statInfo.busiNm)
				if(statInfo.parkingFree == 'Y'){
					$('#parkingFree').append('<span class="badge bg-danger">유료</span>')
				} else if(statInfo.parkingFree == 'N'){
					$('#parkingFree').append('<span class="badge bg-success">무료</span>')
				} else {
					$('#parkingFree').append('<span class="badge bg-secondary">현장확인바람</span>')
				}
				$('#useTime').append(statInfo.useTime)
				if(statInfo.limitYn == 'N'){
					$('#limit').append('제한 없음')
				} else {
					$('#limit').append(statInfo.limitDetail)
				}
				
				
				loc = '정보 없음'
				if(statInfo.location != null && statInfo.location != 'null') {
					loc = statInfo.location
				} else {
					$('#locBtn').prop("disabled", true)
					$('#locBtn').html('사진 없음')
				}
				$('#location').append(loc)
				// 충전소 정보 입력 끝
				
				
				// 충전기 정보 입력 시작
				var actives = 0;				
				$('#chargersInfo').empty()
				
				for(let i = 0; i < statList.length; i++) {
					infoScript = '<tr><td>' + statList[i].chgerId + '</td>'
					
					stat = null
					if(statList[i].stat == 1) {	// 충전기상태(1: 통신이상, 2: 충전대기, 3: 충전중, 4: 운영중지, 5: 점검중, 9: 상태미확인)
						stat = '<span style="color:gray">◆</span>통신이상'
					} else if(statList[i].stat == 2) {
						stat = '<span style="color:green">●</span>충전대기'
						actives++
					} else if(statList[i].stat == 3) {
						stat = '<span style="color:orange">●</span>충전중'
					} else if(statList[i].stat == 4) {
						stat = '<span style="color:gray">■</span>운영중지'
					} else if(statList[i].stat == 5) {
						stat = '<span style="color:gray">▲</span>점검중'
					} else if(statList[i].stat == 9) {
						stat = '<span style="color:gray">▼</span>상태미확인'
					}
					
					infoScript += '<td>' + stat + '</td>'
					infoScript += '<td>' + dateFormat(statList[i].statUpdDt) + '</td>'
					infoScript += '<td>' + dateFormat(statList[i].lastTsdt) + '</td>'
					infoScript += '<td>' + dateFormat(statList[i].lastTedt) + '</td>'
					infoScript += '<td>' + dateFormat(statList[i].nowTsdt) + '</td>'
					infoScript += '</tr>'
					$('#chargersInfo').append(infoScript)
				}
				
				$('#active').append(actives + '대 / ' + statList.length + '대')
				// 충전기 정보 입력 끝
				
				
				// 지도 핀 찍어주는 파트
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
			},
			error: function(request, status, error) {
				$('#body').empty()
				$('#body').append('<h2>충전소 정보 로딩 실패</h2>')
				$('#body').append('<h6>' + status + '</h6>')
				$('#body').append('<h6>' + error + '</h6>')
				$('#body').append('<h6>페이지를 새로고침해주세요</h6>')
			}
				
		})
		
		// 페이지가 로딩될 때 디폴트로 최신순 정렬된 리뷰 목록을 가져오도록 처리
		loadReviews(stationID, 'recent')
		
		$.ajax({
			url: 'getReviewAverages',
			data: {
				r_statId: stationID
			},
			dataType: 'json',
			success: function(json) {
				$('#allRank').append(json.All)
				$('#recentRank').append(json.Recent)
			},
			error: function(request, status, error) {
				$('#allRank').append('-')
				$('#recentRank').append('-')
			}
		})
	})
	
	// 리뷰 목록 데이터를 가져오고 입력하는 함수
	function loadReviews(stationID, type){
		$.ajax({
			url: 'getReviews',
			data: {
				r_statId: stationID,
				type: type
			},
			dataType: 'json',
			success: function(json) {
				reviewList = json.reviewList
				
				reviewBtnProp(type)
				$('#reviews').empty()
				$('#reviews').append('<tr><td colspan="5" style="text-align: center;">첫 리뷰 작성자가 되어보세요</td></tr>')
				reviewBtnProp('none')
				
				reviewHTML = '<tr>'
				
				if(reviewList.length > 0) {
					for(let i = 0; i < reviewList.length; i++) {
						reviewHTML += '<td>' + reviewList[i].r_rank + '</td>'
						reviewHTML += '<td>' + reviewList[i].r_like + '</td>'
						
						title = "<a href='${pageContext.request.contextPath}/review/initReviewBoardDetail.jsp?r_no=" + reviewList[i].r_no
								+ "&r_num=" + reviewList[i].r_num + "'>" + reviewList[i].r_title + "</a>"
						
						reviewHTML += '<td>' + title + '</td>'
						reviewHTML += '<td>' + reviewList[i].r_writer + '</td>'
						
						var formattedDate = new Date(reviewList[i].r_time).toISOString().split('T')[0];
						reviewHTML += '<td>' + formattedDate + '</td>'
						reviewHTML += '</tr>'
					}					
					
					$('#reviews').empty()
					$('#reviews').append(reviewHTML)
					
					reviewBtnProp(type)
				}
			}
		})
	}
	
	// 리뷰 정렬 버튼 조작용
	function reviewBtnProp(type) {
		if(type == 'recent') {
			$('#reviewRecentBtn').prop("disabled", true)
			$('#reviewLikedBtn').prop("disabled", false)
		} else if(type == 'like') {
			$('#reviewRecentBtn').prop("disabled", false)
			$('#reviewLikedBtn').prop("disabled", true)
		} else if(type == 'none') {
			$('#reviewRecentBtn').prop("disabled", true)
			$('#reviewLikedBtn').prop("disabled", true)
		}
	}
	
	
	// 충전소 api에서 받아오는 시간 정보를 보기 좋은 형태로 가공
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
	<div id="top">
		<jsp:include page="/header.jsp"></jsp:include>
	</div>

	<div class="container mt-5">
		<h4>테스트용 페이지 이동 버튼</h4>
		<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/chargers/details_test.jsp'">테스트페이지로 복귀</button>
	</div>
	
	<!-- 메인 div 영역 -->
	<div id="body" class="container mt-5">
	
		<!-- 충전소 상세정보 div 영역 -->
		<div class="container mt-5">
			<h2 id="statNm"></h2>
			<table class="table">
				<tr>
					<td class="table-info">충전기 타입</td>
					<td id="chgerType"></td>
				</tr>
				<tr>
					<td class="table-info">주소</td>
					<td id="addr"></td>
				</tr>
				<tr>
					<td class="table-info">전화번호</td>
					<td id="busiCall"></td>
				</tr>
				<tr>
					<td class="table-info">운영기관</td>
					<td id="busiNm"></td>
				</tr>
				<tr>
					<td class="table-info">주차비</td>
					<td id="parkingFree"></td>
				</tr>
				<tr>
					<td class="table-info">충전요금</td>
					<td></td>
				</tr>
				<tr>
					<td class="table-info">영업시간</td>
					<td id="useTime"></td>
				</tr>
				<tr>
					<td class="table-info">이용자제한</td>
					<td id="limit"></td>
				</tr>
			</table>
		</div>
		
		<!-- 충전기 상태정보 div 영역 -->
		<div class="container mt-5 d-grid">
			<h2>충전기 상태정보</h2>
			<h6 id="active">충전 가능한 충전기 갯수 : </h6>
			<h6>충전기 위치 : 
				<span id="location"></span> 
				<button id="locBtn" type="button" class="btn btn-outline-success btn-sm">사진으로 보기</button>
			</h6>
			<table class="table table-striped">
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
					<!-- jQuery를 통해 충전기 개별정보가 삽입됨 -->
				</tbody>
			</table>
			<button type="button" class="btn btn-outline-danger"
				onClick="location.href='${pageContext.request.contextPath}/mycard/payAction.jsp?statId=${chargersVo.es_statId}&es_statNm=${chargersVo.es_statNm }'">
				선불결제
			</button>
		</div>
		
		<!-- 리뷰 div 영역 -->
		<div class="container mt-5">
			<h2>리뷰목록 
				<button type="button" class="btn btn-danger"
					onClick="location.href='${pageContext.request.contextPath}/review/initReviewBoardInsert.jsp?es_statId=${chargersVo.es_statId}&es_statNm=${chargersVo.es_statNm }'">
					리뷰 작성하기
				</button>
			</h2>
			<h6 id="allRank">전체 별점 : </h6>
			<h6 id="recentRank">최근 1달 별점 : </h6>
			<div class="btn-group container-fluid px-0">
				<button id="reviewRecentBtn" type="button" class="btn btn-outline-success col-6" onClick="loadReviews('${chargersVo.es_statId}', 'recent')">최근순</button> 
				<button id="reviewLikedBtn"type="button" class="btn btn-outline-primary col-6" onClick="loadReviews('${chargersVo.es_statId}', 'like')">좋아요순</button>
			</div>
			<table class="table table-striped">
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
					<!-- 리뷰 목록 삽입 위치 -->
				</tbody>
			</table>
		</div>

		<!-- 지도 div 영역 -->	
		<div class="container mt-5" style="height: 500px;">
			<h2>충전소 상세위치</h2>
			<div id="map" style="width: 100%; height: 350px;"></div>
		</div>
	</div>
</body>
</html>
	