package com.multi.tayotayo.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SocialDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	//id검사
	public String socialidConfirm(MemberVO memberVO) {
		
		return my.selectOne("social.idConfirm", memberVO);
	}


}
