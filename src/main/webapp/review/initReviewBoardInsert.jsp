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
<title>전기차 타요타요 - 리뷰 작성하기</title>

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
	<div id="top">
		<jsp:include page="../header.jsp"></jsp:include>
	</div>


	<div class="outer">
		<div class="wrap">
			<div class="board_area">
				<div class="board_title">
					<h3>리뷰 작성</h3>
				</div>
				<div class="board_content">
					<form method="post" action="review_board_insert"
						onsubmit="return validateForm()" enctype="multipart/form-data">
						<div class="content">
							<br>
							<h5>
								<span class="title_span">&nbsp;</span> 작성자
								<c:out value="${member_id}" />
							</h5>
							<input type="hidden" name="r_writer"
								value="<c:out value='${member_id}' />">
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
								<div>
									<h5>
										<span class="title_span">&nbsp;</span> 사진 첨부
									</h5>
									<input type="file" name="file">
									<h5>
										<span class="title_span">&nbsp;</span> 사진 미리보기
									</h5>
									<div id="photoPreview" style="max-width: 300px;"></div>
								</div>
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

<script>
	var member_id = "<c:out value='${member_id}'/>";
	console.log(member_id);
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
	    
	    function previewPhoto() {
	        var fileInput = document.querySelector('input[name="file"]');
	        var photoPreview = document.getElementById('photoPreview');

	        fileInput.addEventListener('change', function () {
	            var file = fileInput.files[0];

	            if (file) {
	                var reader = new FileReader();

	                reader.onload = function (e) {
	                    var img = document.createElement('img');
	                    img.src = e.target.result;
	                    img.style.maxWidth = '100%';
	                    photoPreview.innerHTML = '';
	                    photoPreview.appendChild(img);
	                };

	                reader.readAsDataURL(file);
	            } else {
	                photoPreview.innerHTML = ''; 
	            }
	        });
	    }

	    document.addEventListener('DOMContentLoaded', function () {
	        previewPhoto();
	    });

</script>
</body>
</html>