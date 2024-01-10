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
<title>전기차 타요타요 - 리뷰 상세보기</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />

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

.comment_area button {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #212529;
	margin: 5px;
	cursor: pointer;
	margin-bottom: 20px;
}

.comment-info {
	margin-right: 30px;
}

.comment-content {
	background-color: #ddd;
	padding: 10px;
	border-radius: 5px;
}

.comment_area button.update-comment, .comment_area button.delete-comment
	{
	width: 50px;
	margin-left: 5px;
	padding: 1px 1px;
	background-color: #212529;
	color: #fff;
	border: none;
	cursor: pointer;
	border-radius: 20px;
}

.comment-modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	width: 25%;
	height: 30%;
	overflow: auto;
	background-color: #fff;
	padding-top: 50px;
	border: 2px solid rgba(13, 110, 253, .25);
}

.modal-content {
	background-color: #fefefe;
	padding: 10px;
	border: 1px solid #888;
	width: 80%;
	margin: auto;
}

.modal-close {
	color: #aaa;
	font-size: 28px;
	font-weight: bold;
}

.modal-close:hover, .modal-close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.star-rating {
	unicode-bidi: bidi-override;
	font-size: 30px;
	display: inline-block;
	margin-bottom: 1px;
}

.star-rating span {
	display: inline-block;
	position: relative;
	width: 1.1em;
}

.star-rating span:before {
	content: '★';
	position: absolute;
	opacity: 0;
	transition: opacity 0.5s;
}

.star-rating span:hover:before, .star-rating span:hover ~ span:before {
	opacity: 1;
}

.star-rating.selected span:before, .star-rating.selected span:hover ~
	span:before {
	opacity: 1;
}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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

		var postId = getParameterByName('r_no');
		var rNum = getParameterByName('r_num');

		$.ajax({
			url : "getReviewDetails",
			data : {
				r_no : postId,
				r_num : rNum
			},
			dataType : "json",
			success : function(result) {
				console.log("게시물 상세 정보 수신:", result);

				var postTime = new Date(result.r_time);
				var formattedPostTime = postTime.getFullYear() + "-"
						+ (postTime.getMonth() + 1) + "-" + postTime.getDate();

				$("#postNo").text(result.r_no);
				$("#postRank").text(result.r_rank);
				$("#postWriter").text(result.r_writer);
				$("#postTime").text(formattedPostTime);
				$("#title").val(result.r_title);
				$("#contents").val(result.r_content);

				const initialRank = parseInt(result.r_rank);
				if (isNaN(initialRank)) {
	                setStarRating(0);
	                $("#postRank").val("");
	            } else {
	                setStarRating(initialRank);
	                $("#postRank").val(initialRank);
	            }
				getComments(rNum);
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
		$(".star-rating").on("click", handleStarRating);
	});
</script>
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
						class="nav-link dropdown-toggle" id="managementDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">관리
							및 조회</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="managementDropdown">
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/initMemberCardAction.jsp">회원카드 관리</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/initBillSeachAction.jsp">충전요금 조회</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/payAction.jsp">요금 결제</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#">Something else
									here</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="communityDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							커뮤니티 </a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="communityDropdown">
							<li><a class="dropdown-item" href="#">공지 게시판</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/initReviewBoard.jsp">리뷰 게시판</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
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
						<td id="postNo"></td>
						<!-- <th scope="row">별점</th> -->

						<th scope="row">별점</th>
						<td>
							<div class="star-rating" id="starRating"
								onclick="handleStarRating(event)">
								<span data-value="1">★</span><span data-value="2">★</span><span
									data-value="3">★</span><span data-value="4">★</span><span
									data-value="5">★</span>
							</div> <input type="hidden" id="postRank" name="postRank" value="0">
						</td>
					</tr>

					<tr>
						<th scope="row">작성자</th>
						<td id="postWriter"></td>
						<th scope="row">작성일</th>
						<td id="postTime"></td>
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
				<button type="button" onclick="location.href='initReviewBoard.jsp'"
					class="board_area button">목록으로</button>
				<button type="button" onclick="updatePost()"
					class="board_area button">수정하기</button>
				<button type="button" onclick="deletePost()"
					class="board_area button">삭제하기</button>
			</div>

			<div class="comment_area">
				<h3>댓글</h3>
				<div id="commentList"></div>
				<textarea id="commentContent" class="textarea"
					placeholder="댓글을 입력하세요"></textarea>
				<button type="button" onclick="addComment()"
					class="board_area button">댓글 등록</button>
			</div>
		</div>
	</div>
</body>
<!-- 댓글 수정 모달 -->
<div id="commentModal" class="comment-modal">
	<div class="modal-content">
		<span class="modal-close" onclick="closeModal()">&times;</span>
		<textarea id="editCommentContent" class="textarea"
			placeholder="댓글을 수정하세요"></textarea>
		<button type="button" onclick="updateComment()"
			class="board_area button">수정 완료</button>
	</div>
</div>
<script>
	// 게시글 수정하기
	function updatePost() {
		var postId = $("#postNo").text();
		var title = $("#title").val();
		var contents = $("#contents").val();
		var rNum = getParameterByName('r_num');
		var starValue = parseInt($("#postRank").val());
		if (isNaN(starValue)) {
	        starValue = null;
	    }
		$.ajax({
			url : "updateReviewPost",
			method : "POST",
			data : {
				r_no : postId,
				r_title : title,
				r_content : contents,
				r_num : rNum,
				r_rank: starValue
			},
			success : function(result) {
				if (result === "success") {
					alert("게시물이 성공적으로 수정되었습니다.");
					location.reload();
				} else {
					alert("게시물 수정에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}

	$(document).on('click', '.editable', function() {
		$(this).removeAttr('readonly');
		$(this).css('border', '1px solid #212529');
	});

	$(document).on('blur', '.editable', function() {
		$(this).attr('readonly', true);
		$(this).css('border', 'none');
	});

	//게시글 + 댓글 삭제하기
	function deletePost() {
		var postId = $("#postNo").text();
		var rNum = getParameterByName('r_num');

		$.ajax({
			url : "deleteReviewPostWithComments",
			method : "POST",
			data : {
				r_no : postId,
				r_num : rNum
			},
			success : function(result) {
				if (result === "success") {
					alert("게시물이 성공적으로 삭제되었습니다.");
					location.href = 'initReviewBoard.jsp';
				} else {
					alert("게시물 삭제에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}

	// 댓글 추가
	function addComment() {
		var rNum = getParameterByName('r_num');
		var commentContent = $("#commentContent").val();

		$.ajax({
			url : "addComment",
			method : "POST",
			data : {
				rr_content : commentContent,
				rr_ori_review : rNum
			},
			success : function(result) {
				if (result === "success") {
					alert("댓글이 성공적으로 등록되었습니다.");
					getComments(rNum);
					location.reload();
				} else {
					alert("댓글 등록에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}

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

	// 댓글 불러오기
	function getComments(postId) {
		var rNum = getParameterByName('r_num');
		$
				.ajax({
					url : "getComments",
					data : {
						rr_ori_review : rNum
					},
					dataType : "json",
					success : function(comments) {
						console.log("댓글 정보 수신:", comments);

						if (comments && Array.isArray(comments)) {
							comments.reverse();
							comments
									.forEach(function(comment) {
										console.log(comment);
										var commentTime = new Date(
												comment.rr_time);
										var formattedCommentTime = commentTime ? commentTime
												.getFullYear()
												+ "-"
												+ (commentTime.getMonth() + 1)
												+ "-" + commentTime.getDate()
												: "Unknown Date";
										var commentHtml = '<p>'
												+ '작성자 : <span class="comment-info">'
												+ (comment.rr_writer || "Unknown Writer")
												+ '</span>'
												+ '작성 날짜 : <span class="comment-info">'
												+ formattedCommentTime
												+ '</span>'
												+ ' <button class="update-comment" onclick="openEditCommentModal('
												+ comment.rr_num
												+ ')">수정</button>'
												+ ' <button class="delete-comment" onclick="deleteComment('
												+ comment.rr_num
												+ ')">삭제</button>'
												+ '</p>'
												+ '<p class="comment-content">'
												+ (comment.rr_content || "No Content")
												+ '</p>' + '<br>';
										$(".comment_area").append(commentHtml);
									});
						} else {
							console.log("댓글 목록이 비어있습니다.");
						}
					},
					error : function(xhr, status, error) {
						console.error("댓글 정보를 가져오는 중 에러 발생:", status, error);
						console.log(JSON.stringify(comments));
					}
				});
	}
	//전체 댓글 삭제
	function deleteComments(rNum) {
		$.ajax({
			url : "deleteComments",
			method : "POST",
			data : {
				r_num : rNum
			},
			success : function(result) {
				if (result === "success") {
					console.log("댓글이 성공적으로 삭제되었습니다.");
				} else {
					console.log("댓글 삭제에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("댓글 삭제 중 에러 발생:", status, error);
			}
		});
	}
	// 댓글 삭제
	function deleteComment(rrNum) {
		var rNum = getParameterByName('r_num');
		console.log("Deleting comment with rr_num:", rrNum, "and r_num:", rNum);

		$.ajax({
			url : "deleteComment",
			method : "POST",
			data : {
				rr_num : rrNum,
				r_num : rNum
			},
			success : function(result) {
				if (result === "success") {
					console.log("댓글이 성공적으로 삭제되었습니다.");
					alert("댓글이 성공적으로 삭제되었습니다.");
					getComments(rNum);
					location.reload();
				} else {
					console.log("댓글 삭제에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("댓글 삭제 중 에러 발생:", status, error);
			}
		});
	}

	// 댓글 수정 모달 열기
	function openEditCommentModal(commentId, currentContent) {
		$("#editCommentContent").val(currentContent);
		$("#commentModal").show();
		$("#commentModal").attr("data-comment-id", commentId);
	}

	// 댓글 수정 모달 닫기
	function closeModal() {
		$("#commentModal").hide();
		$("#commentModal").removeAttr("data-comment-id");
	}

	// 댓글 수정
	function updateComment() {
		var commentId = $("#commentModal").attr("data-comment-id");
		var editedContent = $("#editCommentContent").val();
		var rNum = getParameterByName('r_num');

		$.ajax({
			url : "updateComment",
			method : "POST",
			data : {
				rr_num : commentId,
				rr_content : editedContent,
				rr_ori_review : rNum
			},
			success : function(result) {
				if (result === "success") {
					alert("댓글이 성공적으로 수정되었습니다.");
					closeModal();
					getComments(rNum);
					location.reload();
				} else {
					alert("댓글 수정에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}
	// 초기 별점 설정
	const initialRank = parseInt($("#postRank").text());
	document.getElementById('postRank').value = initialRank;
	setStarRating(initialRank);

	function setStarRating(rank) {
		const stars = document.querySelectorAll('.star-rating span');

		for (let i = 0; i < stars.length; i++) {
			const star = stars[i];
			star.style.color = i < rank ? 'black' : 'transparent'; // 내부 색상 변경
			star.style.borderColor = 'black'; // 테두리 색상 변경
		}
	}
	// 별점 클릭 처리
	function handleStarRating(event) {
		if (event.target.tagName === 'SPAN') {
			const starValue = parseInt(event.target.getAttribute('data-value'));

			setStarRating(starValue);
			const hoveredStarIndex = Array.from(
					event.target.parentElement.children).indexOf(event.target);

			const stars = document.querySelectorAll('.star-rating span');
			for (let i = 0; i <= hoveredStarIndex; i++) {
				stars[i].style.color = 'black';
			}
			for (let i = hoveredStarIndex + 1; i < stars.length; i++) {
				stars[i].style.color = 'transparent';
			}
			document.getElementById('postRank').value = starValue;
			console.log('별점 값:', starValue);
		}
	}

	$(".star-rating").on("mouseover", handleStarRating);
</script>
</html>