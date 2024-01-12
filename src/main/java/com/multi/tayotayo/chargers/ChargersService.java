package com.multi.tayotayo.chargers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChargersService {

	@Autowired
	private ChargersDAO chargersDao;
	
	// 필터링 검색 목록
	public List<ChargersVO> selectWithFilters(ChargersVO chargersVO) {
        return chargersDao.selectWithFilters(chargersVO);
    }


	public List<ChargersVO> selectlist(String es_statNm) {
		return chargersDao.selectlist(es_statNm);
	}

	public ChargersVO selectStation(ChargersVO chargersVo) {
		return chargersDao.selectStation(chargersVo);
	}
}
