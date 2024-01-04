package com.multi.tayotayo.chargers;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChargersDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	public ChargersVO selectStation(ChargersVO chargersVo) {
		return my.selectOne("chargers.station", chargersVo);
	}
}
