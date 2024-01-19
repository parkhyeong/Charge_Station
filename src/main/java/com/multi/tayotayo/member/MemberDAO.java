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
public class MemberDAO implements MemberDAOinterface {
	@Autowired
	SqlSessionTemplate my;
	
	//로그인 (암호화전 지금은 사용 x)
	@Override
	public int count(MemberVO memberVO) {
		return my.selectOne("member.count", memberVO);
	}
	
	//사용자 정보 조회, 로그인용으로도 사용
	@Override
	public MemberVO one(String member_id) {
		MemberVO result = my.selectOne("member.one", member_id);
		//System.out.println("result 결과 전");
		//System.out.println(result);
		return result;
	}
	
	//회원가입
	@Override
	public void insert(MemberVO memberVO) {
		my.insert("member.insert", memberVO);
	}
	
	//이름변경
	@Override
	public void nameupdate(MemberVO memberVO) {
		my.insert("member.nameupdate", memberVO);
	}
	
	//닉네임변경
	@Override
	public void nicknameupdate(MemberVO memberVO) {
		my.insert("member.nicknameupdate", memberVO);
	}
	
	//이메일변경
	@Override
	public void emailupdate(MemberVO memberVO) {
		my.insert("member.emailupdate", memberVO);
	}
	
	
	//휴대전화변경
	@Override
	public void telupdate(MemberVO memberVO) {
		my.insert("member.telupdate", memberVO);
	}
	
	//비밀번호변경
	@Override
	public void pwupdate(MemberVO memberVO) {
		my.insert("member.pwupdate", memberVO);
	}
	
	//계정삭제
	@Override
	public void delete(MemberVO memberVO) {
		my.insert("member.delete", memberVO);
	}
	
	//id검사
	@Override
	public String idConfirm(String member_id) {
		return my.selectOne("member.idConfirm", member_id);
	}
	
	//비밀번호 변경시 비밀번호가 일치하는지 검사
	@Override
	public String pwConfirm(MemberVO memberVO) {
		return my.selectOne("member.pwConfirm", memberVO);
	}
	
	//닉네임검사
	@Override
	public String nicknameConfirm(String nickname) {
		return my.selectOne("member.nicknameConfirm", nickname);
	}
	
	//휴대전화검사
	@Override
	public String telConfirm(String tel) {
		return my.selectOne("member.telConfirm", tel);
	}
	
	//이메일검사
	@Override
	public String emailConfirm(String email) {
		return my.selectOne("member.emailConfirm", email);
	}
	
	//나의 정보조회
	@Override
	public MemberVO myselect(String member_id) {
		
		return my.selectOne("member.one",member_id);
	}
	
	@Override
	public MemberVO id_find_to_email(MemberVO memberVO) {
		return my.selectOne("member.id_find_to_email",memberVO);
	}
	
	//내댓글 개수
	@Override
	public int getSearchTotalCount(ReplyVO replyVO) {
		return my.selectOne("member.replysearchTotalCount", replyVO);
	}
	
	@Override
	public List<ReplyVO> getSearchList(int start, int end, ReplyVO replyVO) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		params.put("replyVO", replyVO);
		return my.selectList("member.myreplyList", params);
	}
	
}
