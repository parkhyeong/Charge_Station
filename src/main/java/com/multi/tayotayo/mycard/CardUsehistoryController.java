package com.multi.tayotayo.mycard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mycard")
public class CardUsehistoryController {

	@Autowired
	private CardUsehistoryService cardusehistoryService;

	@ResponseBody
	@RequestMapping("/getUseCardInformation")
	public List<CardUsehistoryVO> getUseCardInformation(@RequestParam(name = "card_num") String card_num, Model model) {
		System.out.println("Received request for card_num: " + card_num);

		List<CardUsehistoryVO> cardusehistoryList = cardusehistoryService.getCardInformationList(card_num);

		return cardusehistoryList;
	}

	@ResponseBody
	@RequestMapping("/getUsePointCardInformation")
	public List<PointVO> getUsePointCardInformation(@RequestParam(name = "card_num") String card_num, Model model) {
		System.out.println("Received request for card_num: " + card_num);

		List<PointVO> pointList = cardusehistoryService.getUsePointCardInformation(card_num);

		return pointList;
	}

	@ResponseBody
	@RequestMapping(value = "/refundEndpoint", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, String> refundEndpoint(@RequestParam(name = "card_num") String card_num,
			@RequestParam(name = "transactionId") Long transactionId,
			@RequestParam(name = "payment_amount") int payment_amount,
			@RequestParam(name = "payment_point") int payment_point) {
		System.out.println("환불 카드 번호 : " + card_num);

		Map<String, String> response = new HashMap<>();

		try {
			cardusehistoryService.refundCard(card_num, transactionId, payment_amount, payment_point);
			response.put("status", "success");
			response.put("message", "환불이 성공적으로 처리되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("status", "error");
			response.put("message", "환불 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
		}

		return response;
	}
	
	@ResponseBody
	@RequestMapping(value = "/PaymentReviewInsert", method = { RequestMethod.GET, RequestMethod.POST })
    public Map<String, Object> PaymentReviewInsert(@RequestParam("selectedCardNum") String selectedCardNum,
                                                   @RequestParam("transactionId") String transactionId,
                                                   @RequestParam("stationName") String r_statid,
                                                   @RequestParam("chargeTime") String chargeTime,
                                                   @RequestParam("chargeAmount") String chargeAmount,
                                                   @RequestParam("paymentAmount") String paymentAmount,
                                                   @RequestParam("paymentPoint") String paymentPoint,
                                                   HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
        	HttpSession session = request.getSession();
            String r_writer = (String) session.getAttribute("member_id");
        	cardusehistoryService.insertPaymentReview(r_writer, selectedCardNum, transactionId, r_statid, chargeTime, chargeAmount, paymentAmount, paymentPoint);
            response.put("status", "success");
            response.put("message", "Review successfully inserted.");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Failed to insert review.");
        }
        return response;
    }

}
