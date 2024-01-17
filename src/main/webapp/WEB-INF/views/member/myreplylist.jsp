<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<meta charset="utf-8" />

<!-- Core theme CSS (includes Bootstrap)-->
<link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />

<style>
.outer {
	width: 800px;
	margin: auto;
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


.select {
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

.input_area input:focus, .select:focus {
	outline: none;
}


.input {
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
		var pageSize = 5; // 페이지당 표시할 게시물 수
		var numPages; // 전체 페이지 수
		var table;


		function getSearchList(page) {
			var searchType = "writer";
			var searchKeyword = "${member_id}";

			$.ajax({
						type : 'GET',
						url : "${pageContext.request.contextPath}/member/getmyreplyList",
						data : {
							page : page,
							pageSize : pageSize,
							keyword : searchKeyword
						},
						dataType : "json",
						success : function(result) {
							
							console.log("Received search data:", result);
							numPages = result.numPages;
							console.log("Number of pages:", numPages);

							var filteredPosts = result.posts.filter(function(post) {
				                return post.rr_writer === searchKeyword;
				            });

				            displayData(filteredPosts);

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
			$("<th>").text("게시글번호").appendTo(headerRow);
			$("<th>").text("내용").appendTo(headerRow);
			$("<th>").text("작성일").appendTo(headerRow);

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
					return post.r_statid === searchKeyword;
				}
				return true;
			});

			console.log("Filtered Posts Length:", filteredPosts.length);


			var startIndex = (currentPage - 1) * pageSize;
			var endIndex = Math
					.min(startIndex + pageSize, filteredPosts.length);
			var paginatedPosts = filteredPosts.slice(startIndex, endIndex);

			$.each(filteredPosts, function(index, post) {
				var row = $("<tr>").appendTo(tbody);
				$("<td>").text(post.rr_ori_review).appendTo(row);
				$("<td>").html(
						"<a href='${pageContext.request.contextPath}/review/initReviewBoardDetail.jsp?r_no=3"
								+ "&r_num=" + post.rr_ori_review
								+ "' class='post-link' data-post-id='"
								+ 3 + "'>" + post.rr_content + "</a>")
						.appendTo(row);
				var formattedDate = new Date(post.rr_time).toISOString().split(
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
				getSearchList(currentPage);
			}
		});

		 getSearchList(currentPage);
	});
</script>

		<div class="wrap">
			<div class="board_area">
				<div class="board_title">
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
			
		</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/tayotayo/resources/js/scripts.js"></script>
