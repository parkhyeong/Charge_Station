package com.multi.tayotayo.mainpage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mainpage") 
public class DataController {

    @Autowired
    DataService dataService;

    @RequestMapping("/insert")
    @ResponseBody
    public void insert(DataVO dataVO) {
        dataService.insert(dataVO);
    }

    @GetMapping("/select2") 
    @ResponseBody
    public List<JoinVO> selectMainpage() {
        return dataService.select();
    }

    @GetMapping("/selectlist2")
    @ResponseBody
    public List<JoinVO> selectlistMainpage(String es_statNm) {
        return dataService.selectlist(es_statNm);
    }

    @RequestMapping("/myLocationFindRecommand")
    @ResponseBody
    public List<JoinVO> myLocationFindRecommand(JoinVO joinVO) {
        List<JoinVO> list = dataService.myLocationFindRecommand(joinVO);

        // 리스트가 비어있는 경우에 대한 처리 추가
        if (!list.isEmpty()) {
            System.out.println(list.get(0));
        } else {
            System.out.println("List is empty");
        }

        System.out.println(list.size());
        return list;
    }
}


