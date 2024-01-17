package com.multi.tayotayo.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.multi.tayotayo.review.ReplyVO;
import com.multi.tayotayo.review.ReviewVO;

@Service
public class MemberService {
	@Autowired
	MemberDAO dao;

	// 암호화 pw
	@Autowired
	BCryptPasswordEncoder pwEncoder;
	
	public int slogin(MemberVO memberVO) {
		MemberVO m=dao.one(memberVO.getMember_id());
		String getPw = m.getPw();
		//System.out.println("암호화된 비밀번호: " + getPw);
		int result = 0;// 암호가 맞지 않음.
		
		//System.out.println("비밀번호확인: " + pwEncoder.matches(memberVO.getPw(), getPw));
		if (pwEncoder.matches(memberVO.getPw(), getPw)) {
			result = 1;
		}
		return result;
	}
	
	public void insert(MemberVO memberVO) {
		memberVO.setPw(pwEncoder.encode(memberVO.getPw())); // 비밀번호 암호화
		dao.insert(memberVO);
	}
	
	public void nameupdate(MemberVO memberVO) {
		dao.nameupdate(memberVO);
	}
	
	public void nicknameupdate(MemberVO memberVO) {
		dao.nicknameupdate(memberVO);
	}
	
	public void emailupdate(MemberVO memberVO) {
		dao.emailupdate(memberVO);
	}
	
	public void telupdate(MemberVO memberVO) {
		dao.telupdate(memberVO);
	}
	
	public void pwupdate(MemberVO memberVO) {
		memberVO.setPw(pwEncoder.encode(memberVO.getPw())); 
		dao.pwupdate(memberVO);
	}
	
	public void delete(MemberVO memberVO) {
		dao.delete(memberVO);
	}
	
	//내정보 가져오기
	public MemberVO myselect(MemberVO memberVO) {
		return dao.one(memberVO.getMember_id());
	}
	
	public int idConfirm(String member_id)  {

		if(dao.idConfirm(member_id) == null) {
			//dao에서 select이 되지 않아야 true
			//id가 없어야 true(사용 가능)
			return 1;
		}else {
			//id가 있으면 false(중복으로 사용 불가능)
			return 0;
		}
		
	}
	
	//비밀번호 변경시 비밀번호 일치하는지 검사
	public int pwConfirm(MemberVO memberVO) {
		if(pwEncoder.matches(memberVO.getPw(), dao.pwConfirm(memberVO))) { //잘 입력된 비밀번호
			return 1;
		}else {
			return 0; //잘 입력된 비밀번호
		}
		
	}
	
	public int nicknameConfirm(String nickname)  {

		if(dao.nicknameConfirm(nickname) == null) {
			//dao에서 select이 되지 않아야 true
			//id가 없어야 true(사용 가능)
			return 1;
		}else {
			//id가 있으면 false(중복으로 사용 불가능)
			return 0;
		}
		
	}
	
	public int emailConfirm(String email)  {

		if(dao.emailConfirm(email) == null) {
			//dao에서 select이 되지 않아야 true
			//id가 없어야 true(사용 가능)
			return 1; //이메일이 존재 x
		}else {
			//id가 있으면 false(중복으로 사용 불가능)
			return 0; //이메일이 존재 0
		}
		
	}
	
	public int telConfirm(String tel)  {

		if(dao.telConfirm(tel) == null) {
			//dao에서 select이 되지 않아야 true
			//id가 없어야 true(사용 가능)
			return 1;
		}else {
			//id가 있으면 false(중복으로 사용 불가능)
			return 0;
		}
		
	}
	
	public MemberVO id_find_to_email(MemberVO memberVO) {
		return dao.id_find_to_email(memberVO);
	}
	
	//댓글 개수 조회
	public int getSearchTotalCount(ReplyVO replyVO) {
		return dao.getSearchTotalCount(replyVO);
	}
	
	//개수에 맞게 댓글 조회
	public Map<String, Object> getSearchListWithPagination(int page, int pageSize, ReplyVO replyVO) {
		System.out.println("서비스까지옴?");
		int start = 1 + (page - 1) * pageSize;
		int end = page * pageSize;

		List<ReplyVO> searchList = dao.getSearchList(start, end, replyVO);
		int totalCount = dao.getSearchTotalCount(replyVO);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		Map<String, Object> result = new HashMap<>();
		result.put("numPages", totalPages);
		result.put("posts", searchList);

		System.out.println(searchList);
		return result;
	}

	
}
