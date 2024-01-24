package com.multi.tayotayo.member;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;


@Service
public class MailService {  
	@Autowired
    private JavaMailSender mailSender;
	
    @Autowired
    private RedisExample redisUtil;  
    
	/* 이메일 보내기 */
	String setFrom = "ghd_5427@naver.com";
  
	//암호생성
    String createdCode() {  
		Random random = new Random();
		String checkNum = Integer.toString(random.nextInt(888888) + 111111);
  
        return checkNum;
    }  

    // 메일 만들기
    public int createmailForm(MemberVO memberVO, String reply) {  
    	try {
    	String authCode = createdCode();  
		String toMail = memberVO.getEmail();
		String title = "타요타요 "+reply+" 인증 이메일 입니다.";
		String content = "전기차 타요타요를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + authCode + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		helper.setFrom(setFrom);
		helper.setTo(toMail);
		helper.setSubject(title);
		helper.setText(content, true);
		mailSender.send(message);

		redisUtil.setDataExpire(toMail, authCode);
		
        return 1;  
    	}catch (Exception e) {
    		e.printStackTrace();
    		return 0;
		}

    }
  
    // 메일 보내기  
    public void sendmail(MemberVO memberVO, String reply) {  
        if (redisUtil.existData(memberVO.getEmail())) {  
            redisUtil.deleteData(memberVO.getEmail());  
        }  
  
        createmailForm(memberVO, reply); 
    }  
  
    // 이메일 코드 검증  
    public Boolean verifyEmailCode(MemberVO memberVO, String inputCode) {  
        String authCode = redisUtil.getData(memberVO.getEmail()); 
        if (authCode == null) {  
            return false;  
        } 
        else if (authCode.equals("")) {
        	return false;
        }
        return authCode.equals(inputCode);  
    }  

    // 전화번호 코드 검증  
    public Boolean telverifyEmailCode(MemberVO memberVO, String inputCode) {  
        String authCode = redisUtil.getData(memberVO.getTel()); 
        //System.out.println(authCode);
        if (authCode == null) {  
            return false;  
        }  
        else if (authCode.equals("")) {
        	return false;
        }
        return authCode.equals(inputCode);  
    }  
  
}