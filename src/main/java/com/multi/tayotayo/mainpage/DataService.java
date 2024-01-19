package com.multi.tayotayo.mainpage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DataService {

    @Autowired
    DataDAO dao;

    public void insert(DataVO dataVO) {
         dao.insert(dataVO);
    }
    
    public List<JoinVO> select() {
        return dao.select();
    }

    public List<JoinVO> selectlist(String es_statNm) {
        return dao.selectlist(es_statNm);
    }
    
 // 내 주변 검색
 	public List<JoinVO> myLocationFindRecommand(JoinVO joinVO) {
 		return dao.myLocationFindRecommand(joinVO);
 	} 
}
