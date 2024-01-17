<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 
<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
<meta charset="UTF-8">
<title>타요타요 회원가입</title>

<jsp:include page="/header.jsp"></jsp:include>

<style type="text/css">
html {
    height: 100%;
}

body {
    margin: 0;
    height: 100%;
    background: #f5f6f7;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}
#logo {
    width: 240px;
    height: 44px;
    cursor: pointer;
}

#header {
    padding-top: 62px;
    padding-bottom: 20px;
    text-align: center;
}
#wrapper {
    position: relative;
    height: 100%;
}


/* 입력폼 */

input:focus {
    outline: none;
}


h3 {
    margin: 19px 0 8px;
    font-size: 14px;
    font-weight: 700;
}


.box {
    display: block;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: relative;
}

.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
}

input {
    font-family: Dotum,'돋움',Helvetica,sans-serif;    
}

.box.int_id {
    padding-right: 110px;
}

.box.int_pass {
    padding-right: 40px;
}

.box.int_pass_check {
    padding-right: 40px;
}

.step_url {
    /*@naver.com*/
    position: absolute;
    top: 16px;
    right: 13px;
    font-size: 15px;
    color: #8e8e8e;
}

.pswdImg {
    width: 18px;
    height: 20px;
    display: inline-block;
    position: absolute;
    top: 50%;
    right: 16px;
    margin-top: -10px;
    cursor: pointer;
}

#bir_wrap {
    display: table;
    width: 100%;
}

#bir_yy {
    display: table-cell;
    width: 147px;
    
}

#bir_mm {
    display: table-cell;
    width: 147px;
    vertical-align: middle;
}

#bir_dd {
    display: table-cell;
    width: 147px;
}

#bir_mm, #bir_dd {
    padding-left: 10px;
}

select {
    width: 100%;
    height: 29px;
    font-size: 15px;
    background: #fff url(https://static.nid.naver.com/images/join/pc/sel_arr_2x.gif) 100% 50% no-repeat;
    background-size: 20px 8px;
    -webkit-appearance: none;
    display: inline-block;
    text-align: start;
    border: none;
    cursor: default;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

/* 에러메세지 */

.error_next_box {
    margin-top: 9px;
    font-size: 12px;
    color: red;    
    display: none;
}

#alertTxt {
    position: absolute;
    top: 19px;
    right: 38px;
    font-size: 12px;
    color: red;
    display: none;
}

/* 버튼 */

.btn_area {
    margin: 30px 0 91px;
}

#btnJoin {
    width: 100%;
    padding: 21px 0 17px;
    border: 0;
    cursor: pointer;
    color: #fff;
    background-color: #08a600;
    font-size: 20px;
    font-weight: 400;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

section {
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);

    position: absolute;
    left: 50%;
    transform: translate(-50%);
    width: 460px;

}

</style>

</head>
<body>

        <!-- header -->
        <div id="header">
            <label  style="font-size:30px">회원가입</label>
        </div>

	
        <!-- wrapper -->
        <div id="wrapper">

            <!-- section -->
            <section>
				<form action="${pageContext.request.contextPath}/member/insert" method="post" accept-charset="utf-8" onsubmit="return doAction()">
                <!-- ID -->
                <div>
                    <h3 class="join_title">
                        <label for="id">아이디</label>
                    </h3>
                    <span class="box int_id">
                        <input type="text" id="id" class="int" maxlength="20" name="member_id" required>
                        <span class="step_url">@tayotayo.com</span>
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- PW1 -->
                <div>
                    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                    <span class="box int_pass">
                        <input type="password" id="pswd1" class="int" maxlength="20" name="pw" required>
                        <span id="alertTxt">사용불가</span>
                        <img src="${pageContext.request.contextPath}/resources/img/m_icon_pass.png" id="pswd1_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- PW2 -->
                <div>
                    <h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
                    <span class="box int_pass_check">
                        <input type="password" id="pswd2" class="int" maxlength="20" required>
                        <img src="${pageContext.request.contextPath}/resources/img/m_icon_check_disable.png" id="pswd2_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- NAME -->
                <div>
                    <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" class="int" maxlength="20" name="name" required>
                    </span>
                    <span class="error_next_box"></span>
                </div>

                <!-- NICKNAME -->
                <div>
                    <h3 class="join_title"><label for="nickname">닉네임</label></h3>
                    <span class="box int_name">
                        <input type="text" id="nickname" class="int" maxlength="20" name="nickname" required>
                    </span>
                    <span class="error_next_box"></span>
                </div>
                
                <!-- MOBILE -->
                <div>
                    <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
                    <span class="box int_mobile">
                        <input type="tel" id="mobile" class="int" maxlength="16" placeholder="전화번호 입력" name="tel" required>
                    </span>
                    <span class="error_next_box"></span>    
                </div>

                <!-- EMAIL -->
                <div>
                    <h3 class="join_title"><label for="email">본인확인 이메일</label></h3>
                    <span class="box int_email">
                        <input type="text" id="email" class="int" maxlength="100" placeholder="필수입력" name="email" required>
                    </span>
                    <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>    
                </div>

                <!-- JOIN BTN-->
                <div class="btn_area">
                    <button type="submit" id="btnJoin" >
                        <span>가입하기</span>
                    </button>
                </div>

                
				</form>
   </section> 
            <!-- section -->

        </div> 
         <script>
         var id = document.querySelector('#id');
		
         var pw1 = document.querySelector('#pswd1');
         var pwMsg = document.querySelector('#alertTxt');
         var pwImg1 = document.querySelector('#pswd1_img1');

         var pw2 = document.querySelector('#pswd2');
         var pwImg2 = document.querySelector('#pswd2_img1');
         var pwMsgArea = document.querySelector('.int_pass');

         var userName = document.querySelector('#name');
         var nickName = document.querySelector('#nickname');


         var email = document.querySelector('#email');

         var mobile = document.querySelector('#mobile');

         var error = document.querySelectorAll('.error_next_box');



         /*이벤트 핸들러 연결*/


         id.addEventListener("focusout", checkId);
         pw1.addEventListener("focusout", checkPw);
         pw2.addEventListener("focusout", comparePw);
         userName.addEventListener("focusout", checkName);
         nickName.addEventListener("focusout", checknickName);

         email.addEventListener("focusout", isEmailCorrect);
         mobile.addEventListener("focusout", checkPhoneNum);



     	let idok = 0;
     	let passok = 0; 
     	let cpassok = 0; 
     	let nameok = 0;
    	let nicknameok = 0; 
    	let telok = 0;
    	let emailok = 0; 



         /*콜백 함수*/


         function checkId() {
        		$.ajax({
    				type : "post",/* 전송 방식 */
    				url : "idConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
    				data : {
    					"member_id" : id.value
    				},

    				success : function(data) {
    					if (data == 0)  { //ajax가 제대로 안됐을 때 .
    		                 error[0].innerHTML = "아이디가 이미 존재합니다.";
    		                 error[0].style.display = "block";
    						idok = 0 //불가 
    						
    					}
    				},
    				error : function() {
		                 error[0].innerHTML = "오류가 발생했습니다.";
		                 error[0].style.display = "block";
    					idok = 0
    					
    				}
    			})
        	 
             var idPattern = /[a-zA-Z0-9_-]{5,20}/;
             if(id.value === "") {
                 error[0].innerHTML = "필수 정보입니다.";
                 error[0].style.display = "block";
					idok = 0
					
             } else if(!idPattern.test(id.value)) {
                 error[0].innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
                 error[0].style.display = "block";
					idok = 0
             } else {
                 error[0].innerHTML = "멋진 아이디네요!";
                 error[0].style.color = "#08A600";
                 error[0].style.display = "block";
					idok = 1
             }
         }

         function checkPw() {
             var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
             if(pw1.value === "") {
                 error[1].innerHTML = "필수 정보입니다.";
                 error[1].style.display = "block";
                 passok = 0
             } else if(!pwPattern.test(pw1.value)) {
                 error[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
                 pwMsg.innerHTML = "사용불가";
                 pwMsgArea.style.paddingRight = "93px";
                 error[1].style.display = "block";
                 passok = 0
                 
                 pwMsg.style.display = "block";
                 pwImg1.src = "/tayotayo/resources/img/m_icon_not_use.png";
             } else {
                 error[1].style.display = "none";
                 pwMsg.innerHTML = "안전";
                 pwMsg.style.display = "block";
                 pwMsg.style.color = "#03c75a";
                 pwImg1.src = "/tayotayo/resources/img/m_icon_safe.png";
                 passok = 1
             }
         }

         function comparePw() {
             if(pw2.value === pw1.value && pw2.value != "") {
                 pwImg2.src = "/tayotayo/resources/img/m_icon_check_enable.png";
                 error[2].style.display = "none";
                 cpassok = 1; 
             } else if(pw2.value !== pw1.value) {
                 pwImg2.src = "/tayotayo/resources/img/m_icon_check_disable.png";
                 error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
                 error[2].style.display = "block";
                 cpassok = 0;
             } 

             if(pw2.value === "") {
                 error[2].innerHTML = "필수 정보입니다.";
                 error[2].style.display = "block";
                 cpassok = 0;
             }
         }

         function checkName() {
             var namePattern = /[a-zA-Z가-힣]/;
             if(userName.value === "") {
                 error[3].innerHTML = "필수 정보입니다.";
                 error[3].style.display = "block";
                 nameok = 0
             } else if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
                 error[3].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
                 error[3].style.display = "block";
                 nameok = 0
             } else {
                 error[3].style.display = "none";
                 nameok = 1
             }
         }

         function checknickName() {
        	 
        	 $.ajax({
 				type : "post",/* 전송 방식 */
 				url : "nicknameConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
 				data : {
 					"nickname" : nickName.value
 				},

 				success : function(data) {
 					if (data == 0) {
 						 //ajax가 제대로 안됐을 때 .
 		                 error[4].innerHTML = "닉네임이 이미 존재합니다.";
 		                 error[4].style.display = "block";
 						nicknameok = 0 //불가 
 					}
 				},
 				error : function() {
		                 error[4].innerHTML = "오류가 발생했습니다.";
		                 error[4].style.display = "block";
		                 nicknameok = 0 //불가 
 				}
 			})
 			
             var namePattern = /[a-zA-Z가-힣0-9]/;
             if(nickName.value === "") {
                 error[4].innerHTML = "필수 정보입니다.";
                 error[4].style.display = "block";
                 nicknameok = 0 //불가 
             } else if(!namePattern.test(nickName.value) || nickName.value.indexOf(" ") > -1) {
                 error[4].innerHTML = "한글과 영문 대 소문자, 숫자를 사용하세요. (특수기호, 공백 사용 불가)";
                 error[4].style.display = "block";
                 nicknameok = 0 //불가 
             } else {
                 error[4].style.display = "none";
                 nicknameok = 1 //가능 
             }
         }
         
         function checkPhoneNum() {
        	 
        	 $.ajax({
  				type : "post",/* 전송 방식 */
  				url : "telConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
  				data : {
  					"tel" : mobile.value
  				},

  				success : function(data) {
  					if (data == 0) {
  						 //ajax가 제대로 안됐을 때 .
  		                 error[5].innerHTML = "이미 등록된 휴대전화 입니다.";
  		                 error[5].style.display = "block";
  		                 telok = 0 //불가 
  					}
  				},
  				error : function() {
 		                 error[5].innerHTML = "오류가 발생했습니다.";
 		                 error[5].style.display = "block";
 		                telok = 0 //불가 
  				}
  			})
  			
             var isPhoneNum = /([01]{2})([01679]{1})([0-9]{3,4})([0-9]{4})/;

             if(mobile.value === "") {
                 error[5].innerHTML = "필수 정보입니다.";
                 error[5].style.display = "block";
                 telok = 0 //불가 
					
             } else if(!isPhoneNum.test(mobile.value)) {
                 error[5].innerHTML = "형식에 맞지 않는 번호입니다.";
                 error[5].style.display = "block";
                 telok = 0 //불가 
					
             } else {
                 error[5].style.display = "none";
                 telok = 1 //불가 
					 
             }
             
         }
         
         function isEmailCorrect() {
        	 
        	 $.ajax({
  				type : "post",/* 전송 방식 */
  				url : "emailConfirm", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
  				data : {
  					"email" : email.value
  				},

  				success : function(data) {
  					if (data == 0) {
  						
  		                 error[6].innerHTML = "이미 등록된 이메일 입니다.";
  		                 error[6].style.display = "block";
  						 emailok = 0 //불가 
  					}
  				},
  				error : function() {
 		                 error[6].innerHTML = "오류가 발생했습니다.";
 		                 error[6].style.display = "block";
 		                 emailok = 0 //불가 
  				}
  			})
  			
             var emailPattern = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/;

             if(email.value === ""){ 
                 error[6].innerHTML = "필수 정보입니다.";
                 error[6].style.display = "block";
                 emailok = 0 //불가 
             } else if(!emailPattern.test(email.value)) {
                 error[6].style.display = "block";
                 emailok = 0 //불가 
             } else {
                 error[6].style.display = "none"; 
                 emailok = 1 //가능 
					 
             }
             
         }


     	
     	function doAction(){
     		console.log(idok);
     		console.log(passok);
     		console.log(cpassok);
     		console.log(nameok);
     		console.log(nicknameok);
     		console.log(telok);
     		console.log(emailok);
     		
     		if (idok == 1 && passok == 1 && cpassok == 1 && nameok == 1 && nicknameok == 1 && telok==1 && emailok==1) {
    			return true;
    		}
     		else{
     		alert('다시 확인해주세요')
     		return false;
     		}
     	}

         </script>
    </body>
</html>