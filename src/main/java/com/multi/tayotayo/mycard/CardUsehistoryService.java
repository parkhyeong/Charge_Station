package com.multi.tayotayo.mycard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.multi.tayotayo.review.ReviewDAO;

@Service
public class CardUsehistoryService {

	@Autowired
	private CardUsehistoryDAO cardusehistoryDAO;
	private MembershipDAO membershipDAO;
	private PointDAO pointDAO;
	private ReviewDAO reviewDAO;
	
	public CardUsehistoryService(CardUsehistoryDAO cardusehistoryDAO, MembershipDAO membershipDAO, PointDAO pointDAO,
			ReviewDAO reviewDAO) {
		this.cardusehistoryDAO = cardusehistoryDAO;
		this.membershipDAO = membershipDAO;
		this.pointDAO = pointDAO;
		this.reviewDAO = reviewDAO;
	}

	public List<CardUsehistoryVO> getCardInformationList(String card_num) {
		return cardusehistoryDAO.getCardInformationList(card_num);
	}

	public List<PointVO> getUsePointCardInformation(String card_num) {
		return cardusehistoryDAO.getUsePointCardInformation(card_num);
	}

	public void refundCard(String card_num, Long transactionId, int payment_amount, int payment_point) {
		cardusehistoryDAO.refundCard(card_num, transactionId);
		membershipDAO.refundCard(card_num, payment_amount, payment_point);
		pointDAO.refundCard(card_num);
	}

	public void insertPaymentReview(String r_writer, String selectedCardNum, String transactionId, String r_statNm,
			String chargeTime, String chargeAmount, String paymentAmount, String paymentPoint) {
		reviewDAO.insertPaymentReview(r_writer, selectedCardNum, transactionId, r_statNm, chargeTime, chargeAmount, paymentAmount,
				paymentPoint);
	}
}
