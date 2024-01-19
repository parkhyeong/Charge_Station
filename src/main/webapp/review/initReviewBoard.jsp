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
<title>전기차 타요타요 - 리뷰게시판</title>

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

.outer .wrap .board_list table thead tr th {
	color: white;
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

<script type="text/javascript">
	$(function() {

		var currentPage = 1; // 초기 페이지
		var pageSize = 10; // 페이지당 표시할 게시물 수
		var numPages; // 전체 페이지 수
		var table;

		//게시글 리스트 불러오기
		function loadReviewList(page) {
			$
					.ajax({
						method : 'POST',
						url : "review_list",
						data : {
							page : page,
							pageSize : pageSize
						},
						dataType : "json",
						success : function(result) {
							console.log("Received data:", result);
							numPages = result.numPages;
							console.log("Number of pages:", numPages);
							console.log("Data for page " + page + ":",
									result.posts);
							var allPosts = result.posts;
							var selectedRating = $("#ratingFilter").val();
							var filteredPosts = filterByRating(allPosts,
									selectedRating);
							displayData(result.posts);
							renderPaginationButtons();
						},
						error : function(xhr, status, error) {
							console.error("Ajax 요청 중 에러 발생:", status, error);
						}
					});
		}

		// 별점에 따라 필터링하는 함수
		function filterByRating(posts, rating) {
			if (rating === "0") {
				return posts.filter(function(post) {
					return post.r_rank == 0;
				});
			} else {
				return posts.filter(function(post) {
					return post.r_rank == rating;
				});
			}
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

					var selectedRating = $("#ratingFilter").val();
					if (selectedRating !== "") {
						var filteredPosts = filterByRating(result.posts,
								selectedRating);
						displayData(filteredPosts);
					} else {
						displayData(result.posts);
					}

					renderPaginationButtons();
				},
				error : function(xhr, status, error) {
					console.error("Ajax 요청 중 에러 발생:", status, error);
				}
			});
		}

		function filterAndDisplayByRating(rating) {
			if ($("form[name=search-form]").length > 0) {
				getSearchList(1);
			} else {
				var filteredPosts = filterByRating(posts, rating);
				currentPage = 1;
				displayData(filteredPosts);
				renderPaginationButtons();
			}
		}
		// 별점 선택
		$(document).on("change", "#ratingFilter", function() {
			var selectedRating = $(this).val();
			if (selectedRating === "") {
				loadReviewList(currentPage);
			} else {
				filterAndDisplayByRating(selectedRating);
			}
		});
		$(document).on("click", "#ratingFilter option[value='']", function() {
			loadReviewList(currentPage);
		});

		// 별점 필터링
		var ratingFilterSelect = $("<select>").attr("id", "ratingFilter")
				.appendTo(".board_title");
		$("<option>").val("").text("별점 선택").appendTo(ratingFilterSelect);
		$("<option>").val("5").text("5점").appendTo(ratingFilterSelect);
		$("<option>").val("4").text("4점").appendTo(ratingFilterSelect);
		$("<option>").val("3").text("3점").appendTo(ratingFilterSelect);
		$("<option>").val("2").text("2점").appendTo(ratingFilterSelect);
		$("<option>").val("1").text("1점").appendTo(ratingFilterSelect);
		$("<option>").val("0").text("0점").appendTo(ratingFilterSelect);

		function displayData(posts) {

			$(".board_list").empty();
			var table = $("<table>").addClass("table");
			var thead = $("<thead>").addClass("board_header").appendTo(table);
			var tbody = $("<tbody>").appendTo(table);

			var headerRow = $("<tr>").appendTo(thead);
			$("<th>").text("글번호").appendTo(headerRow);
			$("<th>").text("충전소명").appendTo(headerRow);
			$("<th>").text("제목").appendTo(headerRow);
			$("<th>").text("작성자").appendTo(headerRow);
			$("<th>").text("좋아요").appendTo(headerRow);
			$("<th>").text("작성일").appendTo(headerRow);
			$("<th>").text("별점").appendTo(headerRow);

			var searchType = $("form[name=search-form] select[name=type]")
					.val();
			var searchKeyword = $("form[name=search-form] input[name=keyword]")
					.val();

			var filteredPosts = posts.filter(function(post) {
				if (searchType === "title") {
					return post.r_title.includes(searchKeyword);
				} else if (searchType === "content") {
					return post.r_content.includes(searchKeyword);
				} else if (searchType === "writer") {
					return post.r_writer === searchKeyword;
				} else if (searchType === "stationName") {
					return post.r_statNm === searchKeyword;
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
				$("<td>").text(post.r_no).appendTo(row);
				$("<td>").text(post.r_statNm).appendTo(row);
				$("<td>").html(
						"<a href='initReviewBoardDetail.jsp?r_no=" + post.r_no
								+ "&r_num=" + post.r_num
								+ "' class='post-link' data-post-id='"
								+ post.r_no + "'>" + post.r_title + "</a>")
						.appendTo(row);
				$("<td>").text(post.r_writer).appendTo(row);
				$("<td>").text(post.r_like).appendTo(row);
				var formattedDate = new Date(post.r_time).toISOString().split(
						'T')[0];
				$("<td>").text(formattedDate).appendTo(row);
				$("<td>").text(post.r_rank).appendTo(row);
			});

			$(".board_list").html(table);
		}

		function renderPaginationButtons() {
	        $(".pagination").empty();
	        if (numPages > 1) {
	            var totalPages = numPages;
	            var currentPageGroup = Math.ceil(currentPage / 10);
	            var startPage = (currentPageGroup - 1) * 10 + 1;
	            var endPage = Math.min(currentPageGroup * 10, totalPages);

	            if (currentPageGroup > 1) {
	                $("<a>").attr("href", "#").data("page", startPage - 1).text("<").addClass("prev").appendTo(".pagination");
	            }

	            for (var i = startPage; i <= endPage; i++) {
	                $("<a>").attr("href", "#").data("page", i).text(i).appendTo(".pagination");
	            }

	            if (endPage < totalPages) {
	                $("<a>").attr("href", "#").data("page", endPage + 1).text(">").addClass("next").appendTo(".pagination");
	            }
	        }
	        $(".pagination a[data-page='" + currentPage + "']").addClass("current");
	    }

	    $(document).on("click", ".pagination a", function (e) {
	        e.preventDefault();
	        var requestedPage = $(this).data("page");
	        if (requestedPage === currentPage || requestedPage < 1 || requestedPage > numPages) {
	            return;
	        }
	        currentPage = requestedPage;
	        console.log("Requested page:", currentPage);
	        if ($("form[name=search-form]").length > 0) {
	            getSearchList(currentPage);
	        } else {
	            loadReviewList(currentPage);
	        }
	        renderPaginationButtons();

	        $(".pagination a.prev, .pagination a.next").remove();
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
									&& (searchKeyword.trim() === "")) {
								alert("카테고리와 검색어를 입력해주세요.");
								return;
							}

							if (searchType === ""
									&& (searchKeyword.trim() !== "")) {
								alert("카테고리를 선택해주세요.");
								return;
							}

							if (searchType !== ""
									&& (searchKeyword.trim() === "")) {
								alert("검색어를 입력해주세요.");
								return;
							}
							getSearchList(1);
						});

		loadReviewList(currentPage);
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
					<h3>리뷰게시판</h3>
				</div>
				<div class="board_list"></div>
			</div>
			<!-- 페이징 부분 -->
			<div class="pagination">
				<a href="#" class="prev" data-page="1">&lt;</a>
				<c:if test="${numPages > 1}">
					<c:forEach begin="1" end="${numPages}" var="pageNum">
						<a href="#" data-page="${pageNum}">${pageNum}</a>
					</c:forEach>
					<a href="#" class="next" data-page="${numPages}">&gt;</a>
				</c:if>
			</div>
			<div class="search_area">
				<form name="search-form" method="get" autocomplete="off">
					<select name="type">
						<option selected value="">카테고리 선택</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="writer">작성자</option>
						<option value="stationName">충전소명</option>
					</select> <input type="text" name="keyword" value=""></input> <input
						type="submit" class="btn_search" value="검색하기"></input>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
</body>
</html>