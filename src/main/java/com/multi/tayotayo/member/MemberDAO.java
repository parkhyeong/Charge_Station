package com.multi.tayotayo.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.multi.tayotayo.review.ReplyVO;
import com.multi.tayotayo.review.ReviewVO;


@Repository
public class MemberDAO{ 
	@Autowired
	SqlSessionTemplate my;
	
	//로그인 (암호화전 지금은 사용 x)
	public int count(MemberVO memberVO) {
		return my.selectOne("member.count", memberVO);
	}
	
	//사용자 정보 조회, 로그인용으로도 사용
	public MemberVO one(String member_id) {
		MemberVO result = my.selectOne("member.one", member_id);
		//System.out.println("result 결과 전");
		//System.out.println(result);
		return result;
	}
	
	//회원가입
	public void insert(MemberVO memberVO) {
		my.insert("member.insert", memberVO);
	}
	
	//이름변경
	public void nameupdate(MemberVO memberVO) {
		my.insert("member.nameupdate", memberVO);
	}
	
	//닉네임변경
	public void nicknameupdate(MemberVO memberVO) {
		my.insert("member.nicknameupdate", memberVO);
	}
	
	//이메일변경
	public void emailupdate(MemberVO memberVO) {
		my.insert("member.emailupdate", memberVO);
	}
	
	
	//휴대전화변경
	public void telupdate(MemberVO memberVO) {
		my.insert("member.telupdate", memberVO);
	}
	
	//비밀번호변경
	public void pwupdate(MemberVO memberVO) {
		my.insert("member.pwupdate", memberVO);
	}
	
	//계정삭제
	public void delete(MemberVO memberVO) {
		my.insert("member.delete", memberVO);
	}
	
	//id검사
	public String idConfirm(String member_id) {
		return my.selectOne("member.idConfirm", member_id);
	}
	
	//비밀번호 변경시 비밀번호가 일치하는지 검사
	public String pwConfirm(MemberVO memberVO) {
		return my.selectOne("member.pwConfirm", memberVO);
	}
	
	//닉네임검사
	public String nicknameConfirm(String nickname) {
		return my.selectOne("member.nicknameConfirm", nickname);
	}
	
	//휴대전화검사
	public String telConfirm(String tel) {
		return my.selectOne("member.telConfirm", tel);
	}
	
	//이메일검사
	public String emailConfirm(String email) {
		return my.selectOne("member.emailConfirm", email);
	}
	
	//나의 정보조회
	public MemberVO myselect(String member_id) {
		
		return my.selectOne("member.one",member_id);
	}
	
	public MemberVO id_find_to_email(MemberVO memberVO) {
		return my.selectOne("member.id_find_to_email",memberVO);
	}
	
	//전화번호로 내정보찾기
	public MemberVO id_find_to_tel(MemberVO memberVO) {
		return my.selectOne("member.id_find_to_tel",memberVO);
	}
	
	
	//내댓글 개수
	public int getSearchTotalCount(ReplyVO replyVO) {
		return my.selectOne("member.replysearchTotalCount", replyVO);
	}
	
	public List<ReplyVO> getSearchList(int start, int end, ReplyVO replyVO) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		params.put("replyVO", replyVO);
		return my.selectList("member.myreplyList", params);
	}
	
}
