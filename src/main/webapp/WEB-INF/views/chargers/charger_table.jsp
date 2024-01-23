<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table id="result_table" border="1" width="1200px" align="center">
	<thead>
		<tr style="font-weight: bold; background: white;">
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
				<td>
					<a href="details?es_statId=${vo.es_statId}">
					${vo.es_statNm}
					</a>
				</td>
				<td>${vo.es_addr}</td>
				<td style ="color:green; font-weight: bold;">충전 가능 : ${vo.stat_count} 대</td>
		</c:forEach>

	</tbody>
</table>
	