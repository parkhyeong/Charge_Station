package com.multi.tayotayo.mycard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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

}
