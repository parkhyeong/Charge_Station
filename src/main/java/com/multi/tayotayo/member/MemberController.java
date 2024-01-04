package com.multi.tayotayo.member;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberController {
	@Autowired
	MemberService memberservice;

	// 로그인
	@RequestMapping(value = "member/login", method = RequestMethod.POST)
	public String login(MemberVO memberVO, HttpSession session) {
		System.out.println(memberVO);

		int result = memberservice.login(memberVO);
		
		System.out.println(result);
		if (result == 0) {
			session.setAttribute("member_id", null);
			return "login_fail_alert";
		} else {
			session.setAttribute("member_id", memberVO.getMember_id());
			return "redirect:home.jsp";
		}

	}

	// 로그아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:home.jsp";
	}

	// 회원가입
	@RequestMapping(value = "member/insert", method = RequestMethod.POST)
	public String insert(MemberVO memberVO) {

		try {
			System.out.println(memberVO);
			memberservice.insert(memberVO);
			return "redirect:home.jsp";
		} catch (Exception e) {
			System.out.println("sql 실패");
			return "redirect:index.jsp";
		}

	}

	// 아이디 중복확인 처리
	@RequestMapping(value = "member/idConfirm", method = RequestMethod.POST)
	public void idConfirm(HttpServletResponse response, String member_id) throws IOException {
		// @RequestParam는 요청의 특정 파라미터 값을 찾아낼 때 사용하는 어노테이션
		memberservice.idConfirm(member_id, response); // 서비스에 있는 idOverlap 호출.
	}

	//닉네임 중복확인 처리
	@RequestMapping(value = "member/nicknameConfirm", method = RequestMethod.POST)
	public void nicknameConfirm(HttpServletResponse response, String nickname) throws IOException {
		memberservice.nicknameConfirm(nickname, response); 
	}
	
}
