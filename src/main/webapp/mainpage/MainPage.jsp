<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요</title>

<style>
#map-container {
	position: relative;
	width: 100vw;
	height: 94vh;
	overflow: hidden;
}

#map {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
}

#panel {
	position: absolute;
	top: 0;
	left: 0;
	width: 20%;
	height: 100%;
	background-color: #f1f1f1;
	transition: left 0.3s;
	z-index: 2;	
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;
	padding: 20px;
	border: 1px solid #ddd;

}

#toggle-btn-test {
	position: absolute;
	right: -50px; /* 오른쪽에 위치 */
	bottom: 50%; /* 높이의 중앙에 위치 */
	transform: translateY(50%); /* 세로 방향으로 중앙 정렬 */
}

#search-options {
	margin-bottom: 10px;
	text-align: center;
}

.search-input {
	padding: 5px;
	width: 80%;
	margin: 0 auto;
	display: block;
	margin-bottom: 10px;
}

.search-btn {
	background-color: #28a745;
	color: #fff;
	padding: 5px 10px;
	margin-right: 5px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

.search-btn2 {
	background-color: #28a745;
	color: #fff;
	padding: 5px 10px;
	margin-right: 5px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

.reset-btn {
	background-color: #dc3545;
	color: #fff;
	padding: 5px 10px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

#nav-bar {
	position: fixed;
	bottom: 3%;
	left: 55%;
	transform: translateX(-50%);
	width: 25cm;
	height: 2cm;
	background-color: #f8f9fa;
	border-left: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;
	overflow: hidden;
	transition: bottom 0.3s, left 0.3s;
	z-index: 2;
}

#result-list {
	width: 100%;
	max-width: 600px;
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
}

/* 결과 항목 스타일 */
.result-item {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.result-item:last-child {
	border-bottom: none;
}

body {
	overflow: hidden;
}

#result-list {
	overflow-y: auto;
}

#nav-bar img {
	vertical-align: middle; /* 이미지와 텍스트를 수직 정렬 */
	margin-right: 5px; /* 이미지와 텍스트 사이의 오른쪽 여백 */
}


h4 {
	color: #333;
}

#search-options {
	margin-bottom: 20px;
}

.search-input {
	width: 100%;
	padding: 8px;
	margin-bottom: 10px;
}

#search-btn, #search-btn2, #submit-my-btn-distance, #reset-btn {
	width: 100%;
	padding: 10px;
	background-color: #0dcaf0;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-bottom: 10px;
}

#search-btn:hover, #search-btn2:hover, #submit-my-btn-distance:hover,
	#reset-btn:hover {
	background-color: #07b1d3;
}

#result-list {
	margin-top: 20px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Map Container -->
	<div id="map-container">
		<!-- 지도 컨테이너 -->
		<div id="map"></div>

		<!-- 패널 -->
		<div id="panel">
			<!-- 패널 내용은 이 부분에 넣으세요 -->
			<h4>충전소 검색</h4>
			<div id="search-options">
				<!-- 검색 옵션 추가 -->
				<input type="text" id="keyword" placeholder="검색어를 입력하세요">
				<button id="search-btn" class="btn" style = "margin-top : 20px">검색하기</button>
				<hr>
				<select class="search-input" name="station-category">
					<option selected value="">군/구 선택</option>
					<option value="강남구">강남구</option>
					<option value="강동구">강동구</option>
					<option value="강북구">강북구</option>
					<option value="강서구">강서구</option>
					<option value="관악구">관악구</option>
					<option value="광진구">광진구</option>
					<option value="구로구">구로구</option>
					<option value="금천구">금천구</option>
					<option value="노원구">노원구</option>
					<option value="도봉구">도봉구</option>
					<option value="동대문구">동대문구</option>
					<option value="동작구">동작구</option>
					<option value="마포구">마포구</option>
					<option value="서대문구">서대문구</option>
					<option value="서초구">서초구</option>
					<option value="성동구">성동구</option>
					<option value="성북구">성북구</option>
					<option value="송파구">송파구</option>
					<option value="양천구">양천구</option>
					<option value="영등포구">영등포구</option>
					<option value="용산구">용산구</option>
					<option value="은평구">은평구</option>
					<option value="종로구">종로구</option>
					<option value="중구">중구</option>
					<option value="중랑구">중랑구</option>
				</select> <select class="search-input" name="charging-station-category"><hr>
					<option selected value="">충전소 분류</option>
					<option value="공공시설">공공시설</option>
					<option value="주차시설">주차시설</option>
					<option value="휴게시설">휴게시설</option>
					<option value="관광시설">관광시설</option>
					<option value="상업시설">상업시설</option>
					<option value="차량정비시설">차량정비시설</option>
					<option value="공동주택시설">공동주택시설</option>
					<option value="근린생활시설">근린생활시설</option>
					<option value="교육문화시설">교육문화시설</option>
					<option value="기타">기타</option>
				</select> <select class="search-input" name="charging-type"><hr>
					<option selected value="">충전기 타입</option>
					<option value="DC차데모">DC차데모</option>
					<option value="AC완속">AC완속</option>
					<option value="DC차데모+AC3상">DC차데모+AC3상</option>
					<option value="DC콤보">DC콤보</option>
					<option value="DC차데모+DC콤보">DC차데모+DC콤보</option>
					<option value="DC차데모+AC3상+DC콤보">DC차데모+AC3상+DC콤보</option>
					<option value="AC3상">AC3상</option>
				</select>
				<!-- 검색, 초기화 버튼 -->
				<hr>
				<button id="search-btn2" class="btn">검색하기</button>
				<button id="submit-my-btn-distance" class="btn">충전소 추천</button>
				<button id="reset-btn" class="btn">초기화하기</button>
				<hr>
			</div>
			<!-- 토글 버튼 테스트-->
			<div id="toggle-btn-test">
				<button class="btn bg-light" id="bt-test" style ="background-color : #f1f1f1">닫기</button>
			</div>
			<!-- 검색 결과 목록 -->
			<div id="result-list"></div>
		</div>
	</div>

	<div id="nav-bar">
		<p>
			<img src="../resources/img/blue2.png" alt="Blue Image" width="50"
				height="70"> 사용가능 <img src="../resources/img/red2.png"
				alt="Red Image" width="45" height="70"> 사용불가능 <img
				src="../resources/img/user3.png" alt="User Image" width="50"
				height="70"> 사용자 위치
		</p>
	</div>



	<!-- modal form -->
	<div class="modal fade" id="chargeDetailModal" tabindex="-1"
		aria-labelledby="chargeDetailModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="chargeDetailModalLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close" style="color: #000 !important;"></button>
				</div>
				<div class="modal-body" id="chargeDetailModalBody"></div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JS-->
	<script type="text/javascript"
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5675f8f4dffbfd2b726b7b6393fd2b78&libraries=clusterer"></script>

	<!-- Your custom scripts -->
	<script>
		$(document)
				.ready(
						function() {
							// 카카오맵 생성
							var markers = [];
							var infoWindow = new kakao.maps.InfoWindow({
								zIndex : 1
							});
							var container = document.getElementById('map');
							var options = {
								center : new kakao.maps.LatLng(37.5666612,
										126.9783785),
								level : 3
							};
							// 지도에 원 선언
							var circle;

							//map 생성
							var map = new kakao.maps.Map(container, options);

							// marker img

							var imageSrcSucc = '../resources/img/blue2.png';
							var imageSrcFail = '../resources/img/red2.png';
							var imageUser = '../resources/img/user3.png';

							var markerImageSucc = new kakao.maps.MarkerImage(
									imageSrcSucc, new kakao.maps.Size(55, 65));
							var markerImageFail = new kakao.maps.MarkerImage(
									imageSrcFail, new kakao.maps.Size(50, 65));
							var markerimageUser = new kakao.maps.MarkerImage(
									imageUser, new kakao.maps.Size(40, 55));

							// 마커 클러스터러를 생성합니다
							var clusterer = new kakao.maps.MarkerClusterer({
								map : map,
								averageCenter : true, // 개별 마커의 평균 위치를 사용하여 클러스터링
								minLevel : 5
							});

							// 사용자 위치 변수
							var userLat = 37.547733817408;
							var userLon = 127.08016373868;

							// page 로딩 시 시작
							$
									.ajax({
										url : "select2",
										success : function(response) {
											if (navigator.geolocation) {
												navigator.geolocation
														.getCurrentPosition(
																function(
																		position) {
																	userLat = position.coords.latitude; // 위도
																	userLon = position.coords.longitude; // 경도

																	// 사용자 위치에 마커 찍기
																	var userMarker = new kakao.maps.Marker(
																			{
																				position : new kakao.maps.LatLng(
																						userLat,
																						userLon),
																				image : markerimageUser
																			});

																	// 페이지 이동
																	map
																			.panTo(new kakao.maps.LatLng(
																					userLat,
																					userLon));

																	// 지도에 마커 추가
																	userMarker
																			.setMap(map);
																	// 마커 클릭 이벤트
																	kakao.maps.event
																			.addListener(
																					marker,
																					'click',
																					function() {
																						apiDetailRequest(es_statId);
																						$(
																								'#chargeDetailModal')
																								.modal(
																										'show');
																					});

																	// 마커에 마우스오버 이벤트
																	kakao.maps.event
																			.addListener(
																					marker,
																					'mouseover',
																					function() {
																						infowindow
																								.open(
																										map,
																										marker);
																					});

																	// 마커에 마우스아웃 이벤트
																	kakao.maps.event
																			.addListener(
																					marker,
																					'mouseout',
																					function() {
																						infowindow
																								.close();
																					});

																},

																function(error) {
																	// 위치를 가져오는 데 문제가 있는 경우
																	console
																			.error(`위치 정보를 가져오는 데 실패했습니다. 오류: ${error.message}`);

																	// 사용자 위치에 마커 찍기
																	var userMarker = new kakao.maps.Marker(
																			{
																				position : new kakao.maps.LatLng(
																						userLat,
																						userLon),
																				image : markerimageUser
																			});

																	// 페이지 이동
																	map
																			.panTo(new kakao.maps.LatLng(
																					userLat,
																					userLon));

																	// 지도에 마커 추가
																	userMarker
																			.setMap(map);

																});
											} else {
												// Geolocation API를 사용할 수 없는 경우
												console
														.error('브라우저에서 Geolocation API를 지원하지 않습니다.');
											}
										}
									});

							// 목록 리스트 클릭 함수
							$(document)
									.on(
											'click',
											'#result-list a',
											function(event) {
												event.preventDefault(); // 현재 페이지로 새로고침하지 않고 지정한 기능만 구현하게 만드는 코드
												var parentDiv = event.target.parentElement;
												var es_lat = parentDiv
														.querySelector('.location-info').dataset.lat;
												var es_lon = parentDiv
														.querySelector('.location-info').dataset.lon;
												var es_statNm = parentDiv
														.querySelector('.location-info').dataset.name;
												var es_statId = parentDiv
														.querySelector('.location-info').dataset.statid;
												var stat = parentDiv
														.querySelector('.location-info').dataset.stat;

												// 마커 초기화
												delmark();

												// 마커 위치 조정
												options = {
													center : new kakao.maps.LatLng(
															es_lat, es_lon),
													level : 4
												};
												map = new kakao.maps.Map(
														container, options);

												// 마커 생성
												if (stat == "2") {
													var marker = new kakao.maps.Marker(
															{
																position : new kakao.maps.LatLng(
																		es_lat,
																		es_lon),
																image : markerImageSucc
															});
												} else {
													var marker = new kakao.maps.Marker(
															{
																position : new kakao.maps.LatLng(
																		es_lat,
																		es_lon),
																image : markerImageFail

															})
												}
												;

												// 마커 지도에 추가
												marker.setMap(map);
												apiDetailRequest(es_statId);

												// 마커에 인포윈도우 추가
												var iwContent = '<div style="padding:5px;">'
														+ es_statNm + '</div>';
												var infowindow = new kakao.maps.InfoWindow(
														{
															content : iwContent

														});

												// 마커 클릭 이벤트
												kakao.maps.event
														.addListener(
																marker,
																'click',
																function() {
																	apiDetailRequest(es_statId);
																	$(
																			'#chargeDetailModal')
																			.modal(
																					'show');
																});

												// 마커에 마우스오버 이벤트
												kakao.maps.event
														.addListener(
																marker,
																'mouseover',
																function() {
																	infowindow
																			.open(
																					map,
																					marker);
																});

												// 마커에 마우스아웃 이벤트
												kakao.maps.event.addListener(
														marker, 'mouseout',
														function() {
															infowindow.close();
														});

												$('#chargeDetailModal').modal(
														'show');
											});

							// 초기화 버튼
							$('#reset-btn').click(function() {
								var resultlist = $('#result-list');
								resultlist.empty();
								location.href = "MainPage.jsp";
							});

						
		// 키워드 검색 시 DataController에서 매핑 시켜서 조인한 테이블 검색
							$('#search-btn')
									.click(
											function() {
												var keyword = $('#keyword')
														.val();
												//console.log(keyword)

												$
														.ajax({
															url : "selectlist2",
															data : {
																es_statNm : keyword,
															},
															success : function(
																	response) {
																renderSearchResults(response);
																// 전체 마커지우기 
																delmark();
																// 마커 다시 찍기&클러스 재등록
																$(response)
																		.each(
																				function(
																						i,
																						json) {
																					if (json.stat == "2") {
																						var marker = new kakao.maps.Marker(
																								{
																									position : new kakao.maps.LatLng(
																											json.es_lat,
																											json.es_lon),
																									image : markerImageSucc
																								});
																					} else {
																						var marker = new kakao.maps.Marker(
																								{
																									position : new kakao.maps.LatLng(
																											json.es_lat,
																											json.es_lon),
																									image : markerImageFail

																								})
																					}
																					;

																					markers
																							.push(marker);

																					// 마커에 인포윈도우 추가
																					var iwContent = '<div style="padding:5px;">'
																							+ json.es_statNm
																							+ '</div>';
																					var infowindow = new kakao.maps.InfoWindow(
																							{
																								content : iwContent
																							});

																					// 마커에 마우스오버 이벤트
																					kakao.maps.event
																							.addListener(
																									marker,
																									'mouseover',
																									function() {
																										infowindow
																												.open(
																														map,
																														marker);
																									});

																					// 마커에 마우스아웃 이벤트
																					kakao.maps.event
																							.addListener(
																									marker,
																									'mouseout',
																									function() {
																										infowindow
																												.close();
																									});

																					// 마커 클릭 이벤트
																					kakao.maps.event
																							.addListener(
																									marker,
																									'click',
																									function() {
																										apiDetailRequest(json.es_statId);
																										$(
																												'#chargeDetailModal')
																												.modal(
																														'show');
																									});

																				});

																clusterer
																		.addMarkers(markers);
															},
															error : function(
																	xhr,
																	status,
																	error) {
																console
																		.error("검색 중 오류 발생: "
																				+ error);
															}
														});
											});

							// 필터링 검색 시 DataController에서 매핑 시켜서 조인한 테이블 검색
							$('#search-btn2')
									.click(
											function() {
												var es_gungoo = $(
														'select[name="station-category"]')
														.val(); // 군/구 선택
												var es_faciL = $(
														'select[name="charging-station-category"]')
														.val(); // 충전소 분류
												var es_dvcL = $(
														'select[name="charging-type"]')
														.val(); // 충전기 타입

												$
														.ajax({
															url : "filter", // URL 변경
															data : {
																es_gungoo : es_gungoo,
																es_faciL : es_faciL,
																es_dvcS : es_dvcL
															// 변경: es_dvcL 대신 es_dvcS 사용
															},
															success : function(
																	response) {
																// 기존의 검색 결과 처리 함수 대신에 새로운 함수 호출
																renderSearchResults(response);
															},
															error : function(
																	xhr,
																	status,
																	error) {
																console
																		.error("검색 중 오류 발생: "
																				+ error);
															}
														});
											});

							// 공통 함수: 검색 결과 처리 및 마커 추가
							function renderSearchResults(response) {
								var resultDiv = $('#result-list');

								// 이전 검색 결과 초기화
								resultlist.empty();

								// 검색 결과를 하나씩 추가
								for (let i = 0; i < response.length; i++) {
									// 결과를 추가하는 부분
									resultDiv
											.append('<div class="result-item"><input type="hidden" class="location-info" data-lat="' + response[i].es_lat + '" data-lon="' + response[i].es_lon + '" data-name="' + response[i].es_statNm + '" data-statid="' + response[i].es_statId + '" data-stat="' + response[i].stat + '">'
													+ '<a href="#" class="result-link text-decoration-none">'
													+ response[i].es_statNm
													+ '</a>' + '</div>');
								}

								// 마커 지우기
								for (let i = 0; i < markers.length; i++) {
									markers[i].setMap(null);
								}
								positions = [];
								markers = [];

								// 사용가능(2), 사용불가능(1) 분류
								$(response)
										.each(
												function(i, json) {
													if (json.stat === '2') {
														positions
																.push({
																	latlng : new kakao.maps.LatLng(
																			json.es_lat,
																			json.es_lon),
																	image : markerImageSucc
																});
													} else {
														positions
																.push({
																	latlng : new kakao.maps.LatLng(
																			json.es_lat,
																			json.es_lon),
																	image : markerImageFail
																});
													}
												});

								// 마커 찍기
								for (var i = 0; i < positions.length; i++) {
									marker = new kakao.maps.Marker({
										map : map,
										position : positions[i].latlng,
										image : positions[i].image
									});
									markers.push(marker);
									(function(title) {
										kakao.maps.event.addListener(marker,
												'click', function() {
													getMapDetailSearch(title);
												});
									})(positions[i].title);
								}

								// 클러스터 재등록
								clusterer.addMarkers(markers);
							}

							//마커지우기 및 클러스지우기
							function delmark() {
								for (var i = 0; i < markers.length; i++) {
									markers[i].setMap(null);
								}
								markers = [];
								clusterer.clear();
							}

							// 검색한 결과를 담는 함수
							function renderSearchResults(results) {
								//console.log(results)
								var resultlist = $('#result-list');
								resultlist.empty();

								if (results.length === 0) {
									resultlist
											.append('<p>No results found.</p>');
								} else {
									// 검색 결과를 하나씩 추가
									for (let i = 0; i < results.length; i++) {
										//console.log(results[i])
										// 결과를 추가하는 부분
										resultlist
												.append('<div class="result-item"><input type="hidden" class="location-info" data-lat="' + results[i].es_lat + '" data-lon="' + results[i].es_lon + '" data-name="' + results[i].es_statNm + '" data-stat="' + results[i].stat + '" data-statid="' + results[i].es_statId + '">'
														+ '<a href="#" class="result-link text-decoration-none">'
														+ results[i].es_statNm
														+ '</a>' + '</div>');
									}
								}
							}

							$('#reset-btn').click(function() {
								var resultlist = $('#result-list');
								resultlist.empty();
								location.href = "MainPage.jsp";
							});

							// 데이터 불러오기 및 표시 // 마커찍기
							$
									.ajax({
										url : "select2",
										success : function(response) {
											var markers = [];

											$(response)
													.each(
															function(i, json) {
																if (json.stat == "2") {
																	var marker = new kakao.maps.Marker(
																			{
																				position : new kakao.maps.LatLng(
																						json.es_lat,
																						json.es_lon),
																				image : markerImageSucc
																			});
																} else {
																	var marker = new kakao.maps.Marker(
																			{
																				position : new kakao.maps.LatLng(
																						json.es_lat,
																						json.es_lon),
																				image : markerImageFail

																			})
																}
																;

																markers
																		.push(marker);

																// 마커에 인포윈도우 추가
																var iwContent = '<div style="padding:5px;">'
																		+ json.es_statNm
																		+ '</div>';
																var infowindow = new kakao.maps.InfoWindow(
																		{
																			content : iwContent
																		});

																// 마커에 마우스오버 이벤트
																kakao.maps.event
																		.addListener(
																				marker,
																				'mouseover',
																				function() {
																					infowindow
																							.open(
																									map,
																									marker);
																				});

																// 마커에 마우스아웃 이벤트
																kakao.maps.event
																		.addListener(
																				marker,
																				'mouseout',
																				function() {
																					infowindow
																							.close();
																				});

																// 마커 클릭 이벤트
																kakao.maps.event
																		.addListener(
																				marker,
																				'click',
																				function() {
																					apiDetailRequest(json.es_statId);
																					$(
																							'#chargeDetailModal')
																							.modal(
																									'show');
																				});

															});

											clusterer.addMarkers(markers);

											kakao.maps.event
													.addListener(
															clusterer,
															'clusterclick',
															function(cluster) {
																var content = '<div style="padding:5px;">'
																		+ cluster
																				.getMarkers()[0].es_statNm
																		+ '</div>';
																infoWindow
																		.setContent(content);
																infoWindow
																		.setPosition(cluster
																				.getCenter());
																infoWindow
																		.open(map);
															});

										},
										error : function(error) {
											console.log("데이터를 불러오는 중 에러 발생: "
													+ error);
										}
									});

							// 토글 테스트
							$('#bt-test').click(
									function() {
										var panel = document
												.getElementById('panel');

										if (!panel.style.left
												|| panel.style.left === '') {
											panel.style.left = '0px';
										}

										if (panel.style.left === '0px') {
											panel.style.left = '-20%';
											$('#bt-test').text('열기');
										} else {
											panel.style.left = '0px';
											$('#bt-test').text('닫기');
										}
									});

							// 지도레벨 확대 LOCK
							kakao.maps.event.addListener(map, 'zoom_changed',
									function() {
										var currentLevel = map.getLevel();
										if (currentLevel > 5) {
											map.setLevel(5);
										}
									});

							kakao.maps.event.addListener(map, 'zoom',
									function() {
										var currentLevel = map.getLevel();
										if (currentLevel > 5) {
											map.setLevel(5);
										}
									});

							// 내 주변 검색(1km)
							$('#submit-my-btn-distance')
									.click(
											function() {

												$
														.ajax({
															url : "myLocationFindRecommand",
															data : {
																es_lat : userLat,
																es_lon : userLon
															},
															success : function(
																	response) {
																console
																		.log(
																				"Server response:",
																				response);
																var resultDiv = $('#result-list');

																// 이전 검색 결과 초기화
																resultDiv
																		.html('');

																// 검색 결과를 하나씩 추가
																for (let i = 0; i < response.length; i++) {
																	console
																			.log(response[i]);
																	// 결과를 추가하는 부분
																	resultDiv
																			.append('<div class="result-item"><input type="hidden" class="location-info" data-lat="' + response[i].es_lat + '" data-lon="' + response[i].es_lon + '" data-name="' + response[i].es_statNm + '" data-statid="' + response[i].es_statId + '" data-stat="' + response[i].stat + '">'
																					+ '<a href="#" class="result-link text-decoration-none">'
																					+ response[i].es_statNm
																					+ '</a>'
																					+ response[i].distance
																					+ 'km'
																					+ '</div>');
																}//for
																circle = new kakao.maps.Circle(
																		{
																			center : new kakao.maps.LatLng(
																					userLat,
																					userLon), // 원의 중심좌표
																			radius : 500, // 미터 단위의 원의 반지름입니다 
																			strokeWeight : 5, // 선의 두께입니다 
																			strokeColor : '#75B8FA', // 선의 색깔입니다
																			strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
																			strokeStyle : 'dashed', // 선의 스타일 입니다
																			fillColor : '#CFE7FF', // 채우기 색깔입니다
																			fillOpacity : 0
																		// 채우기 불투명도 입니다   
																		});

																// 지도에 원을 표시합니다 
																circle
																		.setMap(map);

															}//success
														})//ajax

											})//submit-my-btn-distance

							//API데이터 불러오기
							function apiDetailRequest(es_statId) {
								var modalTitle = $('#chargeDetailModalLabel');
								var modalBody = $('#chargeDetailModalBody');

								// modal - title & body content 초기화
								modalTitle.empty();
								modalBody.empty();

								// api를 통해서 데이터를 가지고 오기 전 로딩화면 먼저 보여주기
								modalTitle
										.append('<tr><td colspan="6"><span class="spinner-border spinner-border-sm"></span>로딩중</td></tr>')

								// 별점
								var chargeAvg;

								// 충전소 평균 점수  
								$
										.ajax({
											url : '${pageContext.request.contextPath}/review/selectAvg',
											data : {
												r_statId : es_statId
											},
											success : function(avg) {
												//console.log(avg);
												if (avg != '-1') {
													chargeAvg = avg;
												} else {
													chargeAvg = '아직 리뷰가 없습니다.';
												}

											}
										})//ajax

								$
										.ajax({
											url : 'http://apis.data.go.kr/B552584/EvCharger/getChargerInfo',
											data : {
												serviceKey : '4fJ4k2ZYtCNutNWJwYCQoXeAJ95uJpDX+Q0BDFR+NwcbWk3CEcwwnukOQPdKbyaM9FLugJr8+OHYeX43ibOglw==',
												pageNo : '1',
												numOfRows : '30',
												period : '5',
												zcode : '11',
												statId : es_statId,
												dataType : 'JSON'
											},
											dataType : 'json',
											success : function(json) {

												statList = json.items.item;
												statFirstData = statList[0];

												var statNm = statList[0].statNm; // 충전기 이름
												var addr = statList[0].addr; // 주소
												var bnm = statList[0].bnm; // 기관명
												var busiCall = statList[0].busiCall; // 전화번호
												var location = statList[0].location; // 상세위치
												if (location !== null
														&& location !== "null") {
													location; // location값을 그대로 사용.
												} else {
													location = "정보가 없습니다";
												}
												var useTime = statList[0].useTime; // 이용가능시간
												var busiNm = statList[0].busiNm; // 운영기관명
												var parkingFree = statList[0].parkingFree; // 주차료 무료
												var trafficYn = statList[0].trafficYn // 편의제공 여부
												var note = statList[0].note; // 상세
												var output = statList[0].output
														+ 'kW'; // 충전용량

												var chgerType = null; // 충전기 타입
												if (chgerType === '01') {
													chgerType = 'DC차데모';
												} else if (chgerType === '02') {
													chgerType = 'AC완속';
												} else if (chgerType === '03') {
													chgerType = 'DC차데모+AC3상';
												} else if (chgerType === '04') {
													chgerType = 'DC콤보';
												} else if (chgerType === '05') {
													chgerType = 'DC차데모+DC콤보';
												} else if (chgerType === '06') {
													chgerType = 'DC차데모+AC3상+DC콤보';
												} else if (chgerType === '07') {
													chgerType = 'AC3상';
												} else {
													chgerType = 'DC콤보(완속)';
												}

												let statMap = new Map();
												statMap.set('1', 0); // 통신이상
												statMap.set('2', 0); // 충전대기
												statMap.set('3', 0); // 충전중
												statMap.set('4', 0); // 운영중지
												statMap.set('5', 0); // 점검중
												statMap.set('9', 0); // 상태미확인

												for (let i = 0; i < statList.length; i++) {
													statMap
															.set(
																	statList[i].stat,
																	statMap
																			.get(statList[i].stat) + 1);

												}

												modalTitle.empty();
												modalBody.empty();

												modalTitle
														.append('<h3 style="margin-bottom: 10;"><img src="../resources/img/station.png" width="45" height="30"> '
																+ statNm
																+ '</h3>');

												modalBody
														.append('<h3 class="text-center" style="margin-bottom: 10px;"><img src="../resources/img/star.png" width="30" height="30">'
																+ chargeAvg
																+ '</h3>');

												// 실시간 충전기 상태
												modalBody
														.append('<h3 style="margin-bottom: 10;"><img src="../resources/img/evcar.png" width="45" height="30"> 실시간 충전기 상황</h3>');
												modalBody
														.append('<table class="table table-bordered" style="border-collapse: collapse; width: 95%; margin-bottom : 10px; background-color: #f2f2f2;">'
																+ '<thead class="thead-dark"><tr><th style="border: 1px solid #ddd;">충전기상태</th><th style="border: 1px solid #ddd;">충전가능</th><th style="border: 1px solid #ddd;">충전중</th></tr></thead>'
																+ '<tbody><tr><td style="border: 1px solid #ddd;">'
																+ chgerType
																+ '</td><td style="border: 1px solid #ddd;">'
																+ statMap
																		.get('2')
																+ '</td><td style="border: 1px solid #ddd;">'
																+ statMap
																		.get('1')
																+ '</td></tr></tbody>'
																+ '</table>'
																+ '<p style="margin-bottom: 10;"><img src="../resources/img/chargetime.png" width="20" height="15"> 이용가능시간 : '
																+ useTime
																+ '</p>');

												modalBody.append('<hr>');

												// 요약 정보
												modalBody
														.append('<h3 style="margin-bottom: 10px;"><img src="../resources/img/evcar.png" width="45" height="30"> 요약정보 </h3>');
												modalBody
														.append('<table class="table table-bordered" style="border-collapse: collapse; width: 95%; margin: 0 auto; background-color: #f2f2f2; !important">'
																+ '<tr><td style="border: 1px solid #ddd;">도로명주소</td><td style="border: 1px solid #ddd;">'
																+ addr
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">기관명</td><td style="border: 1px solid #ddd;">'
																+ bnm
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">전화번호</td><td style="border: 1px solid #ddd;">'
																+ busiCall
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">상세위치</td><td style="border: 1px solid #ddd;">'
																+ location
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">운영기관명</td><td style="border: 1px solid #ddd;">'
																+ busiNm
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">주차료 무료</td><td style="border: 1px solid #ddd;">'
																+ parkingFree
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">편의제공 여부</td><td style="border: 1px solid #ddd;">'
																+ trafficYn
																+ '</td></tr>'
																+ '<tr><td style="border: 1px solid #ddd;">상세</td><td style="border: 1px solid #ddd;">'
																+ note
																+ '</td></tr>'
																+ '</table>');
												modalBody.append('<br>');
												modalBody
														.append('<a href="${pageContext.request.contextPath}/chargers/details?es_statId='
																+ es_statId
																+ '" class="btn btn-primary">상세정보 바로가기</a>');

											}
										});
							}
						});
	</script>
</body>
</html>