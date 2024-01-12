<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<c:forEach items="${select_all}" var="vo">
			<tr>
				<td>${vo.row_no}</td>
				<td>${vo.es_statNm}</td>
				<td>${vo.es_addr}</td>
				<td>충전기 정보</td>
			</tr>
		</c:forEach>
	</tbody>
</table>