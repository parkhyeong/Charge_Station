<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요</title>
<link
	href="<%=pageContext.getServletContext().getContextPath()%>/resources/css/map.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.service-box a {
	text-decoration: none;
	color: inherit;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="height: 56px">
		<div class="container">
			<a class="navbar-brand"
				href="<%=pageContext.getServletContext().getContextPath()%>/index.jsp">
				<img style="height:50px;padding-top: 5px;padding-bottom: 5px;margin-right: 16px;" src="/tayotayo/resources/img/전기차 타요타요 글자.png">
				
				</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="<%=pageContext.getServletContext().getContextPath()%>/index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/mainpage/MainPage.jsp">충전소 찾기</a></li>
						
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/mycard/initMemberCardAction.jsp">관리
							및 조회</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/review/initReviewBoard.jsp">커뮤니티</a></li>

					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/chargers/select_all_p?page=1">충전소목록</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/member/mypage">마이페이지</a></li>

					<%
						if (session.getAttribute("member_id") == null) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/member/login_form">로그인</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/member/Agree_to_Terms_and_Conditions.jsp">회원가입</a></li>



					<%
						} else {
					%>
					<!-- 로그인 했을때 네비게이션 바 -->
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/member/logout">로그아웃</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</nav>


	<!-- Modal -->
	<div class="modal fade" id="csFeeModal" tabindex="-1" role="dialog"
		aria-labelledby="csFeeModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h7 class="modal-title fs-3" id="csFeeModalLabel">멤버쉽 안내</h7>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					멤버쉽 결제는 가상의 서비스입니다.<br> 멤버쉽 버튼을 클릭하면 멤버쉽 가입하기 페이지로 연결됩니다!
				</div>
				<div class="modal-footer">
					<a href="<%=pageContext.getServletContext().getContextPath()%>/mycard/initMemberCardAction.jsp" class="btn btn-secondary">회원카드 관리</a>

					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>

				</div>
			</div>
		</div>
	</div>


	<div class="main-wrap1">
		<div class="wrap">
			<!-- <div class="main-title">
				<div class="site-logo-en">
					<img src="/tayotayo/resources/img/tayotayo.png"> 임시
				</div>
			</div> -->
		</div>


		<div class="wrap">
			<div class="service-wrap">
				<div class="main-fee-container">
					<div class="fee-wrap-title">사업자별 충전요금(회원기준)</div>
					<span class="fee-box-fee" style="float: right; padding-top: 16px;">단위
						: 원/kWh</span>
					<div class="fee-wrap">
						<div class="flex">
							<div class="fee-box-title index-btnDC bg-blue pointer">급속
								충전</div>
							<div class="fee-box-title index-btnAC bg-green pointer">완속
								충전</div>
						</div>
						<div
							class="swiper-container swiper-container-initialized swiper-container-horizontal"
							id="feeFastSwiper">
							<div class="swiper-wrapper" id="feeFast"
								style="transition-duration: 0ms; transform: translate3d(-1040px, 0px, 0px);">
								<div
									class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active"
									data-swiper-slide-index="1"
									style="width: 520px; margin-left: 200%;">
									<ul>
										<li class="flex"><div class="fee-box">

												<div>
													<div class="fee-box-name">차지비</div>
													<div class="fee-box-fee feeColor blue">280.5원/kWh</div>
												</div>
											</div>
											<div class="fee-box">
												<div>
													<div class="fee-box-name">타디스테크놀로지</div>
													<div class="fee-box-fee feeColor blue">334원/kWh</div>
												</div>
											</div></li>
										<li class="flex"><div class="fee-box">
												<div>
													<div class="fee-box-name">한국전기차충전서비스</div>
													<div class="fee-box-fee feeColor blue">307.2원/kWh</div>
												</div>
											</div>
											<div class="fee-box">
												<div>
													<div class="fee-box-name">한국전력</div>
													<div class="fee-box-fee feeColor blue">274.55원/kWh</div>
												</div>
											</div></li>
										<li class="flex"><div class="fee-box">
												<div>
													<div class="fee-box-name">한국환경공단</div>
													<div class="fee-box-fee feeColor blue">335.8원/kWh</div>
												</div>
											</div>
											<div class="fee-box">
												<div>
													<div class="fee-box-name">환경부</div>
													<div class="fee-box-fee feeColor blue">335.8원/kWh</div>
												</div>
											</div></li>
									</ul>
								</div>
							</div>
							<div
								class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"
								id="feeFastPagination">
								<span class="swiper-pagination-bullet" tabindex="0"
									role="button" aria-label="Go to slide 1"></span><span
									class="swiper-pagination-bullet swiper-pagination-bullet-active"
									tabindex="0" role="button" aria-label="Go to slide 2"></span>
							</div>
							<span class="swiper-notification" aria-live="assertive"
								aria-atomic="true"></span>
						</div>
						<div class="swiper-container" id="feeSlowSwiper"
							style="display: none;"></div>
						<div class="fee-box-shadow"></div>
					</div>
				</div>
				<div class="main-map-container">
					<div class="fee-wrap-title">서울시 충전서비스 운영 현황</div>
					<span class="fee-box-fee" style="float: right; padding-top: 16px;">단위
						: 대</span>
					<div>
						<div class="blur-box" id="cs1">
							<img class="main-map"
								src="<%=pageContext.getServletContext().getContextPath()%>/resources/img/seoul_map.png"
								style="max-width: 100%; max-height: 100%; margin-left: -30%;">
							<div class="charger-cnt cnt-total-box">
								<div class="rd-box bg-green cnt-total" style="left: 74px;">완속</div>
								<div class="rd-box bg-gray cnt-total" style="left: 128px;">전체</div>
							</div>
							<div class="charger-cnt cnt-total-box" id="area0"
								style="left: 7px;">
								<div class="rd-box">서울</div>
								<div class="rd-box bg-blue" id="fast0">4,000</div>
								<div class="rd-box bg-green" id="slow0" style="left: 74px;">40,000</div>
								<div class="rd-box bg-gray" id="total0" style="left: 137px;">44,000</div>
							</div>
							<div class="charger-cnt mvSearch"
								style="top: 145px; left: 160px;" id="area1">
								<div class="rd-box">강북</div>
								<div class="rd-box bg-blue" id="fast1">2,000</div>
								<div class="rd-box bg-green" id="slow1" style="left: 67px;">
									3,000
									<div class="ar"></div>
								</div>
							</div>
							<div class="charger-cnt mvSearch" style="top: 260px; left: 80px;"
								id="area8">
								<div class="rd-box">강서</div>
								<div class="rd-box bg-blue" id="fast8">2,000</div>
								<div class="rd-box bg-green" id="slow8" style="left: 55px;">
									3,000
									<div class="ar"></div>
								</div>
							</div>
							<div class="charger-cnt mvSearch"
								style="top: 250px; left: 300px;" id="area15">
								<div class="rd-box">강동</div>
								<div class="rd-box bg-blue" id="fast15">2,000</div>
								<div class="rd-box bg-green" id="slow15" style="left: 67px;">
									3,000
									<div class="ar"></div>
								</div>
							</div>
							<div class="charger-cnt mvSearch"
								style="top: 370px; left: 180px;" id="area16">
								<div class="rd-box">강남</div>
								<div class="rd-box bg-blue" id="fast16">2,000</div>
								<div class="rd-box bg-green" id="slow16" style="left: 67px;">
									3,000
									<div class="ar"></div>
								</div>
							</div>
						</div>
						<div class="fee-box-shadow"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="main-wrap-indicate-container flex">
		<div class="main-wrap-indicate-left-bg">
			<div class="main-wrap-indicate-left"></div>
		</div>
		<div class="main-wrap-indicate-right-bg">
			<div class="main-wrap-indicate-right"></div>
		</div>
	</div>
	<div class="main-wrap2">
		<div class="wrap">
			<div class="service-flex">
				<div class="service-box" id="chargerCnt">
					<a
						href="<%=pageContext.getServletContext().getContextPath()%>/chargers/select_all_p?page=1">
						<div class="service-text1 blue">충전소 목록 조회</div>
						<div class="service-text2">
							서울시에 있는 충전소를<br> 조회해 보세요.
						</div>
						<div class="service-img">
							<img
								src="<%=pageContext.getServletContext().getContextPath()%>/resources/img/main_list.png">
						</div>
					</a>
				</div>

				<div class="service-box" id="csFee">
					<div class="service-text1 blue">충전요금 비교하기</div>
					<div class="service-text2">
						충전사 별 충전요금을 비교후 <br> 타요타요 멤버십 카드에 충전 해 보세요! <br>
					</div>
					<div class="service-img">
						<img
							src="<%=pageContext.getServletContext().getContextPath()%>/resources/img/main_compare.png">
					</div>
					</a>
				</div>

				<div class="service-box" id="bidList">
					<a
						href="<%=pageContext.getServletContext().getContextPath()%>/review/initReviewBoard.jsp">
						<div class="service-text1 blue">리뷰 게시판</div>
						<div class="service-text2">
							충전소에 대해 사용자들이 하는<br> 이야기를 들어보세요!
						</div>
						<div class="service-img">
							<img
								src="<%=pageContext.getServletContext().getContextPath()%>/resources/img/main_review.png">
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>


	<!--충전요금 비교하기 모달   -->
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			var csFeeButton = document.getElementById('csFee');
			csFeeButton.addEventListener('click', function() {
				var csFeeModal = new bootstrap.Modal(document
						.getElementById('csFeeModal'));
				csFeeModal.show();
			});
		});
	</script>

</body>
</html>