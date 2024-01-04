package com.multi.tayotayo.chargers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChargersService {
	
	@Autowired
	ChargersDAO chargersDao;
	
	public ChargersVO selectStation(ChargersVO chargersVo) {
		return chargersDao.selectStation(chargersVo);
	}
}
