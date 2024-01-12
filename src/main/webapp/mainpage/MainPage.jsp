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
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />
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
    background-color: #fff;
    transition: left 0.3s;
    z-index: 2;
    border-right: 1px solid #ddd;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
}

#toggle-btn {
    cursor: pointer;
    margin-bottom: 40px;
    /* 스타일 추가 */
    color: #fff;
    padding: 10px;
    border: none;
    border-radius: 5px;
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

.reset-btn {
    background-color: #dc3545;
    color: #fff;
    padding: 5px 10px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}
</style>
</head>
<body>
    <!-- Responsive navbar-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">전기차 타요타요</a>
            <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active"
                        aria-current="page" href="/tayotayo/index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Link</a></li>
                    <li class="nav-item dropdown"><a
                        class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
                        role="button" data-bs-toggle="dropdown" aria-expanded="false">관리
                            및 조회</a>
                        <ul class="dropdown-menu dropdown-menu-end"
                            aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item"
                                href="/tayotayo/mycard/initMemberCardAction.jsp">회원카드 관리</a></li>
                            <li><a class="dropdown-item" href="#">충전요금 조회</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="#">Something else
                                    here</a></li>
                        </ul></li>
                </ul>
            </div>
        </div>
    </nav>

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
                <input type="text" id="keyword" placeholder="검색하기" value="현대"><hr> 
                <select class="search-input" id="charging-station-category"><hr>
                    <option value="">충전소 분류</option>
                    <option value="public">공공 충전소</option>
                    <option value="private">사설 충전소</option>
                </select> 
                <select class="search-input" id="charging-type"><hr>
                    <option value="">충전기 타입</option>
                    <option value="fast">급속 충전</option>
                    <option value="normal">완속 충전</option>
                </select>
                <!-- 검색, 초기화 버튼 -->
                <button id="search-btn">검색하기</button>
                <button id="reset-btn">초기화하기</button><hr>

            </div>
            <!-- 토글 버튼 -->
            <div id="toggle-btn">
                <button id="bt">접기/펼치기</button>
            </div>
            <!-- 검색 결과 목록 -->
            <div id="result-list"></div>
        </div>
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
				<div class="modal-body" id="chargeDetailModalBody">
				</div>
			</div>
		</div>
	</div>
    <!-- Bootstrap core JS-->
    <script type="text/javascript"
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5675f8f4dffbfd2b726b7b6393fd2b78&libraries=clusterer"></script>

    <!-- Your custom scripts -->
    <script>
        
        $(document).ready(function () {
            // 카카오맵 생성
            var markers = [];
            var infoWindow = new kakao.maps.InfoWindow({ zIndex: 1 });
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.5666612, 126.9783785),
                level: 3
            };
            //map 생성
            var map = new kakao.maps.Map(container, options);
           
            // marker img
            
            var imageSrcSucc = '../resources/img/blue.png'; 
    		var imageSrcFail = '../resources/img/red.png'; 

    		var markerImageSucc = new kakao.maps.MarkerImage(imageSrcSucc, new kakao.maps.Size(24, 35));
    		var markerImageFail = new kakao.maps.MarkerImage(imageSrcFail, new kakao.maps.Size(24, 35));

            // 마커 클러스터러를 생성합니다
            var clusterer = new kakao.maps.MarkerClusterer({
                map: map,
                averageCenter: true, // 개별 마커의 평균 위치를 사용하여 클러스터링
                minLevel: 5
            });
          
         // 목록 리스트 클릭 함수
            $(document).on('click', '#result-list a', function(event) {
                event.preventDefault(); // 현재 페이지로 새로고침하지 않고 지정한 기능만 구현하게 만드는 코드
                var parentDiv = event.target.parentElement;
                var es_lat = parentDiv.querySelector('.location-info').dataset.lat;
                var es_lon = parentDiv.querySelector('.location-info').dataset.lon;
                var es_statNm = parentDiv.querySelector('.location-info').dataset.name;
                var es_statId = parentDiv.querySelector('.location-info').dataset.statid;
                console.log('위도:', es_lat);
                console.log('경도:', es_lon);
                console.log('충전소명:', es_statNm);
                console.log('충전소번호:', es_statId);

                // 마커 초기화
                delmark();

                // 마커 위치 조정
                options = {
                    center: new kakao.maps.LatLng(es_lat, es_lon),
                    level: 4
                };
                map = new kakao.maps.Map(container, options);

                // 마커 생성
                var marker = new kakao.maps.Marker({
                    position: options.center
                });

                // 마커 지도에 추가
                marker.setMap(map);

                // 마커에 인포윈도우 추가
                var iwContent = '<div style="padding:5px;">' + es_statNm + '</div>';
                var infowindow = new kakao.maps.InfoWindow({
                    content: iwContent
                });

                // 마커 클릭 이벤트
                kakao.maps.event.addListener(marker, 'click', function () {
                    apiDetailRequest(es_statId);
                    $('#chargeDetailModal').modal('show');
                });

                // 마커에 마우스오버 이벤트
                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    infowindow.open(map, marker);
                });

                // 마커에 마우스아웃 이벤트
                kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                });

                $('#chargeDetailModal').modal('show');
            });
            
          
            
            $('#reset-btn').click(function() {
                var resultlist = $('#result-list');
                resultlist.empty();
                location.href = "MainPage2.jsp";
            });
            
            

            $('#search-btn').click(function() {
                var keyword = $('#keyword').val();
                console.log(keyword)

                $.ajax({
                    url: "selectlist",
                    data: {
                        es_statNm: keyword,
                    },
                    success: function (response) {
                        renderSearchResults(response);
                        // 전체 마커지우기 
                        delmark();
                        // 마커 다시 찍기&클러스 재등록
                        $(response).each(function (i, json) {
                            var marker = new kakao.maps.Marker({
                                position: new kakao.maps.LatLng(json.es_lat, json.es_lon),
                            });

                            markers.push(marker);
                        });

                        clusterer.addMarkers(markers);
                    },
                    error: function (xhr, status, error) {
                        console.error("검색 중 오류 발생: " + error);
                    }	
                });
            });

            //마커지우기 및 클러스지우기
            function delmark() {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }
                markers=[];
                clusterer.clear();
            }

            function renderSearchResults(results) {
                var resultlist = $('#result-list');
                resultlist.empty();

                if (results.length === 0) {
                    resultlist.append('<p>No results found.</p>');
                } else {
                    // 검색 결과를 하나씩 추가
                    for (let i = 0; i < results.length; i++) {
                        console.log(results[i]);
                        // 결과를 추가하는 부분
                        resultlist.append(
                            '<div class="result-item"><input type="hidden" class="location-info" data-lat="' + results[i].es_lat + '" data-lon="' + results[i].es_lon + '" data-name="' + results[i].es_statNm + '" data-statid="' + results[i].es_statId + '">' +
                                '<a href="#" class="result-link text-decoration-none">' + results[i].es_statNm + '</a>' +
                            '</div>'
                        );
                    }
                }
            }

            $('#reset-btn').click(function() {
                var resultlist = $('#result-list');
                resultlist.empty();
                location.href = "MainPage2.jsp";
            });

         // 데이터 불러오기 및 표시 // 마커찍기
            $.ajax({
                url: "select2",
                success: function (response) {
                    var markers = [];  // 이 부분을 수정: 매번 마커를 저장할 배열을 새로 만듭니다.
                    
                    $(response).each(function (i, json) {
                        	if (json.stat == "2") {
		                        var marker = new kakao.maps.Marker({
		                            position: new kakao.maps.LatLng(json.es_lat, json.es_lon),
		                            image : markerImageSucc
		                        });              		
							}else{
		                        var marker = new kakao.maps.Marker({
		                            position: new kakao.maps.LatLng(json.es_lat, json.es_lon),
		                            image : markerImageFail
										
		                        	})
                        };

                        markers.push(marker);
                        
                        // 마커에 인포윈도우 추가
                        var iwContent = '<div style="padding:5px;">' + json.es_statNm + '</div>';
                        var infowindow = new kakao.maps.InfoWindow({
                            content: iwContent
                        });

                        // 마커에 마우스오버 이벤트
                        kakao.maps.event.addListener(marker, 'mouseover', function () {
                            infowindow.open(map, marker);
                        });

                        // 마커에 마우스아웃 이벤트
                        kakao.maps.event.addListener(marker, 'mouseout', function () {
                            infowindow.close();
                        });
                        
                        // 마커 클릭 이벤트
                        kakao.maps.event.addListener(marker, 'click', function () {
                            apiDetailRequest(json.es_statId);
                            $('#chargeDetailModal').modal('show');
                        });

                    });

                    	clusterer.addMarkers(markers);

                    kakao.maps.event.addListener(clusterer, 'clusterclick', function (cluster) {
                        var content = '<div style="padding:5px;">' + cluster.getMarkers()[0].es_statNm + '</div>';
                        infoWindow.setContent(content);
                        infoWindow.setPosition(cluster.getCenter());
                        infoWindow.open(map);
                    });

                },
                error: function (error) {
                    console.log("데이터를 불러오는 중 에러 발생: " + error);
                }
            });
            $('#toggle-btn').click(function () {
                $('#panel').toggleClass('open');
                if ($('#panel').hasClass('open')) {
                    $('#panel').animate({ width: '0%' }, 300);
                } else {
                    $('#panel').animate({ width: '15%' }, 300);
                }
            });
            
            
            // 지도레벨 확대 LOCK
            kakao.maps.event.addListener(map, 'zoom_changed', function () {
                var currentLevel = map.getLevel();
                if (currentLevel > 5) {
                    map.setLevel(5);
                }
            });

            kakao.maps.event.addListener(map, 'zoom', function () {
                var currentLevel = map.getLevel();
                if (currentLevel > 5) {
                    map.setLevel(5);
                }
            });
            
            //API데이터 불러오기
            function apiDetailRequest(es_statId) {
        		
        		$.ajax({
        			url: 'http://apis.data.go.kr/B552584/EvCharger/getChargerInfo',
        			data: {
        				serviceKey : '4fJ4k2ZYtCNutNWJwYCQoXeAJ95uJpDX+Q0BDFR+NwcbWk3CEcwwnukOQPdKbyaM9FLugJr8+OHYeX43ibOglw==',
        				pageNo: '1',
        				numOfRows: '30',
        				period: '5',
        				zcode: '11',
        				statId: es_statId,
        				dataType: 'JSON'
        			},
        			dataType: 'json',
        			success: function(json) {
        				
        				console.log(json);
        				console.log(json.items);
        				console.log(json.items.item);
        				
        				statList = json.items.item;
        				statFirstData = statList[0];
        				
        				var statNm = statList[0].statNm;			// 충전기 이름
        				var addr = statList[0].addr;				// 주소
        				var bnm = statList[0].bnm;					// 기관명
        				var busiCall = statList[0].busiCall;		// 전화번호
        				var location = statList[0].location;	    // 상세위치
        				if (location !== null && location !== "null") {
        				    location;  // location값을 그대로 사용.
        				} else {
        				   	location = "정보가 없습니다";
        				}
        				var useTime = statList[0].useTime;			// 이용가능시간
        				var busiNm = statList[0].busiNm;			// 운영기관명
        				var parkingFree = statList[0].parkingFree;	// 주차료 무료
        				var trafficYn = statList[0].trafficYn		// 편의제공 여부
        				var note = statList[0].note;				// 상세
        				var output = statList[0].output + 'kW';		// 충전용량
        				
        				var chgerType = null;					 	// 충전기 타입
        				if (chgerType === '01'){
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
        				statMap.set('1', 0);		// 통신이상
        				statMap.set('2', 0);		// 충전대기
        				statMap.set('3', 0);		// 충전중
        				statMap.set('4', 0);		// 운영중지
        				statMap.set('5', 0);		// 점검중
        				statMap.set('9', 0);		// 상태미확인
        				
        				console.log(statNm);
        				console.log(typeof location);
        				console.log(addr);
        				console.log(bnm);
        				console.log(busiCall);
        				console.log(location);
        				console.log(useTime);
        				console.log(busiNm);
        				console.log(parkingFree);
        				console.log(trafficYn);
        				console.log(note);
        				console.log(output);

        				for (let i = 0; i < statList.length; i++) {
        					statMap.set(statList[i].stat, statMap.get(statList[i].stat) + 1);
        					
        				}
        				
        				var modalTitle = $('#chargeDetailModalLabel');
        				var modalBody = $('#chargeDetailModalBody');
        				
        				modalTitle.empty();
        				modalBody.empty();
        				
        				modalTitle.append('<h3>' + statNm + '</h3>');
        				
        				var modalTitle = $('#chargeDetailModalLabel');
        	            var modalBody = $('#chargeDetailModalBody');

        	            modalTitle.empty();
        	            modalBody.empty();

        	            modalTitle.append('<h3>' + statNm + '</h3>');
        	            modalTitle.append('<h3>별점 넣는 자리</h3>');
        	            modalTitle.append('<h4><button>상세정보</button></h4>');

        	            modalBody.append('<p>' + useTime + '</p>');
        	            modalBody.append('<h4>실시간 충전기 상황</h4>');
        	            modalBody.append('<table class="table table-bordered">');
        	            modalBody.append('<tr><td>충전기상태</td><td>충전가능</td><td>충전중</td></tr>');
        	            modalBody.append('<tr><td>' + chgerType + '</td><td>' + statMap.get('2') + '</td><td>' + statMap.get('1') + '</td></tr>');
        	            modalBody.append('</table>');
        	           
        	            modalBody.append('<hr>');

        	            modalBody.append('<h3>상세정보</h3>');
        	            modalBody.append('<table class="table table-bordered" style="border: 1px !important;">');
        	            modalBody.append('<tr class="t1" style="border: 1px !important;"><td>도로명주소</td><td style="text-align: center;">' + addr + '</td></tr>');
        	            modalBody.append('<tr><td>기관명</td><td style="text-align: center;">' + bnm + '</td></tr>');
        	            modalBody.append('<tr><td>전화번호</td><td style="text-align: center;">' + busiCall + '</td></tr>');
        	            modalBody.append('<tr><td>상세위치</td><td style="text-align: center;">' + location + '</td></tr>');
        	            modalBody.append('<tr><td>운영기관명</td><td style="text-align: center;">' + busiNm + '</td></tr>');
        	            modalBody.append('<tr><td>주차료 무료</td><td style="text-align: center;">' + parkingFree + '</td></tr>');
        	            modalBody.append('<tr><td>편의제공 여부</td><td style="text-align: center;">' + trafficYn + '</td></tr>');
        	            modalBody.append('<tr><td>상세</td><td style="text-align: center;">' + note + '</td></tr>');
        	            modalBody.append('</table>');
        	            
        	            
        			}
        		});
            }
        	});
        
        
    </script>
</body>
</html>