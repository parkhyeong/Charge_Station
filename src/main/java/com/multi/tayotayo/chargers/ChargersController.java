package com.multi.tayotayo.chargers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChargersController {

	@Autowired
	ChargersService chargersService;
	
	@RequestMapping("chargers/details")
	public void details(ChargersVO chargersVo, Model model) {
		ChargersVO stationInfo = chargersService.selectStation(chargersVo);
		
		System.out.println(stationInfo);
		
		model.addAttribute("stationInfo", stationInfo);
	}
}
