<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전기차 타요타요</title>
<!-- <script type="text/javascript"> -->
<style>
#frilter {
	margin-bottom: 10px;
	text-align: center;
}

.search-input {
	padding: 5px;
	width: 20%;
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
</style>
</head>
<body>
<a href="chargers/chargerList">chargers paging목록 보기</a>
	<!-- 필터링  -->
	

	<div id="filter" >
	<div>
		<input type="text" class="keyword" placeholder="검색하기" width="600px">
	</div>
		<div>
			<select class="search-input" id="location-category">
				<option value="">군/구 선택</option>
				<option value="??">강남구</option>
				<option value="??">강동구</option>
				<option value="??">강북구</option>
				<option value="??">강서구</option>
				<option value="??">관악구</option>
				<option value="??">광진구</option>
				<option value="??">구로구</option>
				<option value="??">금천구</option>
				<option value="??">노원구</option>
				<option value="??">도봉구</option>
				<option value="??">동대문구</option>
				<option value="??">동작구</option>
				<option value="??">마포구</option>
				<option value="??">서대문구</option>
				<option value="??">서초구</option>
				<option value="??">성동구</option>
				<option value="??">성북구</option>
				<option value="??">송파구</option>
				<option value="??">양천구</option>
				<option value="??">영등포구</option>
				<option value="??">용산구</option>
				<option value="??">은평구</option>
				<option value="??">종로구</option>
				<option value="??">중구</option>
				<option value="??">중랑구</option>
			</select>
		</div>

		<div >
			<select class="search-input" id="charging-station-category">
				<option value="">충전소 분류</option>
				<!-- <option value="public">공공 충전소</option>
			<option value="private">사설 충전소</option> -->
				<option value="">공공시설</option>
				<option value="">공동주택시설</option>
				<option value="">관광시설</option>
				<option value="">교육문화시설</option>
				<option value="">근린생활시설</option>
				<option value="">기타시설</option>
				<option value="">상업시설</option>
				<option value="">주차시설</option>
				<option value="">차량정비시설</option>
				<option value="">휴게시설</option>
			</select>
		</div>

		<div>
			<select class="search-input" id="charging-type">
				<option value="">충전기 타입</option>
				<option value="fast">급속 충전</option>
				<option value="normal">완속 충전</option>
			</select>
		</div>

		<!-- <div style="float: left; width: 110px">
			<select class="search-input" id="charging-type">
				<option value="">주차비 선택</option>
				<option value="low_fee">00원 이하</option>
				<option value="low_low_fee">00원 이하</option>
			</select>
		</div> -->

		<!-- 검색 버튼 -->
		<button id="search-btn">검색하기</button>

	</div>
	</div>
	<!-- 필터링  -->

	</div>
	<!-- 검색 결과 목록 -->
	<div id="search_reslut"></div>


	<hr color="blue">
	<!-- 결과 화면  -->
	<table id="result_table" border="1" width="900px" align="center">
		<thead>
			<tr>
				<td>번호</td>
				<td>충전소명</td>
				<td>충전소 주소</td>
				<td>충전기 정보</td>
			</tr>
		</thead>
		<tbody>
			<!--db에서 불러오기  -->
		</tbody>
	</table>



	<!-- 스크립트 -->
	<script>

$('#search-btn').click(function() {
	 var keyword = $('#keyword').val();
     console.log(keyword)
	
	$.ajax({
		url:"selectlist",
		data: {
			es_statNm: keyword,
		},
		success: function (response) {
            renderSearchResults(response);
		}
		error: function (xhr, status, error) {
            console.error("검색 중 오류 발생: " + error);
        }	
	})
})




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

</script>
</body>
</html>