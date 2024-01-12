package com.multi.tayotayo.member;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	@Autowired
	MemberDAO dao;
	
	public int login(MemberVO memberVO) {
		System.out.println("MeberService : login()");
		return dao.count(memberVO);
	}
	
	public void insert(MemberVO memberVO) {
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
		dao.pwupdate(memberVO);
	}
	
	public void delete(MemberVO memberVO) {
		dao.delete(memberVO);
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
		if(dao.pwConfirm(memberVO) == null) { //잘못된 비밀번호
			return 0;
		}else {
			return 1; //잘 입력된 비밀번호
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
			return 1;
		}else {
			//id가 있으면 false(중복으로 사용 불가능)
			return 0;
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
	
}
