package com.multi.tayotayo.member;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class MailController {
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService memberservice;
	
	@ResponseBody
	@RequestMapping(value = "member/idemailAuth", method = RequestMethod.POST)
	public String idemailAuth(MemberVO memberVO) {
        
        try {
		int result =memberservice.emailConfirm(memberVO.getEmail());
		
		//이메일이 존재할시
		if (result == 0 ) {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
        String setFrom = "rnjsghd97@naver.com";
        String toMail = memberVO.getEmail();
        String title = "타요타요 인증 이메일 입니다.";
        String content = 
                "전기차 타요타요를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
           
        
        	return Integer.toString(checkNum);
		}
		else {
			return "x";
		}
        }catch(Exception e) {
            e.printStackTrace();
            return "x";
        }
        
	}
	
	@ResponseBody
	@RequestMapping(value = "member/emailAuth", method = RequestMethod.POST)
	public String emailAuth(MemberVO memberVO) {
        
        try {
		MemberVO memberVOconfirm =memberservice.myselect(memberVO);
		
		//아이디와 이메일이 일치할시
		if (memberVO.getMember_id().equals(memberVOconfirm.getMember_id())
				&& memberVO.getEmail().equals(memberVOconfirm.getEmail())) {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
        String setFrom = "rnjsghd97@naver.com";
        String toMail = memberVO.getEmail();
        String title = "타요타요 인증 이메일 입니다.";
        String content = 
                "전기차 타요타요를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
           
        
        	return Integer.toString(checkNum);
		}
		else {
			return "x";
		}
        }catch(Exception e) {
            e.printStackTrace();
            return "x";
        }
        
	}
}
