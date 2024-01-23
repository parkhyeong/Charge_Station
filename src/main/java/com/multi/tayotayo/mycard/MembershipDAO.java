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

	// 멤버십 카드 불러오기 (결제)
	public MembershipVO getMembershipCardInfo(String cardNum) {
		return my.selectOne("membership.getMembershipCardInfo", cardNum);
	}

	// 환불
	public void refundCard(String cardNum, int paymentAmount, int paymentPoint) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("card_num", cardNum);
		paramMap.put("payment_amount", paymentAmount);
		paramMap.put("payment_point", paymentPoint);

		my.update("membership.refundCard", paramMap);
	}

	// 멤버쉽 카드 존재 여부 확인
	public boolean checkMembershipCardExistence(String c_memberid) {
		try {
			int count = my.selectOne("membership.checkMembershipCardExistence", c_memberid);
			return count > 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("멤버십 카드 존재 여부 확인 중 오류 발생: " + e.getMessage());
		}
	}

}
