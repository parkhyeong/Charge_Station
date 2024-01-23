<%@page import="com.multi.tayotayo.chargers.PageVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>전기차 타요타요</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {
	//	loadPage(1);
	}) 
	

	 function loadPage(page) {
	    $.ajax({
	        url: "charger_table",
	        data: {
	            page: page
	        },
	        success: function(table) {
	            $('#result').html(table);
	        }
	    });
	} 
</script>
<style>
#search_div {
	margin-bottom: 10px;
	text-align: center;
}

.search-container {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 10px;
	height: 34px;
}

.search-input {
	padding: 5px;
	width: 100%; /* 수정: 20%에서 100%로 변경 */
	margin: 10px 9px;
	height: 34px;
}
.search-box{
	width: 500px;
	height: 34px;
	box-sizing: border-box;
}
#search-btn {
	background-color: gray;
	color: #fff;
	padding: 5px 10px;
	margin: 10px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	height: 34px;
}


#result_table tr:nth-child(odd) {
	background-color: #f2f2f2;
}

.pases {
	border: none;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 4px;
}
.pages:hover {
	color: #2e9cdf;
}

.pages:active {
	background: #2e9cdf; /* 다르게 표시할 색상으로 수정 가능 */
	color: white;
	font-weight: bold;
	text-decoration: underline;
}
</style>
</head>
<body>
	<br>

	<div id="search_div">
		<!-- 키워드 검색  -->
		<div class="search-container">
			<input type="text" class="search-box" id="keyword" placeholder="검색어를 입력하세요" width="1500px">
			<!-- 검색 버튼 -->
			<!-- <button id="search-btn">검색하기</button> -->
		</div>

		<!-- 필터링   검색-->
		<!-- 군/구 필터링 -->
		<div class="search-container">
			<div>
				<select class="search-input" id="location-category">
					<option value="%">군/구 선택</option>
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
					<option value="양천구">영등포구</option>
					<option value="용산구">용산구</option>
					<option value="은평구">은평구</option>
					<option value="종로구">종로구</option>
					<option value="중구">중구</option>
					<option value="중랑구">중랑구</option>
				</select>
			</div>

			<!-- 충전소 분류 필터링 -->
			<div>
				<select class="search-input" id="charging-station-category">
					<option value="%">충전소 분류</option>
					<option value="공공시설">공공시설</option>
					<option value="공동주택시설">공동주택시설</option>
					<option value="관광시설">관광시설</option>
					<option value="교육문화시설">교육문화시설</option>
					<option value="근린생활시설">근린생활시설</option>
					<option value="기타시설">기타시설</option>
					<option value="상업시설">상업시설</option>
					<option value="주차시설">주차시설</option>
					<option value="차량정비시설">차량정비시설</option>
					<option value="휴게시설">휴게시설</option>
				</select>
			</div>

			<!-- 충전기 타입 필터링 -->
			<div>
				<select class="search-input" id="charging-type">
					<option value="%">충전기 타입</option>
					<option value="급속">급속 충전</option>
					<option value="완속">완속 충전</option>
				</select>
			</div>
			<button id="search-btn"> 검색하기</button>
		</div> <!--search-container 끝  -->


	</div>
	<!-- search_div -->


	<hr color="blue">

	<!-- 결과 화면  -->
	<%-- <br> 전체 페이지 수 : ${pages}개 --%>
	<div id="result">
		<table id="result_table" border="1" width="1200px" align="center">
			<thead>
				<tr style ="font-weight: bold; background: white;">
					<td>번호</td>
					<td>충전소명</td>
					<td>충전소 주소</td>
					<td>충전기 정보</td>
				</tr>
			</thead>
			<tbody>
				<!--db에서 불러오기  -->
				<!--model 에서의 이름 과 명칭을 똑같이 하기  -->
				<c:forEach items="${select_all}" var="vo">
					<tr>
						<td>${vo.row_no}</td>
						<td>${vo.es_statNm}</td>
						<td>${vo.es_addr}</td>
						<td>충전 가능 : ${vo.stat_count} 대</td>
				</c:forEach>

			</tbody>
		</table>
	</div>

	<br>
	<br>
	<br>
	<%
		int pages = (int) request.getAttribute("pages");
	%>

	<%
		// 현재 페이지 번호를 파라미터로 받아옴
	PageVO pageVO = (PageVO) request.getAttribute("pageVO");
	int currentPage = pageVO.getPage(); //pageVO.page가 아닌이유? //2

	// 시작 페이지와 끝 페이지를 계산
	//int startPage = currentPage;//2
	int startPage = Math.max(currentPage - 4, 1); //10개로 변경할까? //1
	int endPage = Math.min(currentPage + 4, pages); //11

	int prevPage = Math.max(startPage - 1, 1); //
	int nextPage = Math.min(endPage + 1, pages); //
	%>
	<center>
		<div class="pasing">
			<a href="select_all_p?page=1">
				<button class="pages">처음</button>
			</a> 
			<a href="select_all_p?page=<%=prevPage%>">
				<button class="pages">이전</button>
			</a>
			<c:forEach begin="<%=startPage%>" end="<%=endPage%>" var="p">
			 <button class="pages" onclick="loadPage(${p})">${p}</button>
			</c:forEach>
			<a href="select_all_p?page=<%=nextPage%>">
				<button class="pages">다음</button>
			</a> 
			<a href="select_all_p?page=<%=pages%>">
				<button class="pages">마지막</button>
			</a>

		</div>
	</center>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>


	<!-- 스크립트 -->
	<script>
		/* 필터링 검색 + 키워드 검색*/
		$('#search-btn').click(function() {
			var es_gungoo = $('#location-category').val();
			var es_faciL = $('#charging-station-category').val();
			var es_dvcL = $('#charging-type').val();
			var keyword = $('#keyword').val();
			console.log(keyword);

			$.ajax({
				url : "selectWithFilters",
				data : {
					es_gungoo : es_gungoo,
					es_faciL : es_faciL,
					es_dvcL : es_dvcL,
					es_statNm : keyword
				},
				success : function(data) {
					$('#result').html(data);
				},
				error : function(xhr, status, error) {
					console.error("검색 중 오류 발생: " + error);
				}
			})//ajax

		})//#search-btn
	</script>
</body>
</html>