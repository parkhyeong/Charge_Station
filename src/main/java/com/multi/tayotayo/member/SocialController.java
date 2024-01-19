package com.multi.tayotayo.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SocialController {
	@Autowired
	MemberService memberservice;

	@Autowired
	SocialService socialservice;
	
	@Autowired
	MemberController memberController;
	

	// 소셜 등록됐는지 안됐는지 확인
	@RequestMapping(value = "member/socialinsert", method = RequestMethod.POST)
	public String insert(SocialVO socialVO, Model model, HttpSession session) {
		model.addAttribute("social", socialVO);
		//System.out.println(socialVO);
		
		// 아이디 중복검사 true면 insert
		if (socialservice.socialidConfirm(socialVO)) {
			return "member/social_memberid_confirm";
		} else {
			String member_id_confirm = socialservice.member_id_select(socialVO);
			session.setAttribute("member_id", member_id_confirm);
			session.setAttribute("type", socialVO.getType());
			session.setAttribute("social_id", socialVO.getId());
			
			System.out.println(member_id_confirm + " 세션저장 " + "로그인 성공");
			System.out.println(socialVO.getType() + " 소셜로그인");

			return "member/social_login_success";
		}
	}
	

	// 소셜 등록
	@RequestMapping(value = "member/social_memberid_update", method = RequestMethod.POST)
	@ResponseBody
	public int social_memberid_update(SocialVO socialVO, String member_id, String pw, Model model, HttpSession session) {
		try {
			System.out.println(socialVO);
			System.out.println(member_id);
			System.out.println(pw);

			
			// 계정연동진행
			// member_id 확인
			MemberVO memberVO = new MemberVO();
			memberVO.setMember_id(member_id);
			memberVO.setPw(pw);

			if (login(memberVO)) {
				System.out.println("<<연동>> 타요타요 아이디가 맞습니다.");
				socialVO.setMember_id(memberVO.getMember_id());
				System.out.println(socialVO);
				socialservice.insert(socialVO);

			} else {
				System.out.println("연동아이디가 틀렸습니다.");
				model.addAttribute("msg" ,"연동아이디가 틀렸습니다.");
				return 0;
			}

			// 현재 연동된 member로그인 세션 찾기
			String member_id_confirm = socialservice.member_id_select(socialVO);
			session.setAttribute("member_id", member_id_confirm);
			session.setAttribute("type", socialVO.getType());
			session.setAttribute("social_id", socialVO.getId());
			
			System.out.println(member_id_confirm + " 세션저장 " + "로그인 성공");
			System.out.println(socialVO.getType() + " 소셜로그인");

			return 1;
		} catch (Exception e) {
			System.out.println("sql 실패");
			return 0;
		}

	}

	// 계정연동id 확인
	@RequestMapping(value = "member/memberidconfirm", method = RequestMethod.POST)
	public boolean login(MemberVO memberVO) {
		System.out.println(memberVO);

		int result = memberservice.slogin(memberVO);

		System.out.println(result);
		if (result == 0) { // 연동실패
			return false;
		} else { // 연동id 성공
			return true;
		}

	}
	
	//소셜로그인후 계정연동하기위한 타요타요 로그인
	@RequestMapping(value = "member/login_peristalsis", method = RequestMethod.POST)
	@ResponseBody
	public int login_peristalsis(MemberVO memberVO) {
		int result = memberservice.slogin(memberVO);
		System.out.println(result);
		
		return result; //숫자0 이면 연동실패, 1 연동성공
		
	}
	
	// 계정연동회원가입
	@RequestMapping(value = "member/creat_account_peristalsis", method = RequestMethod.POST)
	public String creat_account_peristalsis(SocialVO socialVO, Model model) {
		System.out.println(socialVO);

		model.addAttribute("social", socialVO);
		return "member/create_account_peristalsis";
	}

	//소셜연동후 회원가입시 넘어가는 페이지
	@RequestMapping(value = "member/create_account_insert", method = RequestMethod.POST)
	public String socialinsert2(MemberVO memberVO, String id, String type, Model model) {
		SocialVO socialVO= new SocialVO();
		socialVO.setId(id);
		socialVO.setType(type);
		
		System.out.println(socialVO);
		System.out.println(memberVO);
		
		memberController.insert(memberVO);
		model.addAttribute("social", socialVO);
		return "member/social_memberid_confirm";
	}
	
	// 소셜id 삭제(소셜 연동 취소)
		@RequestMapping(value = "social/delete", method = RequestMethod.POST)
		public String social_delete(SocialVO socialVO, HttpSession session) {

			try {
				socialservice.delete(socialVO);
				session.invalidate(); //세션끊기
				return "redirect:/mainpage/MainPage.jsp";
			} catch (Exception e) {
				System.out.println("sql 실패");
				return "redirect:/member/mypage";
			}
			
		}
		
}
