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
    
    public List<JoinVO> filter(JoinVO joinVO) {
        if (joinVO.getEs_gungoo() == null && joinVO.getEs_faciL() == null && joinVO.getEs_dvcS() == null) {
            return null;
        }

        joinVO.setEs_gungoo(emptyToNull(joinVO.getEs_gungoo()));
        joinVO.setEs_faciL(emptyToNull(joinVO.getEs_faciL()));
        joinVO.setEs_dvcS(emptyToNull(joinVO.getEs_dvcS()));

        List<JoinVO> list = dao.filter(joinVO);

        if (list.isEmpty()) {
            return null;
        }

        return list;
    }

    public String emptyToNull(String value) {
        return (value != null && value.equals("")) ? null : value;
    }

    public List<JoinVO> myLocationFindRecommand(JoinVO joinVO) {
        return dao.myLocationFindRecommand(joinVO);
    }
}
