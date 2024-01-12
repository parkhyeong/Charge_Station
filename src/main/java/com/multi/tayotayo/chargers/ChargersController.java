package com.multi.tayotayo.chargers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.tayotayo.mainpage.MainpageVO;

@Controller
public class ChargersController {

	@Autowired
	private ChargersService chargersService;

	@Autowired
	ChargersDAO chargersdao;

	/*
	 * @GetMapping("select") public List<ChargersVO> selectChargers() { return
	 * ChargersService.select(); }
	 */


	// 전체 충전소 list get
//	@RequestMapping("chargers/select_all")
//	public void select_all(Model model) {// 전체 리스트
//		List<ChargersVO> list = chargersdao.select_all();
//		System.out.println(list.size());
//
//		model.addAttribute("select_all", list);
//	}

	// 전체 충전소 list paging
	@RequestMapping("chargers/select_all_p")
	public String select_all_p(PageVO pageVO, Model model) {// 전체 리스트
		pageVO.setStartEnd();// page, start, end get

		int count = chargersdao.count();
		int pages = count / 20;
		if (count % 20 != 0) {
			pages += 1;
		}

		List<ChargersVO> list = chargersdao.select_all_p(pageVO);
		System.out.println(list.size());

		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		model.addAttribute("select_all", list);

		return "chargers/select_all"; // views/chargers/select_all.jsp
	}
	
	//필터링 검색
	@RequestMapping("")
	public void selectWithFilters(ChargersVO chargersVO, Model model) {
		
	
	}

	//키워드 검색
		@RequestMapping("selectlist")
		public List<ChargersVO> selectlistChargers(String es_statNm) {
			List<ChargersVO> list = chargersService.selectlist(es_statNm);
			return list;

		}
	
//	현준님 코드
	@RequestMapping("chargers/details")
	public void details(ChargersVO chargersVo, Model model) {
		model.addAttribute("chargersVo", chargersVo);
	}
}
