/**
 *  이메일로 찾기 관련 처리
 */
 
 function fn_join(){
 			const form = document.createElement('form'); // form 태그 생성
			form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
			form.setAttribute('action', '/tayotayo/member/pwupdate_form'); // 전송할 url 지정
			let social = document.createElement('input'); //<input>
			social.setAttribute('type', 'hidden');
			social.setAttribute('name', 'member_id');
			social.setAttribute('value', $('#member_id2').val());


			form.appendChild(social);

			document.body.appendChild(form);
			form.submit();
 	
 }
 
 $(function() { 
 	let ok=0;
 	var email_auth_cd = '';
 
	$('#join2').click(function(){
		
		if($('#member_id2').val() == ""){
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		if($('#email').val() == ""){
			alert("닉네임을 입력해주세요.");
			return false;
		}
		
		if($('#email_auth_key').val() != email_auth_cd){
			alert("인증번호가 일치하지 않습니다.");
			return false;
		}
	
		if (ok==1){
		fn_join();
		}
		else {
			alert('인증번호 확인을 해주세요.')
		}
	});
	
		//인증 코드 비교
    $("#email_auth_check_btn2").click(function() {
    
    	const inputCode = $("#email_auth_key").val(); //인증번호 입력 칸에 작성한 내용 가져오기
    	
    	console.log("입력코드 : " + inputCode);
    	if(inputCode==""){
    		alert('인증번호를 입력해주세요.')
    		return false;
    	}
    	if(Number(inputCode) ===Number(email_auth_cd)){
    		alert('인증번호가 일치합니다.');
    		ok=1;
    		$("#member_id2").attr("disabled",true);
    		$("#email").attr("disabled",true);
    		document.querySelector('#email_auth_btn').style.display = 'none';
    		$("#email_auth_check_btn2").disabled = true;
    		document.querySelector('#email_auth_check_btn2').disabled = true;
 			document.getElementById('email_auth_check_btn2').innerText = '인증 성공';
    	}else{
        	alert('인증번호가 불일치 합니다. 다시 확인해주세요!');

    	}
    });
    
	$("#email_auth_btn").click(function(){	     	 
    	 var email = $('#email').val();
    	 var id = $('#member_id2').val();
    	 
    	 if(id == ''){
    	 	alert("아이디를 입력해주세요.");
    	 	return false;
    	 }
    	 
    	 if(email == ''){
    	 	alert("이메일을 입력해주세요.");
    	 	return false;
    	 }
    	 
    	 $.ajax({
			type : "POST",
			url : "/tayotayo/member/emailAuth",
			data : {email : email,
					member_id : id
			},
			success: function(data){
			if(data=="x"){
				alert("아이디 또는 이메일이 일치하지 않습니다.");
			}
			else{
				alert("인증번호가 발송되었습니다.");
				email_auth_cd = data;
				}
			},
			error: function(data){
				alert("아이디 또는 이메일이 일치하지 않습니다.");
			}
		}); 
	});
	

 });