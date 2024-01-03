package com.multi.tayotayo.mainpage;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository 
public class MainpageDAO {

    @Autowired
    SqlSessionTemplate my;

    public List<MainpageVO> select() {
        return my.selectList("mainpage.select"); 
    }
}