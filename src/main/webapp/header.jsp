<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script
	src="<%=pageContext.getServletContext().getContextPath()%>/resources/js/scripts.js"></script>
<link
	href="<%=pageContext.getServletContext().getContextPath()%>/resources/css/styles.css"
	rel="stylesheet" />

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요</title>
    
<!-- Core theme CSS (includes Bootstrap)-->
</head>
<body>
	<!-- Responsive navbar-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand"
				href="<%=pageContext.getServletContext().getContextPath()%>/mainpage/MainPage.jsp">전기차
				타요타요</a>
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
						href="<%=pageContext.getServletContext().getContextPath()%>/mainpage/MainPage.jsp">Home</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="managementDropdown"
						href="<%=pageContext.getServletContext().getContextPath()%>"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">관리
							및 조회</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="managementDropdown">
							<li><a class="dropdown-item"
								href="<%=pageContext.getServletContext().getContextPath()%>/mycard/initMemberCardAction.jsp">회원카드
									관리</a></li>
							<li><a class="dropdown-item"
								href="<%=pageContext.getServletContext().getContextPath()%>/mycard/initBillSeachAction.jsp">충전요금
									조회</a></li>
							<li><a class="dropdown-item"
								href="<%=pageContext.getServletContext().getContextPath()%>/mycard/pointPage.jsp">포인트
									조회</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="communityDropdown"
						href="<%=pageContext.getServletContext().getContextPath()%>"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							커뮤니티 </a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="communityDropdown">
							<li><a class="dropdown-item"
								href="<%=pageContext.getServletContext().getContextPath()%>/notice/initNoticeBoard.jsp">공지
									게시판</a></li>
							<li><a class="dropdown-item"
								href="<%=pageContext.getServletContext().getContextPath()%>/review/initReviewBoard.jsp">리뷰
									게시판</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=pageContext.getServletContext().getContextPath()%>/chargers/select_all_p">충전소목록</a></li>
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