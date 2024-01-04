<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
            width: 15%;
            height: 100%;
            background-color: #fff;
            transition: left 0.3s;
            z-index: 2;
            border-right: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-around;
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="/tayotayo/index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Link</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">관리 및 조회</a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="/tayotayo/mycard/initMemberCardAction.jsp">회원카드 관리</a></li>
                            <li><a class="dropdown-item" href="#">충전요금 조회</a></li>
                            <li><hr class="dropdown-divider" /></li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                    </li>
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
            <div id="search-options">
                <!-- 검색 옵션 추가 -->
                <input type="text" class="keyword" placeholder="검색하기">
                <select class="search-input" id="charging-station-category">
                    <option value="">충전소 분류</option>
                    <option value="public">공공 충전소</option>
                    <option value="private">사설 충전소</option>
                </select>
                <select class="search-input" id="charging-type">
                    <option value="">충전기 타입</option>
                    <option value="fast">급속 충전</option>
                    <option value="normal">완속 충전</option>
                </select>
                <!-- 검색, 초기화 버튼 -->
                <button  onclick="search()">검색하기</button>
                <button  onclick="resetSearch()">초기화하기</button>
            </div>
            <!-- 토글 버튼 -->
            <div id="toggle-btn"><button id="bt">접기/펼치기</button></div>
            <!-- 검색 결과 목록 -->
        <div id="result-list"></div>
        </div>
    </div>

    <!-- Bootstrap core JS-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5675f8f4dffbfd2b726b7b6393fd2b78&libraries=clusterer"></script>

    <!-- Your custom scripts -->
    <script>
        $(document).ready(function () {
            function search() {
                var keyword = $('#keyword').val();
                var category = $('#').val();
                var type = $('#').val();                
            }
            
            $.ajax({
            	url : "selectlist",
            	data : {
            		keyword = keyword
            	},
            	sucess : function(response) {
					
				}
            })//ajax

            function resetSearch() {
                // 여기에 초기화 기능 구현
                // 예: 선택된 지역, 충전소 분류, 충전기 타입을 초기화
            }

            // 카카오맵 생성
            var markers = [];
            var infoWindow = new kakao.maps.InfoWindow({ zIndex: 1 });
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.5666612, 126.9783785),
                level: 3
            };
            var map = new kakao.maps.Map(container, options);

            // 마커 클러스터러를 생성합니다
            var clusterer = new kakao.maps.MarkerClusterer({
                map: map,
                averageCenter: false,
                minLevel: 5
            });

            // 데이터 불러오기 및 표시
            $.ajax({
                url: "select",
                success: function (response) {
                    $(response).each(function (i, json) {
                        var marker = new kakao.maps.Marker({
                            position: new kakao.maps.LatLng(json.es_lat, json.es_lon),
                        });

                        markers.push(marker);
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

            $('#bt').click(function () {
                $('#panel').toggleClass('open');
                if ($('#panel').hasClass('open')) {
                    $('#panel').animate({ width: '0%' }, 300);
                } else {
                    $('#panel').animate({ width: '15%' }, 300);
                }
            });

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
        });
    </script>
</body>
</html>





