package com.multi.tayotayo.mainpage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DataController {

    @Autowired
    DataService dataService;

    @RequestMapping("/mainpage/insert")
    public void insert(DataVO dataVO){
        dataService.insert(dataVO);
    }
    @RequestMapping("/mainpage/select2")
    @ResponseBody
    public List<JoinVO> selectMainpage() {
        return dataService.select();
    }
    @RequestMapping("/mainpage/selectlist2")
    @ResponseBody
    public List<JoinVO> selectlistMainpage( String es_statNm) {
    	return dataService.selectlist(es_statNm);
    }
}
