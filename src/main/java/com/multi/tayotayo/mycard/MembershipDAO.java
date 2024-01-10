package com.multi.tayotayo.mycard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MembershipDAO {

	@Autowired
	private SqlSessionTemplate my;

	// 멤버쉽 카드 신청 저장
	public void saveMembership(MembershipVO membership) {
		my.insert("membership.saveMembership", membership);
		my.insert("membership.insertIntoPointHistory", membership);
	}

	// 멤버쉽 카드 목록 불러오기
	public List<MembershipVO> getMembershipList(String c_memberid) {
		Map<String, Object> param = new HashMap<>();
		param.put("c_memberid", c_memberid);
		return my.selectList("membership.getMembershipList", param);
	}

	// 멤버쉽 카드 상세 정보 불러오기
	public MembershipVO getMembershipCardDetails(String cardNum) {
		return my.selectOne("membership.getMembershipCardDetails", cardNum);
	}

	// 멤버쉽 카드 잔액 충전
	public void updateCardNewBalance(Map<String, Object> paramMap) {
		my.update("membership.updateCardNewBalance", paramMap);
		my.update("membership.updatePointCardNewBalance", paramMap);
	}

	// 멤버쉽 카드 목록 불러오기 (이용내역 조회용)
	public List<MembershipVO> getMembershipCardListForBillSearch(String c_memberid) {
		Map<String, Object> param = new HashMap<>();
		param.put("c_memberid", c_memberid);
		return my.selectList("membership.getMembershipCardListForBillSearch", param);
	}

	// 멤버쉽 카드 충전소 결제
	public void updateCardSubtract(Map<String, Object> paramMap) {
		my.update("membership.updateCardSubtract", paramMap);
	}

}
