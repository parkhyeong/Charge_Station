<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<title>전기차 타요타요 - 공지 상세보기</title>

<style>
body {
	line-height: 1.5;
	color: #666;
	-webkit-text-size-adjust: none;
	min-width: 320px;
	font-family: 'NanumGothic', '나눔고딕', dotum, "Helvetica Neue", Helvetica,
		Verdana, Arial, Sans-Serief;
}

h2, h3 {
	font-size: 1.5em;
}

.wrap {
	width: 780px;
	margin: 100px auto;
}

.board_list {
	width: 100%;
	border-top: 1px solid #212529;
	border-bottom: 1px solid #212529;
	margin: 15px 0;
	border-collapse: collapse;
}

.board_detail {
	width: 100%;
	border-top: 2px solid #252525;
	border-bottom: 1px solid #ccc;
	border-collapse: collapse;
}

.board_detail tbody textarea {
	width: 100%;
	min-height: 170px;
}

.board_detail tbody th, .board_detail tbody td {
	padding: 10px 15px;
	border-bottom: 1px solid #ccc;
}

.board_detail tbody th {
	text-align: left;
	background: #212529;
	color: #fff;
	vertical-align: middle;
	text-align: center;
}

.board_detail tbody input {
	width: 100%;
}

.board_content {
	padding: 0px 20px;
}

.board_content .content {
	margin-bottom: 30px;
}

.input_area {
	border: solid 1px #dadada;
	padding: 10px 10px 14px 10px;
	background: white;
}

.input_area select {
	width: 180px;
	height: 30px;
	border: 0px;
}

.input_area input {
	width: 745px;
	height: 30px;
	border: 0px;
	margin-bottom: 30px;
	margin-top: 10px;
}

.input_area input:focus, .input_area select:focus {
	outline: none;
}

.textarea {
	resize: none;
	border: solid 1px #dadada;
	width: 100%;
	padding: 10px;
	margin-bottom: 30px;
}

.textarea:focus {
	outline: none;
}

.title_span {
	background-color: #212529;
	margin-top: 10px;
	padding: 5px;
	color: white;
}

.btn_area button, .comment-modal button {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #212529;
	margin: 5px;
	cursor: pointer;
}

.btn_area {
	text-align: center;
	border-top: 1px solid #282A35;
	padding: 20px;
}

</style>

<script type="text/javascript">
	$(function() {
		function getParameterByName(name, url) {
			if (!url)
				url = window.location.href;
			name = name.replace(/[\[\]]/g, "\\$&");
			var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"), results = regex
					.exec(url);
			if (!results)
				return null;
			if (!results[2])
				return '';
			return decodeURIComponent(results[2].replace(/\+/g, " "));
		}

		var postId = getParameterByName('n_no');
		var nNum = getParameterByName('n_num');

		$.ajax({
			url : "getNoticeDetails",
			data : {
				n_no : postId,
				n_num : nNum
			},
			dataType : "json",
			success : function(result) {

				var postTime = new Date(result.n_time);
				var formattedPostTime = postTime.getFullYear() + "-"
						+ (postTime.getMonth() + 1) + "-" + postTime.getDate();

				$("#postNo").text(result.n_no);
				$("#postTime").text(formattedPostTime);
				$("#title").val(result.n_title);
				$("#contents").val(result.n_content);

			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	});
</script>
</head>
<body>
	<div id="top">
		<jsp:include page="../header.jsp"></jsp:include>
	</div>
	<div class="outer">
		<div class="wrap">
			<div class="board_area">
				<div class="board_title">
					<h2>게시글 상세 화면</h2>
				</div>
				<div class="board_list"></div>
			</div>
			<table class="board_detail">
				<colgroup>
					<col width="15%" />
					<col width="45%" />
					<col width="15%" />
					<col width="45%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">글 번호</th>
						<td colspan="3" id="postNo"></td>
					</tr>
					<tr>
						<th scope="row">작성일</th>
						<td colspan="3" id="postTime"></td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3"><input type="text" id="title" name="title"
							class="input_area editable" /></td>
					</tr>
					<tr>
						<td colspan="4" class="view_text"><textarea title="내용"
								id="contents" name="contents" class="textarea editable"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_area">
				<button type="button" onclick="location.href='initNoticeBoard.jsp'"
					class="board_area button">목록으로</button>
			</div>
		</div>
	</div>
</body>
<script>

	$(document).on('click', '.editable', function() {
		$(this).removeAttr('readonly');
		$(this).css('border', '1px solid #212529');
	});

	$(document).on('blur', '.editable', function() {
		$(this).attr('readonly', true);
		$(this).css('border', 'none');
	});

	function getParameterByName(name, url) {
		if (!url)
			url = window.location.href;
		name = name.replace(/[\[\]]/g, "\\$&");
		var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"), results = regex
				.exec(url);
		if (!results)
			return null;
		if (!results[2])
			return '';
		return decodeURIComponent(results[2].replace(/\+/g, " "));
	}
</script>
</html>