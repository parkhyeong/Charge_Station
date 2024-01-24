package com.multi.tayotayo.member;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.tayotayo.review.ReplyVO;
import com.multi.tayotayo.review.ReviewService;

@Controller
public class MemberController {
	@Autowired
	MemberService memberservice;

	@Autowired
	MemberDAO dao;

	@Autowired
	ReviewService reviewservice;

	@Autowired
	MailService mailService;

	@RequestMapping(value = "member/login_form", method = RequestMethod.GET)
	public String login_form(HttpSession session, Model model) {
		String member_id = (String) session.getAttribute("member_id");
		if (member_id == null) { // 로그인안했을경우 로그인화면으로 이동
			return "member/login";
		} else {
			return "redirect:/index.jsp";
		}
	}

	// 로그인
	@RequestMapping(value = "member/login", method = RequestMethod.POST)
	@ResponseBody
	public int login(MemberVO memberVO, HttpSession session) {

		int result = memberservice.slogin(memberVO);

		if (result == 0) { // 로그인 실패
			// session.setAttribute("member_id", null);
			return 0;
		} else { // 로그인 성공
			session.setAttribute("member_id", memberVO.getMember_id());
			session.setAttribute("type", "tayotayo");

			if (session.getAttribute("social_id") != null) {
				session.removeAttribute("social_id"); // 저장된 소셜id 세션에서 제거
			}

			System.out.println("tayotayo 로그인성공 아아디: " + (String) session.getAttribute("member_id"));
			return 1;
		}

	}

	// 마이페이지
	@RequestMapping(value = "member/mypage", method = RequestMethod.GET)
	public String mypage(HttpSession session, Model model) {

		String member_id = (String) session.getAttribute("member_id");
		String social_id = (String) session.getAttribute("social_id");

		if (member_id == null) { // 로그인안했을경우 로그인화면으로 이동
			return "member/login_empty_fail"; // 로그인 안함- 로그인창으로 이동
		}

		String type = (String) session.getAttribute("type");
		MemberVO result = dao.one(member_id); // member 테이블 조회
		// List<MemberVO> result2 = dao.myreviewlist(member_id);
		model.addAttribute("result", result);
		model.addAttribute("type", type);
		model.addAttribute("member_id", member_id);
		model.addAttribute("social_id", social_id);

		// 내 게시물 목록 --> MODEL
		// 내 댓글 목록 --> MODEL

		if (type.equals("naver") || type.equals("kakao") || type.equals("google")) {

			return "member/social_mypage"; // 소셜 마이페이지로 이동
		}
		return "member/mypage"; // 타요타요 마이페이지로 이동

	}

	// 로그아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index.jsp";
	}

	// 회원가입
	@RequestMapping(value = "member/insert", method = RequestMethod.POST)
	public String insert(MemberVO memberVO) {

		try {
			memberservice.insert(memberVO);
			return "member/create_account_success";
		} catch (Exception e) {
			System.out.println("sql 실패");
			return "redirect:/member/create_account.jsp";
		}

	}

	// 이름변경
	@RequestMapping(value = "member/nameupdate", method = RequestMethod.POST)
	public String nameupdate(MemberVO memberVO) {

		try {
			memberservice.nameupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:/member/mypage";

	}

	// 닉네임변경
	@RequestMapping(value = "member/nicknameupdate", method = RequestMethod.POST)
	public String nicknameupdate(MemberVO memberVO) {

		try {
			memberservice.nicknameupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:/member/mypage";

	}

	// 이메일변경
	@RequestMapping(value = "member/emailupdate", method = RequestMethod.POST)
	public String emailupdate(MemberVO memberVO) {

		try {
			memberservice.emailupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:/member/mypage";
	}

	// 휴대전화변경
	@RequestMapping(value = "member/telupdate", method = RequestMethod.POST)
	public String telupdate(MemberVO memberVO) {

		try {
			memberservice.telupdate(memberVO);
		} catch (Exception e) {
			System.out.println("sql 실패");
		}
		return "redirect:/member/mypage";

	}

	// 계정삭제
	@RequestMapping(value = "member/delete", method = RequestMethod.POST)
	public String delete(MemberVO memberVO, HttpSession session) {

		try {
			memberservice.delete(memberVO);
			session.invalidate(); // 세션끊기
			return "redirect:/index.jsp";
		} catch (Exception e) {
			System.out.println("sql 실패");
			return "redirect:/member/mypage";
		}

	}

	// 마이페이지에서 비밀번호변경
	@RequestMapping(value = "member/pwupdate", method = RequestMethod.POST)
	public String pwupdate(String pw_1, String pw_2, MemberVO memberVO, Model model) {

		try {

			if (memberservice.pwConfirm(memberVO) == 1) {
				//System.out.println("현재 비밀번호 일치");
			} else {
				//System.out.println("현재 비밀번호 불일치");
				model.addAttribute("fail", "현재 비밀번호가 일치하지않습니다.");
				return "member/pwupdatefail";
			}

			if (pw_1.equals(pw_2)) {
				memberVO.setPw(pw_1);
				memberservice.pwupdate(memberVO);

				return "member/pwupdatesuccess";
			} else {
				model.addAttribute("fail", "새 비밀번호가 일치하지않습니다.");
				return "member/pwupdatefail";
			}

		} catch (Exception e) {
			System.out.println("sql 실패");
		}

		return null;
	}

	// 비밀번호찾기에서 비밀번호변경
	@RequestMapping(value = "member/pwupdate2", method = RequestMethod.POST)
	@ResponseBody
	public int pwupdate2(String pw_1, String pw_2, MemberVO memberVO, Model model) {

		try {

			if (pw_1.equals(pw_2)) {
				memberVO.setPw(pw_1);
				memberservice.pwupdate(memberVO);

				return 1;
			} else {
				return 0;
			}

		} catch (Exception e) {
			System.out.println("sql 실패");
			return -1;
		}

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

	// 이메일로 비밀번호 찾기 변경 폼으로 이동
	@RequestMapping(value = "member/pwupdate_form", method = RequestMethod.POST)
	public String pwupdate_form(MemberVO memberVO, String inputCode, Model model) {

		if (mailService.verifyEmailCode(memberVO, inputCode)) { // 만료되거나 인증번호가 맞지않으면 비밀번호 폼으로 이동안되게 해둠
			try {
				memberVO.setMember_id(memberservice.id_find_to_email(memberVO).getMember_id());
				model.addAttribute("member", memberVO);
				return "member/pwupdate_form";
			} catch (Exception e) {
				return "redirect:/index.jsp";
			}

		} else {
			return "redirect:/index.jsp";
		}

	}

	// 이메일로 아이디 찾기 아이디조회 폼으로 이동
	@RequestMapping(value = "member/id_find_form", method = RequestMethod.POST)
	public String id_find_form(MemberVO memberVO, String inputCode, Model model) {

		try {
			// 이메일로 인증에서 이동
			if (mailService.verifyEmailCode(memberVO, inputCode)) { // 만료되거나 인증번호가 맞지않으면 비밀번호 폼으로 이동안되게 해둠
				MemberVO m = memberservice.id_find_to_email(memberVO);
				model.addAttribute("member", m);
			} else {
				return "redirect:/index.jsp";
			}

			return "member/id_find_form";
		} catch (Exception e) {
			return "redirect:/index.jsp";
		}

	}

	// 전화번호로 아이디 찾기 아이디조회 폼으로 이동
	@RequestMapping(value = "member/id_find_form2", method = RequestMethod.POST)
	public String id_find_form2(MemberVO memberVO, String inputCode, Model model) {

		try {
			// 아이디로 인증에서 이동
			if (mailService.telverifyEmailCode(memberVO, inputCode)) {
				MemberVO m = memberservice.id_find_to_tel(memberVO);
				model.addAttribute("member", m);
			} else {
				return "redirect:/index.jsp";
			}

			return "member/id_find_form";
		} catch (Exception e) {
			return "redirect:/index.jsp";
		}

	}

	// 내 댓글 불러오기
	@RequestMapping("member/getmyreplyList")
	@ResponseBody
	public Map<String, Object> getmyreplyList(int page, int pageSize, String keyword) {
		ReplyVO replyVO = new ReplyVO();
		replyVO.setRr_writer(keyword);

		int totalCount = memberservice.getSearchTotalCount(replyVO);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		if (page > totalPages) {
			page = totalPages;
		}

		Map<String, Object> result = memberservice.getSearchListWithPagination(page, pageSize, replyVO);
		result.put("numPages", totalPages);

		return result;
	}
	

}
