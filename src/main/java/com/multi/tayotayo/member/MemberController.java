package com.multi.tayotayo.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
	@Autowired
	MemberService memberservice;
	
	@Autowired
	MemberDAO dao;

	// 로그인
	@RequestMapping(value = "member/login", method = RequestMethod.POST)
	@ResponseBody
	public int login(MemberVO memberVO, HttpSession session) {
		System.out.println(memberVO);

		int result = memberservice.login(memberVO);
		
		System.out.println(result);
		if (result == 0) {
			//session.setAttribute("member_id", null);
			return 0;
		} else {
			session.setAttribute("member_id", memberVO.getMember_id());
			System.out.println((String)session.getAttribute("member_id"));
			return 1;
		}

	}
	
	//마이페이지
	@RequestMapping(value = "member/mypage", method = RequestMethod.GET)
	public void mypage(HttpSession session, Model model) {
		String member_id = (String)session.getAttribute("member_id");	
		MemberVO result= dao.one(member_id); //member 테이블 조회
		//List<MemberVO> result2 = dao.myreviewlist(member_id);
		model.addAttribute("result",result);
		//model.addAttribute("result2",result2);
	}

	// 로그아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/mainpage/MainPage.jsp";
	}

	// 회원가입
	@RequestMapping(value = "member/insert", method = RequestMethod.POST)
	public String insert(MemberVO memberVO) {

		try {
			System.out.println(memberVO);
			memberservice.insert(memberVO);
			return "member/create_account_success";
		} catch (Exception e) {
			System.out.println("sql 실패");
			return "redirect:create_account.jsp";
		}

	}

	
	// 이름변경
	@RequestMapping(value = "member/nameupdate", method = RequestMethod.POST)
	public String nameupdate(MemberVO memberVO) {

		try {
			System.out.println(memberVO);
			memberservice.nameupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:mypage";

	}
	
	// 닉네임변경
	@RequestMapping(value = "member/nicknameupdate", method = RequestMethod.POST)
	public String nicknameupdate(MemberVO memberVO) {

		try {
			System.out.println(memberVO);
			memberservice.nicknameupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:mypage";

	}
	
	// 이메일변경
	@RequestMapping(value = "member/emailupdate", method = RequestMethod.POST)
	public String emailupdate(MemberVO memberVO) {

		try {
			System.out.println(memberVO);
			memberservice.emailupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:mypage";
	}
	
	// 휴대전화변경
	@RequestMapping(value = "member/telupdate", method = RequestMethod.POST)
	public String telupdate(MemberVO memberVO) {

		try {
			System.out.println(memberVO);
			memberservice.telupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:mypage";

	}
	
	
	// 계정삭제
	@RequestMapping(value = "member/delete", method = RequestMethod.POST)
	public String delete(MemberVO memberVO, HttpSession session) {

		try {
			System.out.println(memberVO);
			memberservice.delete(memberVO);
			session.invalidate(); //세션끊기
			return "redirect:/mainpage/MainPage.jsp";
		} catch (Exception e) {
			System.out.println("sql 실패");
			return "redirect:mypage";
		}

	}
	
	// 비밀번호변경
	@RequestMapping(value = "member/pwupdate", method = RequestMethod.POST)
	public String pwupdate(String pw_1, String pw_2, MemberVO memberVO, Model model) {

		try {
			System.out.println(memberVO.getPw());
			if(memberservice.pwConfirm(memberVO)==1) {
				System.out.println("현재 비밀번호 일치");
			}
			else {
				System.out.println("현재 비밀번호 불일치");
				model.addAttribute("fail", "현재 비밀번호가 일치하지않습니다.");
				return "member/pwupdatefail";
			}
			
			if (pw_1.equals(pw_2)) {
				System.out.println("새비밀번호 일치");
				System.out.println(pw_1);
				memberVO.setPw(pw_1);
				memberservice.pwupdate(memberVO);
				System.out.println("비밀번호 변경 성공");

				return "member/pwupdatesuccess";
			}
			else {
				System.out.println("새비밀번호 불일치");
				model.addAttribute("fail", "새 비밀번호가 일치하지않습니다.");
				return "member/pwupdatefail";
			}

		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		
		return null;
	}
	
	
	// 아이디 중복확인 처리
	@RequestMapping(value = "member/idConfirm", method = RequestMethod.POST)
	@ResponseBody
	public int idConfirm(String member_id) {
		// @RequestParam는 요청의 특정 파라미터 값을 찾아낼 때 사용하는 어노테이션
		return memberservice.idConfirm(member_id); // 서비스에 있는 idOverlap 호출.
	}

	// 닉네임 중복확인 처리
	@RequestMapping(value = "member/nicknameConfirm", method = RequestMethod.POST)
	@ResponseBody
	public int nicknameConfirm(String nickname) {
		// @RequestParam는 요청의 특정 파라미터 값을 찾아낼 때 사용하는 어노테이션
		return memberservice.nicknameConfirm(nickname); // 서비스에 있는 idOverlap 호출.
	}
	
	// 전화번호 중복확인 처리
	@RequestMapping(value = "member/telConfirm", method = RequestMethod.POST)
	@ResponseBody
	public int telConfirm(String tel) {
		// @RequestParam는 요청의 특정 파라미터 값을 찾아낼 때 사용하는 어노테이션
		return memberservice.telConfirm(tel); // 서비스에 있는 idOverlap 호출.
	}
	
	// 이메일 중복확인 처리
	@RequestMapping(value = "member/emailConfirm", method = RequestMethod.POST)
	@ResponseBody
	public int emailConfirm(String email) {
		// @RequestParam는 요청의 특정 파라미터 값을 찾아낼 때 사용하는 어노테이션
		return memberservice.emailConfirm(email); // 서비스에 있는 idOverlap 호출.
	}
	
	
}
