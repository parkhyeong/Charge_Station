<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
$(function() {
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
			
})//$
</head>
<body>

</body>
</html>