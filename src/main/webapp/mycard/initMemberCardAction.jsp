<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>

<%
	HttpSession sessionMembership = request.getSession(false);
if (sessionMembership == null || sessionMembership.getAttribute("member_id") == null) {
%>
<script>
	alert('로그인 후 멤버쉽 카드 신청이 가능합니다.');
	window.location.href = '${pageContext.request.contextPath}/member/login_form';
</script>
<%
	return;
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>전기차 타요타요 - 회원카드 신청</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
	font-size: 36px;
	color: #333;
	text-align: center;
	margin-bottom: 25px;
}

.subPageTab {
	list-style: none;
	padding: 0;
	margin: 0;
	text-align: center;
}

.subPageTab li {
	display: inline-block;
	margin-right: 10px;
}

.subPageTab a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	display: block;
	padding: 10px;
	text-align: center;
	border: 2px solid #ccc;
	border-radius: 5px;
}

.subPageTab li.on a {
	background-color: #ddd;
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

.table03 th, .table03 td {
	border: 1px solid #ccc;
	padding: 8px;
}

.table03 th {
	text-align: center;
}

.nece {
	color: red;
}

.selectBox, .inputBox {
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
	margin-left: 90%;
}

.btn_agree_next:hover {
	background-color: #fff;
	color: #212529;
	border: 1px solid #212529;
}
</style>

</head>
<body>
	<div id="top">
		<jsp:include page="../header.jsp"></jsp:include>
	</div>

	<div class="subPage" id="subPage">
		<div class="pageBox">
			<h1 class="pageTit js-scrollmotion_up"
				style="opacity: 1; transform: translateY(0px);">회원카드 신청</h1>
			<div class="subWrap">
				<ul class="subPageTab" id="subPageTab">
					<li class="on"><a href="#">회원카드/번호 신청서</a></li>
					<li><a href="/tayotayo/mycard/initMemberCardSearch.jsp">회원카드/번호
							발급조회</a></li>
				</ul>
				<div class="tabPage on">
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
										<th>아이디</th>
										<td><c:choose>
												<c:when test="${not empty member_id}">
                                        		${member_id}
                                       			<input type="hidden"
														name="c_memberid" id="c_memberid" value="${member_id}"
														title="이름">
													<input type="hidden" id="card_type" name="card_type"
														value="C">
												</c:when>
												<c:otherwise>
												비회원
													<input type="hidden" name="req_name" id="req_name"
														value="비회원" title="이름">
													<input type="hidden" id="card_type" name="card_type"
														value="C">
												</c:otherwise>
											</c:choose></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="formBox js-scrollmotion_up scrolldelay2"
							style="opacity: 1; transform: translateY(0px);">

							<div class="neceDiv">
								<h4>추가 정보 입력</h4>
								<p class="neceP">
									<span class="nece">*</span> 는 <span>필수 항목</span>입니다.
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
										<td><select id="car_kind" name="car_kind" title="차량종류 선택">
												<option value="">선택</option>

												<option value="승용차">승용차</option>

												<option value="경차">경차</option>

												<option value="버스">버스</option>

												<option value="SUV">SUV</option>

												<option value="준중형차">준중형차</option>

												<option value="기타">기타</option>

										</select></td>
									</tr>
									<tr>
										<th>차량모델 <span class="nece">*</span></th>
										<td><select id="car_model" name="car_model"
											title="차량모델 선택">
												<option value="">선택</option>
												<option value="아이오닉">현대&nbsp;:&nbsp;아이오닉</option>
												<option value="코나">현대&nbsp;:&nbsp;코나</option>
												<option value="블루온">현대&nbsp;:&nbsp;블루온</option>
												<option value="G80">현대&nbsp;:&nbsp;G80</option>
												<option value="아이오닉5">현대&nbsp;:&nbsp;아이오닉5</option>
												<option value="GV60">현대&nbsp;:&nbsp;GV60</option>
												<option value="GV80">현대&nbsp;:&nbsp;GV80</option>
												<option value="GV70">현대&nbsp;:&nbsp;GV70</option>
												<option value="아이오닉6">현대&nbsp;:&nbsp;아이오닉6</option>
												<option value="포터 일렉트릭">현대&nbsp;:&nbsp;포터 일렉트릭</option>
												<option value="니로">기아&nbsp;:&nbsp;니로</option>
												<option value="쏘울">기아&nbsp;:&nbsp;쏘울</option>
												<option value="레이">기아&nbsp;:&nbsp;레이</option>
												<option value="EV6">기아&nbsp;:&nbsp;EV6</option>
												<option value="EV9">기아&nbsp;:&nbsp;EV9</option>
												<option value="봉고 전기차">기아&nbsp;:&nbsp;봉고 전기차</option>
												<option value="SM3 Z.E.">르노&nbsp;:&nbsp;SM3 Z.E.</option>
												<option value="ZOE">르노&nbsp;:&nbsp;ZOE</option>
												<option value="트위지">르노&nbsp;:&nbsp;트위지</option>
												<option value="피스">파워프라자&nbsp;:&nbsp;피스</option>
												<option value="i3">BMW&nbsp;:&nbsp;i3</option>
												<option value="iX">BMW&nbsp;:&nbsp;iX</option>
												<option value="iX3">BMW&nbsp;:&nbsp;iX3</option>
												<option value="i4">BMW&nbsp;:&nbsp;i4</option>
												<option value="iX1">BMW&nbsp;:&nbsp;iX1</option>
												<option value="530e">BMW&nbsp;:&nbsp;530e</option>
												<option value="미니쿠퍼 SE">BMW&nbsp;:&nbsp;미니쿠퍼 SE</option>
												<option value="다니고밴">대창모터스&nbsp;:&nbsp;다니고밴</option>
												<option value="볼트 EV">한국GM&nbsp;:&nbsp;볼트 EV</option>
												<option value="스파크">한국GM&nbsp;:&nbsp;스파크</option>
												<option value="볼트 EUV">한국GM&nbsp;:&nbsp;볼트 EUV</option>
												<option value="일진무시동전기냉동탑차(149.9km)">일진정공&nbsp;:&nbsp;일진무시동전기냉동탑차(149.9km)</option>
												<option value="일진무시동전기냉동탑차(186.1km)">일진정공&nbsp;:&nbsp;일진무시동전기냉동탑차(186.1km)</option>
												<option value="리프">닛산&nbsp;:&nbsp;리프</option>
												<option value="모델 3">테슬라&nbsp;:&nbsp;모델 3</option>
												<option value="모델 S">테슬라&nbsp;:&nbsp;모델 S</option>
												<option value="모델 Y">테슬라&nbsp;:&nbsp;모델 Y</option>
												<option value="모델 X">테슬라&nbsp;:&nbsp;모델 X</option>
												<option value="I-페이스">재규어&nbsp;:&nbsp;I-페이스</option>
												<option value="EQC">벤츠&nbsp;:&nbsp;EQC</option>
												<option value="EQA">벤츠&nbsp;:&nbsp;EQA</option>
												<option value="EQS">벤츠&nbsp;:&nbsp;EQS</option>
												<option value="EQB">벤츠&nbsp;:&nbsp;EQB</option>
												<option value="EQE">벤츠&nbsp;:&nbsp;EQE</option>
												<option value="e-트론 55 콰트로">폭스바겐그룹&nbsp;:&nbsp;e-트론
													55 콰트로</option>
												<option value="e-트론 50 콰트로">폭스바겐그룹&nbsp;:&nbsp;e-트론
													50 콰트로</option>
												<option value="e-트론 40">폭스바겐그룹&nbsp;:&nbsp;e-트론 40</option>
												<option value="ID.4">폭스바겐그룹&nbsp;:&nbsp;ID.4</option>
												<option value="푸조 e-2008">스텔란티스&nbsp;:&nbsp;푸조
													e-2008</option>
												<option value="푸조 e-208">스텔란티스&nbsp;:&nbsp;푸조 e-208</option>
												<option value="DS3">스텔란티스&nbsp;:&nbsp;DS3</option>
												<option value="EV Z">스마트솔루션즈&nbsp;:&nbsp;EV Z</option>
												<option value="쎄보-C">쎄보모빌리티&nbsp;:&nbsp;쎄보-C</option>
												<option value="타이칸">포르쉐&nbsp;:&nbsp;타이칸</option>
												<option value="E100">케이지모빌리티&nbsp;:&nbsp;E100</option>
												<option value="코란도">케이지모빌리티&nbsp;:&nbsp;코란도</option>
												<option value="토레스">케이지모빌리티&nbsp;:&nbsp;토레스</option>
												<option value="폴스타2">폴스타&nbsp;:&nbsp;폴스타2</option>
												<option value="C40">볼보&nbsp;:&nbsp;C40</option>
												<option value="XC40">볼보&nbsp;:&nbsp;XC40</option>
												<option value="렉서스">토요타&nbsp;:&nbsp;렉서스</option>
												<option value="M1">마이브&nbsp;:&nbsp;M1</option>
												<option value="다니고">대창모터스&nbsp;:&nbsp;다니고</option>
												<option value="카운티 일렉트릭">현대&nbsp;:&nbsp;카운티 일렉트릭</option>
												<option value="일렉시티">현대&nbsp;:&nbsp;일렉시티</option>
												<option value="다니고C">대창모터스&nbsp;:&nbsp;다니고C</option>
												<option value="다니고3">대창모터스&nbsp;:&nbsp;다니고3</option>
												<option value="다니고R">대창모터스&nbsp;:&nbsp;다니고R</option>
												<option value="포트로-탑">디피코&nbsp;:&nbsp;포트로-탑</option>
												<option value="포트로-픽업">디피코&nbsp;:&nbsp;포트로-픽업</option>
												<option value="휴-스카이">디피코&nbsp;:&nbsp;휴-스카이</option>
												<option value="플러스">한신자동차&nbsp;:&nbsp;플러스</option>
												<option value="시티라이트">이온모터스&nbsp;:&nbsp;시티라이트</option>
												<option value="에픽시티">이엠코리아&nbsp;:&nbsp;에픽시티</option>
												<option value="E6">이비온&nbsp;:&nbsp;E6</option>
												<option value="브라보">비바모빌리티&nbsp;:&nbsp;브라보</option>
												<option value="비바">비바모빌리티&nbsp;:&nbsp;비바</option>
												<option value="젤라">에스에스라이트&nbsp;:&nbsp;젤라</option>
												<option value="브이버스">비바모빌리티&nbsp;:&nbsp;브이버스</option>
												<option value="마스타">마스타전기차&nbsp;:&nbsp;마스타</option>
												<option value="마사다">이브이케이엠씨&nbsp;:&nbsp;마사다</option>
												<option value="이티밴">제이스모빌리티&nbsp;:&nbsp;이티밴</option>
												<option value="스마트 T1.0">에디슨모터스&nbsp;:&nbsp;스마트
													T1.0</option>
												<option value="이화이버드">에디슨모터스&nbsp;:&nbsp;이화이버드</option>
												<option value="D2C">스마트솔루션즈&nbsp;:&nbsp;D2C</option>
												<option value="D2P">스마트솔루션즈&nbsp;:&nbsp;D2P</option>
												<option value="경인 냉동탑차">경인모터스&nbsp;:&nbsp;경인 냉동탑차</option>
												<option value="칼마토">제인모터스&nbsp;:&nbsp;칼마토</option>
												<option value="포텐스">진우에스엠씨&nbsp;:&nbsp;포텐스</option>
												<option value="T4K">GS글로벌&nbsp;:&nbsp;T4K</option>
												<option value="오텍 냉동탑차">오텍&nbsp;:&nbsp;오텍 냉동탑차</option>
												<option value="테라밴">테라팩토리&nbsp;:&nbsp;테라밴</option>
												<option value="EV J1">중원자동차&nbsp;:&nbsp;EV J1</option>
												<option value="익스플로러">포드&nbsp;:&nbsp;익스플로러</option>
												<option value="기타">기타&nbsp;:&nbsp;기타</option>
										</select>
											<p class="anno">* 공공급속충전인프라 회원인증용으로, 급속충전이 가능한 환경부 보급대상
												차종에 한하여 발급이 가능합니다.</p></td>
									</tr>
									<tr>
										<th>차량번호 <span class="nece">*</span></th>
										<td><input type="text" id="car_number" name="car_number"
											maxlength="18" value="" title="차량번호 입력">
											<p class="anno">* 임시번호로 회원카드 발급 및 충전이 불가합니다.</p></td>
									</tr>
									<tr>
										<th>발급요청사유 <span class="nece">*</span></th>
										<td><select id="card_reason" name="card_reason"
											title="발급요청사유 선택">
												<option value="">선택</option>
												<option value="신규">신규</option>
												<option value="분실">분실</option>
												<option value="파손">파손</option>
												<option value="기타">기타</option>
										</select> <input type="text" id="reason_purp" name="reason_purp"
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
										<th>배송지 <br>정보 <span class="nece">*</span></th>
										<td><input type="text" id="ship_zip_code"
											name="ship_zip_code" value="" title="우편번호"
											class="middle zipcode" style="background-color: #e9ecef;"
											placeholder="우편번호 찾기"> <input type="button"
											onclick="DaumPostcode()" value="우편번호 찾기"
											style="background-color: #212529; color: white;"><br>
											<input type="text" id="ship_addr_1" name="ship_addr_1"
											value="" title="주소" class="long" placeholder="주소"
											style="margin: 5px 0; background-color: #e9ecef; width: 60%;"><br>
											<input type="text" id="ship_addr_2" name="ship_addr_2"
											value="" title="상세주소" class="long" placeholder="상세주소"
											style="width: 60%;"></td>
									</tr>
								</tbody>
							</table>
							<p class="alert">등기우편은 본인에게만 교부하며, 본인이 직접 등기우편을 받을 수 있는
								장소(ex.직장주소)로 배송지를 등록하여 주시기 바랍니다.</p>
						</div>

						<div class="btnBox">
							<a href="#" class="btn_agree_next"
								onclick="saveMembershipData(); return false;">완료</a>
						</div>


						<%-- <div class="btnBox">
							<c:choose>
								<c:when test="${session.getAttribute('c_memberId') != null}">
									<a href="#" class="btn_agree_next"
										onclick="saveMembershipData();return false;">완료</a>
								</c:when>
								<c:otherwise>
									<a href="#" class="btn_agree_next"
										onclick="checkLogin(); return false;">완료</a>
								</c:otherwise>
							</c:choose>
						</div> --%>
					</form>
				</div>
				<div class="tabPage"></div>
			</div>
		</div>
	</div>

	<script>
		var member_id = "<c:out value='${member_id}'/>";
		console.log(member_id);
		// 우편 정보 찾기
		function DaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							document.getElementById('ship_zip_code').value = data.zonecode;
							document.getElementById('ship_addr_1').value = data.address;
							document.getElementById('ship_addr_2').focus();
						}
					}).open();
		}
		// 카드 신청 정보 저장
		function saveMembershipData() {

			// 랜덤 멤버쉽 카드 번호 생성
			var randomCardNumber = generateRandomCardNumber();

			var c_memberid = "${session.getAttribute('member_id')}";
			var car_kind = document.getElementById('car_kind').value;
			var car_model = document.getElementById('car_model').value;
			var car_number = document.getElementById('car_number').value;
			var card_reason = document.getElementById('card_reason').value;
			var shipZipCode = document.getElementById('ship_zip_code').value;
			var shipAddr1 = document.getElementById('ship_addr_1').value;
			var shipAddr2 = document.getElementById('ship_addr_2').value;

			if (car_kind === "" || car_model === "" || car_number === ""
					|| card_reason === "" || shipZipCode === ""
					|| shipAddr1 === "" || shipAddr2 === "") {
				alert("모든 정보를 입력해야 합니다. 다시 확인해주세요.");
				return;
			}
			$.ajax({
				type : "POST",
				url : "saveMembershipData",
				data : {
					c_memberid : member_id,
					car_kind : car_kind,
					car_model : car_model,
					car_number : car_number,
					card_reason : card_reason,
					ship_zip_code : shipZipCode,
					ship_addr_1 : shipAddr1,
					ship_addr_2 : shipAddr2,
					card_num : randomCardNumber
				},
				success : function(response) {
					alert('신청이 완료되었습니다.');
					location.reload(true);
				},
				error : function(error) {
					alert('오류가 발생했습니다.');
				}
			});
		}
		//랜덤 멤버쉽 카드 번호 생성 
		function generateRandomCardNumber() {
			var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
			var cardNumber = '';
			for (var i = 0; i < 10; i++) {
				var randomIndex = Math.floor(Math.random() * characters.length);
				cardNumber += characters.charAt(randomIndex);
			}
			return cardNumber;
		}
	</script>

</body>
</html>