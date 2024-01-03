package com.multi.tayotayo.member;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SocialService {
	@Autowired
	SocialDAO socialdao;
	
	public boolean socialidConfirm(MemberVO memberVO)  {
		
		if(socialdao.socialidConfirm(memberVO) == null) {
			//dao에서 select이 되지 않아야 true
			//id가 없어야 true(사용 가능)
			return true;
		}else {
			//id가 있으면 false(중복으로 사용 불가능)
			return false;
		}
		
	}

}
