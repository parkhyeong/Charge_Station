package com.multi.tayotayo.member;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SocialController {
	@Autowired
	MemberService memberservice;
	
	@Autowired
	SocialService Socialservice;
	
	//소셜 등록
	@RequestMapping(value = "member/socialinsert", method = RequestMethod.POST)
	public String insert(MemberVO memberVO, HttpSession session)  {
		try {
			System.out.println(memberVO);
			
			//아이디 중복검사 true면 insert
			if (Socialservice.socialidConfirm(memberVO)) {
				memberservice.insert(memberVO);
			};
			
			session.setAttribute("member_id", memberVO.getMember_id());
			session.setAttribute("type", memberVO.getType());
			System.out.println(memberVO.getType()+ "세션저장 "+ memberVO.getType()+ "로그인 성공");
			System.out.println(memberVO.getName()+ "님 환영합니다.!! ");
			return "redirect:home.jsp";
		} catch (Exception e) {
			System.out.println("sql 실패");
			return "redirect:index.jsp";
		}

	}
}
