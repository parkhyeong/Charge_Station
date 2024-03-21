# Charge_Station



![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/94339f2a-722b-48a1-ba68-e4a7c1e0b4c5)
<h3>프로젝트 이름</h3>
Open Api를 사용한 전기차충전소 위치 제공 웹 서비스

<h3>프로젝트 기간</h3>
2023.01.01 ~ 2023.01.30
<h3>참여 인원</h3>
7명
<h3>프로젝트 소개</h3>
<P>
Open Api를 사용한 전기차충전소 위치 제공 웹 서비스<br>
전기차충전소 위치제공 및 해당 충전소 결제시스템, 리뷰게시판 제공
</P>

<h3>∙ 대상</h3>
<P>전기차 사용자</p>

<h3>∙ 기획의도</h3>
<p>전기차 충전소 위치 제공 및 간편한 결제시스템을 통해 전기차 사용자의 편의를 향상시키고, 충전소 사용자 간의 정보 공유를 위해 리뷰 커뮤니티를 구축하여 전기차 사용을 더욱 촉진하는 것입니다. 이를 통해 전기차 이용이 보다 용이해지며, 전기차 시장의 확대와 사용자 경험 개선에 기여할 것으로 전기차충전소 위치 제공 웹 서비스를 기획함</p>

<h3>∙ 핵심기능</h3>
<P>
전기차충전소 위치제공 및 결제시스템 기능<br>
해당 전기차충전소 상세보기 기능<br>
전체 충전소 불러오기 기능<br>
해당 전기차충전소 별점, 리뷰게시판 기능<br>
로그인 및 소셜 로그인 기능<br>
전기차 멤버십 기능<br>
</P>

<h3>. Languages Framework Library DB</h3>
<p>Java, HTML, CSS, JavaScript<br>
Spring, MyBatis, Ajax, JQuery<br>
MySQL, Redis
</p>

<h3>. 개발환경(S/W)</h3>
<p>Window 10, GitHub, STS, SourceTree, DBeaver</p>


<h3>. 역할</h3>
<p>
로그인 설계 및 구현<br>
로그인 관련 데이터베이스 설계<br>
마이페이지 설계 및 구현<br>
회원가입 설계 및 구현<br>
아이디 찾기/비밀번호 찾기 설계 및 구현
</p>

<h3>. 구현기능</h3>
<p>
로그인: 소셜 로그인 및 기존 사이트 로그인 기능<br>
마이페이지: 이름, 닉네임, 전화번호, 이메일 조회 및 변경, 비밀번호 변경, 회원 탈퇴 기능<br>
아이디 찾기/비밀번호 찾기: 이메일로 찾기, 전화번호로 찾기 기능<br>
회원가입: 아이디, 닉네임, 이메일, 전화번호 중복검사, 회원등록 기능<br>
</p>


<h3>. Process(홈페이지 구조, ERD 다이어그램, 시스템 설계 등)</h3>
<h4>전기차 충전소 순서도</h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/4a5230fc-d195-4adc-a3ce-179d1f495876)

<p>
- 메인 페이지에서 충전소 찾기, 멤버십 카드, 리뷰 게시판, 로그인 이동<br>
- 카카오 지도 API와 공공데이터 충전소 데이터 API를 통하여 충전소를 제공<br>
- 충전소를 주소, 전화번호 등으로 검색할 수 있도록 제공<br>
- 저희 사이트만의 멤버십 카드 개설, 해당 충전소 결제 시스템 제공<br>
- 해당하는 충전소에 리뷰 작성 제공<br>
- 소셜 로그인과 저희 사이트만의 로그인을 가능하게 설계<br>
</p>

<h4>ERD 다이어그램</h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/0cefd338-5371-41ed-9b98-459bff31908e)

<p>
- member 테이블의 member_id는 리뷰 게시판, 소셜, 멤버십 등 여러 테이블과 1대다 관계로 연결되며, 외래키로 사용<br>
- 소셜 로그인은 기존 사이트 로그인과 연동하여 member_id를 외래키로 저장 후 DB에 저장<br>
- membership 테이블은 멤버십의 각 카드가 포인트 내역 테이블에서 여러 건으로 나타나는 1대다 관계로 구성<br>
- 충전소 테이블과 충전기 상태 테이블은 1대 다 관계로 설계되어 각 충전소에 해당하는 충전기 상태를 DB에 저장<br>
</p>

<h4>클래스 다이어그램</h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/df61b3ff-2742-497d-a93f-11b5281a5346)


<h4><소셜 로그인 기능></h4>

소셜 로그인 동작원리

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/30c8d61d-9dcc-482a-a830-2f6699857beb)


<h3>. 구현한 기능</h3>
<h4>로그인 UI 구성</h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/db0c67cb-73de-4f76-bb64-03788c6384ad)

<h4>회원가입 UI & 기능 구현</h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/47db7178-4ef1-4bf3-b093-c0b7969bbeea)

<h4> 마이페이지 </h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/a25d3fef-58bf-463c-aa65-31728e771fa6)

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/8d5c37cc-b335-4b91-9c3d-75c2492389fe)


<h4>소셜 로그인 기능</h4> 
<p>(연동되어 있지 않다면 NO)</p>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/6fcd64a3-fd47-414f-ad5a-55fe35c564c6)

<p>
- 네이버 로그인 시 소셜 테이블에 해당 정보가 저장되어 있지 않다면 계정 연동 로그인 페이지 이동<br>
- 계정 연동 로그인 이후 소셜 테이블에 연동 아이디를 외래키로 받아서INSERT (연동 성공)<br>
- 연동된 소셜 아이디는 다음번에 로그인 시 연동 과정을 거치지 않고 바로 로그인<br>
</p>


<h4>휴대전화로 아이디 찾기</h4>

![image](https://github.com/parkhyeong/Charge_Station/assets/106435638/86f10e33-6887-4fb1-bc08-1b92b3bf9d87)

<p>
- 사용자가 이름과 전화번호를 입력하고, 이 두 정보가 일치할 때만 '인증번호 전송' 버튼을 클릭하면 문자 메시지를 통한 인증번호가 전송<br>
- ‘인증번호 확인’을 클릭하고 ‘ID찾기’를 진행하면 입력한 이름과 전화번호가 일치하는 ID를 사용자에게 보여줌<br>
- 인증번호 Redis DB를 이용하여 서버 메모리에 잠시 저장<br>
</p>

