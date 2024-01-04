<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
/* $(function() {
	$.ajax({
		url : "charger_list",
		dataType : "json",
		success : function(result) {
			console.log(result);

			/* var table = $("<table>").addClass("table");
			var tbody = $("<tbody>").appendTo(table);
 */
			var headerRow = $("<tr>").appendTo(thead);
			$("<th>").text("번호").appendTo(headerRow);
			$("<th>").text("충전소명").appendTo(headerRow);
			$("<th>").text("충전기정보").appendTo(headerRow);
			//$("<th>").text("주소").appendTo(headerRow);
			
			
		}//success
			
		})//$.ajax
			
})//$ */
</head>
<body>
<table border="1" class="table table-hover">
<thead>
	<tr class="table-warning">
		<td>번호</td>
		<td>충전소명</td>
		<td>충전기정보</td>
	</tr>
</thead>
<tbody>
/* db에서 받아오기. */
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