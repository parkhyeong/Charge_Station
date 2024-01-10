<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String c_memberid = "root";
	String es_statid = "AM900008";
session.setAttribute("c_memberid", c_memberid);
session.setAttribute("es_statid", es_statid);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요 - 리뷰 작성하기</title>
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

.board_title {
	border-bottom: 1px solid;
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
	width: 717px;
	height: 30px;
	border: 0px;
	margin-bottom: 20px;
	margin-top: 10px;
}

.input_area input:focus, .input_area select:focus {
	outline: none;
}

.textarea {
	resize: none;
	border: solid 1px #dadada;
}

.textarea:focus {
	outline: none;
}

.title_span {
	background-color: #212529;
	margin-top: 10px;
}

.board_area button {
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
	padding: 30px;
}

.star-rating {
	display: flex;
	flex-direction: row-reverse;
	align-items: center;
	margin-right: 530px;
	font-size: 1.15rem;
	padding: 0.02em;
}

.star-rating input {
	display: none;
}

.star-rating label {
	font-size: 2em;
	color: #ccc;
	cursor: pointer;
	margin-left: 5px;
	margin-bottom: 5px;
}

.star-rating input:checked ~ label, .star-rating input:checked+label,
	.star-rating label:hover, .star-rating label:hover ~ label {
	color: #212529;
}
</style>

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
					<h3>리뷰 작성</h3>
				</div>
				<div class="board_content">
					<form method="post" action="review_board_insert"
						onsubmit="return validateForm()">
						<div class="content">
							<br>
							<h5>
								<span class="title_span">&nbsp;</span> 작성자 ${c_memberid}
							</h5>
							<input type="hidden" name="r_writer" value="${c_memberid}">
							<h5>
								<span class="title_span">&nbsp;</span> 충전소 아이디 ${es_statid}
							</h5>
							<input type="hidden" name="es_statid" value="${es_statid}">
							<div>
								<h5>
									<span class="title_span">&nbsp;</span> 별점
								</h5>
								<div class="star-rating" onmouseover="highlightStars(event)">
									<input type="radio" id="star1" name="r_rank" value="5" /> <label
										for="star1">&#9733;</label> <input type="radio" id="star4"
										name="r_rank" value="4" /> <label for="star2">&#9733;</label>
									<input type="radio" id="star3" name="r_rank" value="3" /> <label
										for="star3">&#9733;</label> <input type="radio" id="star2"
										name="r_rank" value="2" /> <label for="star4">&#9733;</label>
									<input type="radio" id="star5" name="r_rank" value="1" /> <label
										for="star5">&#9733;</label>
								</div>

								<h5>
									<span class="title_span">&nbsp;</span> 제목
								</h5>
								<span class="input_area"> <input type="text"
									name="r_title" required></span> <br>
								<h5>
									<span class="title_span">&nbsp;</span> 내용
								</h5>
								<textarea class="textarea" rows="10" cols="89" name="r_content"
									required></textarea>
							</div>
							<div class="btn_area">
								<button type="button"
									onclick="location.href='initReviewBoard.jsp'">목록으로</button>
								<button type="submit">작성하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="/tayotayo/resources/js/scripts.js"></script>

<script>
	var c_memberid = "<c:out value='${c_memberid}'/>";
	console.log(c_memberid);
	var es_statid = "<c:out value='${es_statid}'/>";
	console.log(es_statid);
	function validateForm() {
		var title = document.getElementsByName("r_title")[0].value.trim();
		var content = document.getElementsByName("r_content")[0].value.trim();
		var userId = document.getElementsByName("r_writer")[0].value.trim();
		var rating = document.getElementsByName("r_rank")[0].value.trim();
		var es_statid = document.getElementsByName("es_statid")[0].value.trim();

		if (title === "" || content === "" || userId === "" || rating === "") {
			alert("제목과 내용, 별점을 모두 입력해주세요.");
			return false;
		}
		
		sendToServer({
	        r_title: r_title,
	        r_content: r_content,
	        r_writer: r_writer,
	        r_rank: r_rank,
	        r_statid: es_statid  
	    });

	    return true;
		
		sendRatingToServer(rating);
		
		alert("게시글이 성공적으로 작성되었습니다.");
		location.href = 'initReviewBoard.jsp';
		return true;
	}

	function detailView(bid) {
		location.href = '${contextPath}/board/detailView?bid=' + bid;
	}
	
	// 별점
	const starRating = document.querySelector('.star-rating');
	console.log(starRating);
	starRating.addEventListener('click', handleClick);
	console.log("Event listener added");
	
    function handleClick(event) {

        event.preventDefault();
        const clickedStar = event.target;

        if (clickedStar && clickedStar.nodeName === 'LABEL') {
            const stars = document.querySelectorAll('.star-rating input');
            const clickedIndex = Number(clickedStar.getAttribute('for').replace('star', '')) - 1;

            stars.forEach((star, index) => {
                star.checked = index === clickedIndex; 
            });
        }
    }
	 function mouseoutStars() {
	    }

	    starRating.addEventListener('mouseout', mouseoutStars);


</script>
</body>
</html>