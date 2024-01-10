// MainpageService.java

package com.multi.tayotayo.mainpage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainpageService {

    @Autowired
    private MainpageDAO dao;

    public List<MainpageVO> select() {
        return dao.select();
    }

    public List<MainpageVO> selectlist(String es_statNm) {
        return dao.selectlist(es_statNm);
    }
}
