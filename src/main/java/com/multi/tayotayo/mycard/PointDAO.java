package com.multi.tayotayo.mycard;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAO {

	@Autowired
	private SqlSessionTemplate my;

	public void insertPoint(Map<String, Object> paramMap) {
		my.selectList("point.insertpoint", paramMap);
	}
	
	public void refundCard(String card_num) {
		my.insert("point.refundCard", card_num);
	}

}