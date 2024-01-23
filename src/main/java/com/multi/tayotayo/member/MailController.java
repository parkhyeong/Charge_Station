package com.multi.tayotayo.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MailController {

	@Autowired
	MemberService memberservice;
	
	@Autowired
	MailService mailservice;

	@Autowired
	RedisExample redisUtil;
	
	//아이디찾기 이메일로 찾기 (이메일 전송)
	@ResponseBody
	@RequestMapping(value = "member/idemailAuth", method = RequestMethod.POST)
	public int idemailAuth(MemberVO memberVO) {

		try {
			int result = memberservice.emailConfirm(memberVO.getEmail());
			String reply="아이디찾기";
			// 이메일이 존재할시
			if (result == 0) {
				mailservice.sendmail(memberVO, reply);

				return 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}

	//비밀번호 찾기 이메일로 찾기 (이메일 전송)
	@ResponseBody
	@RequestMapping(value = "member/pwemailAuth", method = RequestMethod.POST)
	public int pwemailAuth(MemberVO memberVO) {
		
		try {
			MemberVO memberVOconfirm = memberservice.myselect(memberVO);
			// 아이디와 이메일이 일치할시
			if (memberVO.getMember_id().equals(memberVOconfirm.getMember_id())
					&& memberVO.getEmail().equals(memberVOconfirm.getEmail())) {
				String reply="비밀번호찾기";
				
				mailservice.sendmail(memberVO, reply);

				return 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}
	
	//이메일 인증번호 일치여부 검사
	@ResponseBody
	@RequestMapping(value = "member/authCodeAuth", method = RequestMethod.POST)
	public String authCodeAuth(MemberVO memberVO, String inputCode) {

		if (mailservice.verifyEmailCode(memberVO, inputCode)) {
			return "ok";
		}
		return "x";
	}
	
}
