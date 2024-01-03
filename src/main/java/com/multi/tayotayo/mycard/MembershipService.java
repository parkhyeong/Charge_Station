package com.multi.tayotayo.mycard;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class MembershipService {

	private MembershipDAO membershipDAO;

	public MembershipService(MembershipDAO membershipDAO) {
		this.membershipDAO = membershipDAO;
	}

	// 멤버쉽 카드 신청
	public void saveMembershipData(MembershipVO membership) {
		try {
			membershipDAO.saveMembership(membership);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 멤버쉽 카드 목록 불러오기
	public List<MembershipVO> getMembershipList(String c_memberid) {
		try {
			return membershipDAO.getMembershipList(c_memberid);
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	// 멤버쉽 카드 상세 정보 불러오기
	public MembershipVO getMembershipCardDetails(String cardNum) {
		try {
			return membershipDAO.getMembershipCardDetails(cardNum);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// 멤버쉽 카드 충전
	public void updateCardNewBalance(String cardNum, int newBalance, int newPoint) {
	    try {
	        Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("cardNum", cardNum);
	        paramMap.put("newBalance", newBalance);
	        paramMap.put("newPoint", newPoint);

	        membershipDAO.updateCardNewBalance(paramMap);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("충전 실패: " + e.getMessage());
	    }
	}

}
