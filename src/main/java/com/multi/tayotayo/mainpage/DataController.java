package com.multi.tayotayo.mainpage;

import java.util.List;

import com.multi.tayotayo.mainpage.DataVO;
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
    
    @GetMapping("/filter")
    @ResponseBody
    public List<JoinVO> filter(JoinVO joinVO) {
    	return dataService.filter(joinVO);
    }

    
    @RequestMapping("/myLocationFindRecommand")
    @ResponseBody
    public List<JoinVO> myLocationFindRecommand(JoinVO joinVO) {
       return dataService.myLocationFindRecommand(joinVO);
  }
}




