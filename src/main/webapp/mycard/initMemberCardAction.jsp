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
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/tayotayo/resources/css/styles.css" rel="stylesheet" />

<style>
.subPage {
	  background-color: #f4f4f4;
}

	.pageBox {
	  max-width: 800px;
	  margin: 20px auto;
	  background-color: #fff;
	  padding: 20px;
	  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}

	.pageTit {
	  font-size: 24px;
	  color: #333;
	  margin-bottom: 20px;
	}

	.subPageTab {
	  list-style: none;
	  padding: 0;
	  margin: 0;
	}

	.subPageTab li {
	  display: inline-block;
	  margin-right: 10px;
	}

	.subPageTab a {
	  text-decoration: none;
	  color: #333;
	  font-weight: bold;
	}

	.tabPage {
	  display: none;
	}

	.tabPage.on {
	  display: block;
	}

	.formBox {
	  margin-top: 20px;
	}

	.table03 {
	  width: 100%;
	  border-collapse: collapse;
	  margin-top: 10px;
	}

	.table03 th,
	.table03 td {
	  border: 1px solid #ccc;
	  padding: 10px;
	}

	.nece {
	  color: red;
	}

	.selectBox,
	.inputBox {
	  margin-top: 10px;
	}

	.btnBox {
	  margin-top: 20px;
	}

	.btn_agree_next {
	  display: inline-block;
	  padding: 10px 20px;
	  background-color: #212529;
	  color: #fff;
	  text-decoration: none;
	  border-radius: 5px;
	  cursor: pointer;
	}

	.btn_agree_next:hover {
	  background-color: #0056b3;
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
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">관리
							및 조회</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item"
								href="/tayotayo/mycard/initMemberCardAction.jsp">회원카드 관리</a></li>
							<li><a class="dropdown-item" href="#">충전요금 조회</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="#">Something else
									here</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="subPage" id="subPage">
		<div class="pageBox">
			<h1 class="pageTit js-scrollmotion_up"
				style="opacity: 1; transform: translateY(0px);">회원카드 신청</h1>
			<div class="subWrap">
				<ul class="subPageTab" id="subPageTab">
					<li class="on"><a href="#">회원카드/번호 신청서</a></li>
					<li><a
						href="/nportal/mngInqire/initMemberCardApplicationAction2.do">회원카드/번호
							발급조회</a></li>
				</ul>
				<div class="tabPage on">
					<!-- 탭1 -->
					<form id="tabForm01" name="tabForm01" method="post"
						action="/nportal/mngInqire/memberCard/cud.do">
						<input type="hidden" name="mode" id="mode" value="write">
						<input type="hidden" name="card_req_seq" value=""> <input
							type="hidden" name="s_card_type" value=""> <input
							type="hidden" name="s_req_status" value=""> <input
							type="hidden" name="s_issued_card" value=""> <input
							type="hidden" id="m_phone" name="m_phone" value=""> <input
							type="hidden" id="m_name" name="m_name" value="">


						<div class="formBox js-scrollmotion_up scrolldelay1"
							style="opacity: 1; transform: translateY(0px);">
							<h4>신청자 기본정보</h4>
							<table class="table03 thColor">
								<colgroup>
									<col width="13%">
									<col width="*">
									<col width="13%">
									<col width="*">
								</colgroup>
								<caption></caption>
								<tbody>
									<tr class="tr-flex">
										<th>회원구분</th>
										<td>개인</td>
									</tr>
									<tr class="tr-flex">
										<th>이름</th>
										<td>조나단 <input type="hidden" name="req_name"
											id="req_name" value="조나단" title="개인 성명"> <input
											type="hidden" id="card_type" name="card_type" value="C">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="formBox js-scrollmotion_up scrolldelay2"
							style="opacity: 1; transform: translateY(0px);">

							<div class="neceDiv">
								<h4>추가 정보 입력</h4>
								<p class="neceP">
									<span>*</span> 는 <span>필수 항목</span>입니다.
								</p>
							</div>
							<table class="table03">
								<colgroup>
									<col width="12%">
									<col width="*">
								</colgroup>
								<caption></caption>
								<tbody>
									<tr>
										<th>차량종류 <span class="nece">*</span></th>
										<td><select id="car_kind_cd" name="car_kind_cd"
											title="차량종류 선택">
												<option value="">선택</option>

												<option value="0001">승용차</option>

												<option value="0002">경차</option>

												<option value="0003">버스</option>

												<option value="0004">SUV</option>

												<option value="0005">준중형차</option>

												<option value="9999">기타</option>

										</select></td>
									</tr>
									<tr>
										<th>차량모델 <span class="nece">*</span></th>
										<td><select id="car_model_cd" name="car_model_cd"
											title="차량모델 선택">
												<option value="">선택</option>

												<option value="1101">현대&nbsp;:&nbsp;아이오닉</option>

												<option value="1102">현대&nbsp;:&nbsp;코나</option>

												<option value="1103">현대&nbsp;:&nbsp;블루온</option>

												<option value="1104">현대&nbsp;:&nbsp;G80</option>

												<option value="1105">현대&nbsp;:&nbsp;아이오닉5</option>

												<option value="1106">현대&nbsp;:&nbsp;GV60</option>

												<option value="1107">현대&nbsp;:&nbsp;GV80</option>

												<option value="1108">현대&nbsp;:&nbsp;GV70</option>

												<option value="1109">현대&nbsp;:&nbsp;아이오닉6</option>

												<option value="5101">현대&nbsp;:&nbsp;포터 일렉트릭</option>

												<option value="1201">기아&nbsp;:&nbsp;니로</option>

												<option value="1202">기아&nbsp;:&nbsp;쏘울</option>

												<option value="1203">기아&nbsp;:&nbsp;레이</option>

												<option value="1204">기아&nbsp;:&nbsp;EV6</option>

												<option value="1205">기아&nbsp;:&nbsp;EV9</option>

												<option value="5201">기아&nbsp;:&nbsp;봉고 전기차</option>

												<option value="1301">르노&nbsp;:&nbsp;SM3 Z.E.</option>

												<option value="1302">르노&nbsp;:&nbsp;ZOE</option>

												<option value="1303">르노&nbsp;:&nbsp;트위지</option>

												<option value="5301">파워프라자&nbsp;:&nbsp;피스</option>

												<option value="1401">BMW&nbsp;:&nbsp;i3</option>

												<option value="1402">BMW&nbsp;:&nbsp;iX</option>

												<option value="1403">BMW&nbsp;:&nbsp;iX3</option>

												<option value="1404">BMW&nbsp;:&nbsp;i4</option>

												<option value="1405">BMW&nbsp;:&nbsp;iX1</option>

												<option value="1406">BMW&nbsp;:&nbsp;530e</option>

												<option value="2104">BMW&nbsp;:&nbsp;미니쿠퍼 SE</option>

												<option value="5401">대창모터스&nbsp;:&nbsp;다니고밴</option>

												<option value="1501">한국GM&nbsp;:&nbsp;볼트 EV</option>

												<option value="1502">한국GM&nbsp;:&nbsp;스파크</option>

												<option value="1503">한국GM&nbsp;:&nbsp;볼트 EUV</option>

												<option value="5501">일진정공&nbsp;:&nbsp;일진무시동전기냉동탑차(149.9km)</option>

												<option value="5502">일진정공&nbsp;:&nbsp;일진무시동전기냉동탑차(186.1km)</option>

												<option value="1601">닛산&nbsp;:&nbsp;리프</option>

												<option value="1701">테슬라&nbsp;:&nbsp;모델 3</option>

												<option value="1702">테슬라&nbsp;:&nbsp;모델 S</option>

												<option value="1703">테슬라&nbsp;:&nbsp;모델 Y</option>

												<option value="1704">테슬라&nbsp;:&nbsp;모델 X</option>

												<option value="1801">재규어&nbsp;:&nbsp;I-페이스</option>

												<option value="1901">벤츠&nbsp;:&nbsp;EQC</option>

												<option value="1902">벤츠&nbsp;:&nbsp;EQA</option>

												<option value="1903">벤츠&nbsp;:&nbsp;EQS</option>

												<option value="1904">벤츠&nbsp;:&nbsp;EQB</option>

												<option value="1905">벤츠&nbsp;:&nbsp;EQE</option>

												<option value="2001">폭스바겐그룹&nbsp;:&nbsp;e-트론 55 콰트로</option>

												<option value="2002">폭스바겐그룹&nbsp;:&nbsp;e-트론 50 콰트로</option>

												<option value="2003">폭스바겐그룹&nbsp;:&nbsp;e-트론 40</option>

												<option value="2004">폭스바겐그룹&nbsp;:&nbsp;ID.4</option>

												<option value="2101">스텔란티스&nbsp;:&nbsp;푸조 e-2008</option>

												<option value="2102">스텔란티스&nbsp;:&nbsp;푸조 e-208</option>

												<option value="2103">스텔란티스&nbsp;:&nbsp;DS3</option>

												<option value="2201">스마트솔루션즈&nbsp;:&nbsp;EV Z</option>

												<option value="2301">쎄보모빌리티&nbsp;:&nbsp;쎄보-C</option>

												<option value="2401">포르쉐&nbsp;:&nbsp;타이칸</option>

												<option value="2501">케이지모빌리티&nbsp;:&nbsp;E100</option>

												<option value="2502">케이지모빌리티&nbsp;:&nbsp;코란도</option>

												<option value="2503">케이지모빌리티&nbsp;:&nbsp;토레스</option>

												<option value="2402">폴스타&nbsp;:&nbsp;폴스타2</option>

												<option value="2601">볼보&nbsp;:&nbsp;C40</option>

												<option value="2602">볼보&nbsp;:&nbsp;XC40</option>

												<option value="2701">토요타&nbsp;:&nbsp;렉서스</option>

												<option value="2702">마이브&nbsp;:&nbsp;M1</option>

												<option value="2801">대창모터스&nbsp;:&nbsp;다니고</option>

												<option value="5102">현대&nbsp;:&nbsp;카운티 일렉트릭</option>

												<option value="5103">현대&nbsp;:&nbsp;일렉시티</option>

												<option value="5402">대창모터스&nbsp;:&nbsp;다니고C</option>

												<option value="5403">대창모터스&nbsp;:&nbsp;다니고3</option>

												<option value="5404">대창모터스&nbsp;:&nbsp;다니고R</option>

												<option value="5601">디피코&nbsp;:&nbsp;포트로-탑</option>

												<option value="5602">디피코&nbsp;:&nbsp;포트로-픽업</option>

												<option value="5603">디피코&nbsp;:&nbsp;휴-스카이</option>

												<option value="5701">한신자동차&nbsp;:&nbsp;플러스</option>

												<option value="5801">이온모터스&nbsp;:&nbsp;시티라이트</option>

												<option value="5901">이엠코리아&nbsp;:&nbsp;에픽시티</option>

												<option value="6001">이비온&nbsp;:&nbsp;E6</option>

												<option value="6101">비바모빌리티&nbsp;:&nbsp;브라보</option>

												<option value="6102">비바모빌리티&nbsp;:&nbsp;비바</option>

												<option value="6103">에스에스라이트&nbsp;:&nbsp;젤라</option>

												<option value="6104">비바모빌리티&nbsp;:&nbsp;브이버스</option>

												<option value="6201">마스타전기차&nbsp;:&nbsp;마스타</option>

												<option value="6301">이브이케이엠씨&nbsp;:&nbsp;마사다</option>

												<option value="6401">제이스모빌리티&nbsp;:&nbsp;이티밴</option>

												<option value="6501">에디슨모터스&nbsp;:&nbsp;스마트 T1.0</option>

												<option value="6502">에디슨모터스&nbsp;:&nbsp;이화이버드</option>

												<option value="6601">스마트솔루션즈&nbsp;:&nbsp;D2C</option>

												<option value="6602">스마트솔루션즈&nbsp;:&nbsp;D2P</option>

												<option value="6701">경인모터스&nbsp;:&nbsp;경인 냉동탑차</option>

												<option value="6801">제인모터스&nbsp;:&nbsp;칼마토</option>

												<option value="6901">진우에스엠씨&nbsp;:&nbsp;포텐스</option>

												<option value="7001">GS글로벌&nbsp;:&nbsp;T4K</option>

												<option value="7101">오텍&nbsp;:&nbsp;오텍 냉동탑차</option>

												<option value="7201">테라팩토리&nbsp;:&nbsp;테라밴</option>

												<option value="7301">중원자동차&nbsp;:&nbsp;EV J1</option>

												<option value="8001">포드&nbsp;:&nbsp;익스플로러</option>

												<option value="9999">기타&nbsp;:&nbsp;기타</option>

										</select>
											<p class="anno">* 공공급속충전인프라 회원인증용으로, 급속충전이 가능한 환경부 보급대상
												차종에 한하여 발급이 가능합니다.</p></td>
									</tr>
									<tr>
										<th>차량번호 <span class="nece">*</span></th>
										<td><input type="text" id="car_id" name="car_id"
											maxlength="18" value="" title="차량번호 입력">
											<p class="anno">* 임시번호로 회원카드 발급 및 충전이 불가합니다.</p></td>
									</tr>
									<tr>
										<th>발급요청사유 <span class="nece">*</span></th>
										<td><select id="issue_reason" name="issue_reason"
											title="발급요청사유 선택" onchange="changeReason();">
												<option value="">선택</option>

												<option value="0001">신규(신차)</option>

												<option value="0003">분실</option>

												<option value="0004">파손</option>

												<option value="0005">기타</option>

												<option value="0006">신규(중고)</option>

										</select> <input type="text" id="issue_purp" name="issue_purp"
											title="발급요청사유" value="" style="display: none; width: 60%;">
										</td>
									</tr>
									<tr>
										<th>발급방법 <span class="nece">*</span></th>
										<td style="line-height: 4.5rem;"><input type="hidden"
											name="issue_mthd_cd" id="issue_mthd_cd" value="0002">
											등기배송</td>
									</tr>
									<tr>
										<th>배송지 정보 <span class="nece">*</span></th>
										<td><input type="text" id="ship_zip_code"
											name="ship_zip_code" value="" title="우편번호" readonly=""
											class="middle zipcode"> <!-- <a href="javascript:execDaumPostcode();">우편번호찾기</a>  -->
											<a href="#"
											onclick="popup('/nportal/addrlink/addrPopup.do' ,'400','500','Y','addrPopup');">우편번호찾기</a>
											<br> <input type="text" id="ship_addr_1"
											name="ship_addr_1" value="" title="주소" readonly=""
											class="long" style="margin: 5px 0;"><br> <input
											type="text" id="ship_addr_2" name="ship_addr_2" value=""
											title="상세주소" class="long"></td>
									</tr>
								</tbody>
							</table>
							<p class="alert">등기우편은 본인에게만 교부하며, 본인이 직접 등기우편을 받을 수 있는
								장소(ex.직장주소)로 배송지를 등록하여 주시기 바랍니다.</p>
						</div>
						<div class="btnBox">
							<a href="#" class="btn_agree_next"
								onclick="goComplet();return false;">완료</a>
						</div>
					</form>
				</div>
				<!-- 탭1 -->
				<div class="tabPage"></div>
				<!-- 탭2 -->
			</div>
			<!-- subWrap -->
		</div>
		<!-- pageBox -->
	</div>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/tayotayo/resources/js/scripts.js"></script>
</body>
</html>