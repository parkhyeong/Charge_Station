package com.multi.tayotayo.mainpage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DataService {

    @Autowired
    DataDAO dao;

    public void insert(DataVO dataVo) {
         dao.insert(dataVo);
    }
    
    public List<JoinVO> select() {
        return dao.select();
    }

    public List<JoinVO> selectlist(String es_statNm) {
        return dao.selectlist(es_statNm);
    }
}