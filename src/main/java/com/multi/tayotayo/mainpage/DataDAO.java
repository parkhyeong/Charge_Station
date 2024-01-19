package com.multi.tayotayo.mainpage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DataDAO {
 
    @Autowired
    SqlSessionTemplate my;

    public void insert(DataVO dataVO) {
        try {
            my.insert("data.insert", dataVO);        
        } catch (Exception e) {
            System.out.println(dataVO.getStat() + "에서 예외발생");
        }
    }
    
    public List<JoinVO> select() {
        return my.selectList("data.select");
    }

    public List<JoinVO> selectlist(String es_statNm) {
        return my.selectList("data.selectlist", es_statNm);
    }

	 // 내 주변 추천 목록 검색
	 	public List<JoinVO> myLocationFindRecommand(JoinVO joinVO) {
	 		return my.selectList("data.myLocationFindRecommand", joinVO);
	 	}
}
