package com.multi.tayotayo.mycard;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mycard")
public class MembershipController {

	@Autowired
	private MembershipService membershipService;

	@PostMapping("/saveMembershipData")
	@ResponseBody
	public String saveMembershipData(HttpSession session, @RequestParam("car_kind") String car_kind,
			@RequestParam("car_model") String car_model, @RequestParam("car_number") String car_number,
			@RequestParam("card_reason") String card_reason, @RequestParam("ship_zip_code") String shipZipCode,
			@RequestParam("ship_addr_1") String shipAddr1, @RequestParam("ship_addr_2") String shipAddr2) {
		try {
			String c_memberid = (String) session.getAttribute("member_id");
			MembershipVO membership = new MembershipVO();
			membership.setC_memberid(c_memberid);
			membership.setCar_kind(car_kind);
			membership.setCar_model(car_model);
			membership.setCar_number(car_number);
			membership.setCard_reason(card_reason);
			membership.setCard_addr(shipZipCode + " " + shipAddr1 + " " + shipAddr2);

			String cardNumber = generateRandomCardNumber();
			membership.setCard_num(cardNumber);

			membershipService.saveMembershipData(membership);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 랜덤 카드 번호 생성
	private String generateRandomCardNumber() {
		String prefix = "TAYOTAYO";
		String suffix = "2024";
		String randomNumbers = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);

		return prefix + randomNumbers + suffix;
	}

	// 멤버쉽 카드 전체 리스트 불러오기
	@RequestMapping("getMembershipList")
	@ResponseBody
	public List<MembershipVO> getMembershipList(HttpSession session) {
		try {
			String c_memberid = (String) session.getAttribute("member_id");
			List<MembershipVO> membershipList = membershipService.getMembershipList(c_memberid);
			return membershipList;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	// 멤버쉽 카드 상세 정보 리스트
	@RequestMapping("getMembershipCardDetails")
	@ResponseBody
	public MembershipVO getMembershipCardDetails(@RequestParam("cardNum") String cardNum) {
		try {
			MembershipVO cardDetails = membershipService.getMembershipCardDetails(cardNum);
			return cardDetails;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 멤버쉽 카드 충전
	@RequestMapping("updateCardNewBalance")
	@ResponseBody
	public String updateCardNewBalance(@RequestParam("cardNum") String cardNum,
			@RequestParam("newBalance") int newBalance, @RequestParam("newPoint") int newPoint) {
		try {
			membershipService.updateCardNewBalance(cardNum, newBalance, newPoint);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 멤버십 카드 리스트 조회 (이용내역 조회용)
	@RequestMapping("getMembershipCardListForBillSearch")
	@ResponseBody
	public List<MembershipVO> getMembershipCardListForBillSearch(HttpSession session) {
		try {
			String c_memberid = (String) session.getAttribute("member_id");

			List<MembershipVO> membershipCardList = membershipService.getMembershipCardListForBillSearch(c_memberid);
			return membershipCardList;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
	}

	// 충전소에서 결제
	@PostMapping("/updateCardSubtract")
	@ResponseBody
	public Map<String, String> updateCardSubtract(@RequestParam("cardNum") String cardNum,
			@RequestParam("chargeAmountInput") int chargeAmountInput, @RequestParam("pointInput") int pointInput,
			@RequestParam("chargingTime") double chargingTime, @RequestParam("chargingAmount") float chargingAmount,
			@RequestParam("statId") String statId) {
		Map<String, String> result = new HashMap<>();
		try {
			membershipService.updateCardSubtract(cardNum, chargeAmountInput, pointInput, chargingTime, chargingAmount,
					statId);

			result.put("status", "success");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "error");
		}
		return result;
	}

	// 멤버십 카드 불러오기(결제)
	@RequestMapping("getMembershipCardInfo")
	@ResponseBody
	public MembershipVO getMembershipCardInfo(@RequestParam("cardNum") String cardNum) {
		try {
			MembershipVO cardInfo = membershipService.getMembershipCardInfo(cardNum);
			return cardInfo;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
