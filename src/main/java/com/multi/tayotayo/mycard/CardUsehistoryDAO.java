package com.multi.tayotayo.mycard;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CardUsehistoryDAO {

	@Autowired
	private SqlSessionTemplate my;

	public List<CardUsehistoryVO> getCardInformationList(String card_num) {
		return my.selectList("cardusehistory.getCardInformationList", card_num);
	}

	public List<PointVO> getUsePointCardInformation(String card_num) {
		return my.selectList("cardusehistory.getUsePointCardInformation", card_num);
	}

	public void processPayment(Map<String, Object> paramMap) {
        my.insert("cardusehistory.processPayment", paramMap);
    }
}
