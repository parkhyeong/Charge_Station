package com.multi.tayotayo.chargers;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.multi.tayotayo.mainpage.MainpageVO;

@Repository
public class ChargersDAO {

	@Autowired
	SqlSessionTemplate my;

	// 전체 충전소 개수
	public int count() {
		return my.selectOne("chargers.count");
	}

	// 전체 충전소 목록
	public List<ChargersVO> select_all() {
		return my.selectList("chargers.select_all");
	}

	// 전체 충전소 목록 + 페이징
	public List<ChargersVO> select_all_p(PageVO pageVO) {
		return my.selectList("chargers.select_all_p", pageVO);
	}
	
	// 필터링 + 키워드 검색 목록
	public List<ChargersVO> selectWithFilters(ChargersVO chargersVO) {
		return my.selectList("chargers.selectWithFilters", chargersVO);
	}
	
	/*
	 * 키워드 검색
	 * public List<ChargersVO> selectlist(String es_statNm) { return
	 * my.selectList("chargers.selectlist", es_statNm); }
	 */

	
	//현준님 코드
	public ChargersVO selectStation(ChargersVO chargersVo) {
		return my.selectOne("chargers.station", chargersVo);
	}
}
