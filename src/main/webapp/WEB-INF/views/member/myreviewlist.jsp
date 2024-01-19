<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<meta charset="utf-8" />

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

.board_list2 {
	margin: 20px 30px;
	min-height: 300px;
}

.board_list2>ul {
	border-bottom: 1px solid #f3f5f7;
	height: 50px;
	line-height: 50px;
	display: flex;
	justify-content: space-around;
	list-style: none;
}

.board_list2>ul.last {
	border: 0;
}

.board_list2>ul>li {
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

.pagination2 {
	height: 40px;
	line-height: 50px;
	display: flex;
	justify-content: center;
	list-style: none;
	width: 480px;
	margin: auto;
}

.pagination2 a {
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

.pagination2 a.current_page {
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

.board_list board_list2 table thead tr th {
	color: white;
}

.board_list2 table thead tr th {
	color: white;
}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script type="text/javascript">

	$(function() {

		var currentPage2 = 1; // 초기 페이지
		var pageSize2 = 5; // 페이지당 표시할 게시물 수
		var numPages2; // 전체 페이지 수
		var table2;


		function getSearchList2(page) {
			var searchType2 = "writer";
			var searchKeyword2 = "${member_id}";

			$.ajax({
						type : 'GET',
						url : "${pageContext.request.contextPath}/review/getSearchList",
						data : {
							page : page,
							pageSize : pageSize2,
							type : searchType2,
							keyword : searchKeyword2
						},
						dataType : "json",
						success : function(result) {
							console.log("Received search data:", result);
							numPages = result.numPages;
							console.log("Number of pages:", numPages);

							var filteredPosts = result.posts.filter(function(post) {
				                return post.r_writer === searchKeyword2;
				            });

				            displayData2(filteredPosts);

				            renderPaginationButtons2();
						},
						error : function(xhr, status, error) {
							console.error("Ajax 요청 중 에러 발생:", status, error);
						}
					});
		}

		function displayData2(posts) {

			$(".board_list2").empty();
			var table = $("<table>").addClass("table");
			var thead = $("<thead>").addClass("board_header").appendTo(table);
			var tbody = $("<tbody>").appendTo(table);

			var headerRow = $("<tr>").appendTo(thead);
			$("<th>").text("충전소명").appendTo(headerRow);
			$("<th>").text("제목").appendTo(headerRow);
			$("<th>").text("좋아요").appendTo(headerRow);
			$("<th>").text("작성일").appendTo(headerRow);
			$("<th>").text("별점").appendTo(headerRow);

			var searchType = $("form[name=search-form] select[name=type]")
					.val();
			var searchKeyword2 = $("form[name=search-form] input[name=keyword]")
					.val();

			var filteredPosts = posts.filter(function(post) {
				if (searchType === "title") {
					return post.r_title.includes(searchKeyword2);
				} else if (searchType === "content") {
					return post.r_content.includes(searchKeyword2);
				} else if (searchType === "writer") {
					return post.r_writer === searchKeyword2;
				} else if (searchType === "stationName") {
					return post.r_statid === searchKeyword2;
				}
				return true;
			});

			console.log("Filtered Posts Length:", filteredPosts.length);


			var startIndex = (currentPage2 - 1) * pageSize2;
			var endIndex = Math
					.min(startIndex + pageSize2, filteredPosts.length);
			var paginatedPosts = filteredPosts.slice(startIndex, endIndex);

			$.each(filteredPosts, function(index, post) {
				var row = $("<tr>").appendTo(tbody);
				$("<td>").text(post.r_statNm).appendTo(row);
				$("<td>").html(
						"<a href='${pageContext.request.contextPath}/review/initReviewBoardDetail.jsp?r_no=" + post.r_no
								+ "&r_num=" + post.r_num
								+ "' class='post-link' data-post-id='"
								+ post.r_no + "'>" + post.r_title + "</a>")
						.appendTo(row);
				$("<td>").text(post.r_like).appendTo(row);
				var formattedDate = new Date(post.r_time).toISOString().split(
						'T')[0];
				$("<td>").text(formattedDate).appendTo(row);
				$("<td>").text(post.r_rank).appendTo(row);
			});

			$(".board_list2").html(table);
		}

		function renderPaginationButtons2() {
	        $(".pagination2").empty();
	        if (numPages > 1) {
	            var totalPages = numPages;
	            var currentPageGroup = Math.ceil(currentPage2 / 10);
	            var startPage = (currentPageGroup - 1) * 10 + 1;
	            var endPage = Math.min(currentPageGroup * 10, totalPages);

	            if (currentPageGroup > 1) {
	                $("<a>").attr("href", "#").data("page", startPage - 1).text("<").addClass("prev").appendTo(".pagination2");
	            }

	            for (var i = startPage; i <= endPage; i++) {
	                $("<a>").attr("href", "#").data("page", i).text(i).appendTo(".pagination2");
	            }

	            if (endPage < totalPages) {
	                $("<a>").attr("href", "#").data("page", endPage + 1).text(">").addClass("next").appendTo(".pagination2");
	            }
	        }
	        $(".pagination2 a[data-page='" + currentPage2 + "']").addClass("current");
	    }

	    $(document).on("click", ".pagination2 a", function (e) {
	        e.preventDefault();
	        var requestedPage = $(this).data("page");
	        if (requestedPage === currentPage2 || requestedPage < 1 || requestedPage > numPages) {
	            return;
	        }
	        currentPage2 = requestedPage;
	        console.log("Requested page:", currentPage2);
	        if ($("form[name=search-form]").length > 0) {
	            getSearchList2(currentPage2);
	        } else {
	        	getSearchList2(currentPage2);
	        }
	        renderPaginationButtons2();

	        $(".pagination2 a.prev, .pagination2 a.next").remove();
	    });
	    

		 getSearchList2(currentPage2);
	});
</script>

<div class="wrap">
	<div class="board_area">
		<div class="board_title"></div>
		<div class="board_list2"></div>
	</div>
	<!-- 페이징 부분 -->
			<div class="pagination2">
				<a href="#" class="prev" data-page="1">&lt;</a>
				<c:if test="${numPages > 1}">
					<c:forEach begin="1" end="${numPages}" var="pageNum">
						<a href="#" data-page="${pageNum}">${pageNum}</a>
					</c:forEach>
					<a href="#" class="next" data-page="${numPages}">&gt;</a>
				</c:if>
			</div>

</div>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>