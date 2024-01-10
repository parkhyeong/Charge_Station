package com.multi.tayotayo.mycard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardUsehistoryService {
	
	@Autowired
	private CardUsehistoryDAO cardusehistoryDAO;

	public CardUsehistoryService(CardUsehistoryDAO cardusehistoryDAO) {
		this.cardusehistoryDAO = cardusehistoryDAO;
	}

	public List<CardUsehistoryVO> getCardInformationList(String card_num) {
        return cardusehistoryDAO.getCardInformationList(card_num);
    }
	
	public List<PointVO> getUsePointCardInformation(String card_num) {
		return cardusehistoryDAO.getUsePointCardInformation(card_num);
	}
}
