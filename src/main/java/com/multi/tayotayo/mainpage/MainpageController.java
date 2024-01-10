package com.multi.tayotayo.mainpage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("mainpage")
public class MainpageController {

    @Autowired
    private MainpageService mainpageService;

    @GetMapping("select")
    public List<MainpageVO> selectMainpage() {
        return mainpageService.select();
    }
    @GetMapping("selectlist")
    public List<MainpageVO> selectlistMainpage( String es_statNm) {
    	return mainpageService.selectlist(es_statNm);
    	
    }
}