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
<title>전기차 타요타요 - 공지게시판</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />
<style>
.outer {
	width: 800px;
	margin: auto;
}

.wrap {
	width: 780px;
	margin: 100px auto;
}

ul, li {
	margin: 0;
	padding: 0;
}

.board_title {
	border-bottom: 1px solid #212529;
}

.board_list {
	margin: 20px 30px;
	min-height: 300px;
}

.board_list>ul {
	border-bottom: 1px solid #f3f5f7;
	height: 50px;
	line-height: 50px;
	display: flex;
	justify-content: space-around;
	list-style: none;
}

.board_list>ul.last {
	border: 0;
}

.board_list>ul>li {
	text-align: center;
}

.board_header {
	background: #212529;
	color: white;
	font-weight: bold;
}

.onmouseover {
	background: #f3f5f7;
	cursor: pointer;
}

.board_paging {
	height: 50px;
	line-height: 50px;
	display: flex;
	justify-content: center;
	list-style: none;
	width: 480px;
	margin: auto;
}

.board_paging a {
	text-decoration: none;
	color: #282A35;
	width: 40px;
	display: block;
	text-align: center;
}

.board_paging a.current_page {
	border-bottom: 2px solid #212529;
	font-weight: bold;
}

.search_area {
	text-align: center;
	padding: 30px;
}

.search_area select {
	width: 150px;
	height: 30px;
	border: 0px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-right: 5px;
	border-radius: 5px;
}

.input_area {
	border: solid 1px #dadada;
	padding: 10px 10px 14px 10px;
	margin-right: 20px;
	background: white;
}

.input_area input {
	width: 250px;
	height: 30px;
	border: 0px;
}

.input_area input:focus, .search_area select:focus {
	outline: none;
}

.search_area .btn_search {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #212529;
	margin: 5px;
}

.search_area input {
	width: 170px;
	height: 35px;
	border: 1px solid #212529;
	border-radius: 5px;
	margin: 5px;
	cursor: pointer;
}

.pagination {
	height: 40px;
	line-height: 50px;
	display: flex;
	justify-content: center;
	list-style: none;
	width: 480px;
	margin: auto;
}

.pagination a {
	text-decoration: none;
	color: #212529;
	width: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	cursor: pointer;
	margin: 0 5px;
	width: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	border: 1px solid #ccc;
}

.pagination a.current_page {
	border-bottom: 2px solid #212529;
	font-weight: bold;
}

#ratingFilter {
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-right: 10px;
	margin-bottom: 15px;
}

#ratingFilter option {
	font-size: 14px;
	background-color: #fff;
}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {

		var currentPage = 1; // 초기 페이지
		var pageSize = 10; // 페이지당 표시할 게시물 수
		var numPages; // 전체 페이지 수
		var table;

		//게시글 리스트 불러오기
		function loadNoticeList(page) {
			$.ajax({
				method : 'POST',
				url : "notice_list",
				data : {
					page : page,
					pageSize : pageSize
				},
				dataType : "json",
				success : function(result) {
					console.log("Received data:", result);
					numPages = result.numPages;
					console.log("Number of pages:", numPages);
					console.log("Data for page " + page + ":", result.posts);
					displayData(result.posts);
					renderPaginationButtons();
				},
				error : function(xhr, status, error) {
					console.error("Ajax 요청 중 에러 발생:", status, error);
				}
			});
		}

		function getSearchList(page) {
			var searchType = $("form[name=search-form] select[name=type]")
					.val();
			var searchKeyword = $("form[name=search-form] input[name=keyword]")
					.val();

			$.ajax({
				type : 'GET',
				url : "getSearchList",
				data : {
					page : page,
					pageSize : pageSize,
					type : searchType,
					keyword : searchKeyword
				},
				dataType : "json",
				success : function(result) {
					console.log("Received search data:", result);
					numPages = result.numPages;
					console.log("Number of pages:", numPages);

					displayData(result.posts);

					renderPaginationButtons();
				},
				error : function(xhr, status, error) {
					console.error("Ajax 요청 중 에러 발생:", status, error);
				}
			});
		}

		function displayData(posts) {

			$(".board_list").empty();
			var table = $("<table>").addClass("table");
			var thead = $("<thead>").addClass("board_header").appendTo(table);
			var tbody = $("<tbody>").appendTo(table);

			var headerRow = $("<tr>").appendTo(thead);
			$("<th>").text("글번호").appendTo(headerRow);
			$("<th>").text("제목").appendTo(headerRow);
			$("<th>").text("내용").appendTo(headerRow);
			$("<th>").text("작성일").appendTo(headerRow);

			var searchType = $("form[name=search-form] select[name=type]")
					.val();
			var searchKeyword = $("form[name=search-form] input[name=keyword]")
					.val();

			var filteredPosts = posts.filter(function(post) {
				if (searchType === "title") {
					return post.n_title.includes(searchKeyword);
				} else if (searchType === "content") {
					return post.n_content.includes(searchKeyword);
				} 
				return true;
			});

			console.log("Filtered Posts Length:", filteredPosts.length);

			if (filteredPosts.length === 0) {
				$(".board_list").html("<p>일치하는 결과가 없습니다</p>");
				$(".pagination").empty();
				return;
			}

			var startIndex = (currentPage - 1) * pageSize;
			var endIndex = Math
					.min(startIndex + pageSize, filteredPosts.length);
			var paginatedPosts = filteredPosts.slice(startIndex, endIndex);

			$.each(filteredPosts, function(index, post) {
				var row = $("<tr>").appendTo(tbody);
				$("<td>").text(post.n_no).appendTo(row);
				$("<td>").html(
						"<a href='initNoticeBoardDetail.jsp?n_no=" + post.n_no
								+ "&n_num=" + post.n_num
								+ "' class='post-link' data-post-id='"
								+ post.n_no + "'>" + post.n_title + "</a>")
						.appendTo(row);
				$("<td>").text(post.n_content).appendTo(row);
				var formattedDate = new Date(post.n_time).toISOString().split(
						'T')[0];
				$("<td>").text(formattedDate).appendTo(row);
			});

			$(".board_list").html(table);
		}

		function renderPaginationButtons() {
			$(".pagination").empty();
			if (numPages > 1) {
				for (var i = 1; i <= numPages; i++) {
					$("<a>").attr("href", "#").data("page", i).text(i)
							.appendTo(".pagination");
				}
			}
			$(".pagination a[data-page='" + currentPage + "']").addClass(
					"current");
		}

		$(document).on("click", ".pagination a", function(e) {
			e.preventDefault();
			currentPage = $(this).data("page");
			console.log("Requested page:", currentPage);
			if ($("form[name=search-form]").length > 0) {
				getSearchList(currentPage);
			} else {
				loadNoticeList(currentPage);
			}
		});

		$(document)
				.on(
						"submit",
						"form[name='search-form']",
						function(e) {
							e.preventDefault();
							var searchType = $(
									"form[name=search-form] select[name=type]")
									.val();
							var searchKeyword = $(
									"form[name=search-form] input[name=keyword]")
									.val();

							if (searchType === ""
									&& (searchKeyword.trim() !== "")) {
								alert("카테고리를 선택해주세요.");
								return;
							}
							getSearchList(1);
						});

		loadNoticeList(currentPage);
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
							<li><a class="dropdown-item" href="/tayotayo/notice/initNoticeBoard.jsp">공지 게시판</a></li>
							<li><a class="dropdown-item"
								href="/tayotayo/review/initReviewBoard.jsp">리뷰 게시판</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="outer">
		<div class="wrap">
			<div class="board_area">
				<div class="board_title">
					<h3>공지게시판</h3>
				</div>
				<div class="board_list"></div>
			</div>
			<!-- 페이징 부분 -->
			<div class="pagination">
				<c:if test="${numPages > 1}">
					<c:forEach begin="1" end="${numPages}" var="pageNum">
						<a href="#" data-page="${pageNum}">${pageNum}</a>
					</c:forEach>
				</c:if>
			</div>
			<div class="search_area">
				<form name="search-form" method="get" autocomplete="off">
					<select name="type">
						<option selected value="">카테고리 선택</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select> <input type="text" name="keyword" value=""></input> <input
						type="submit" class="btn_search" value="검색하기"></input> 
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/tayotayo/resources/js/scripts.js"></script>
</body>
</html>