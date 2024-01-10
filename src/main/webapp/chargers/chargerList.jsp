<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script type="text/javascript"> -->
<style>
.search-input {
		    padding: 5px;
		    width: 80%;
		    margin: 0 auto;
		    display: block;
		    margin-bottom: 10px;
		}
</style>
</head>
<body>
<!-- 필터링  -->
<div id ="filter">
	<input type="text" class="keyword" placeholder="검색하기">
	
	<select class="search-input" id="charging-station-category">
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
    
    <!-- 검색 버튼 -->
    <button  onclick="search()">검색하기</button>
</div> <!-- 필터링  -->

<hr color = "blue">
<table border="1" >
<thead>
	<tr>
		<td>번호</td>
		<td>충전소명</td>
		<td>충전기정보</td>
	</tr>
</thead>
<tbody>
<!-- /* db에서 받아오기. */ -->
<%-- <% for() {%>
	<tr class="table-info">
		<td><%= bag.getTitle() %></td>
		<td>
			<a href="bbs2.jsp?id=<%= bag.getId() %>">
				<%= bag.getContent() %>
			</a>
		</td>
		<td><%= bag.getWriter() %></td>
	</tr>
<%} %> --%>
</tbody>
</table>
</body>
</html>