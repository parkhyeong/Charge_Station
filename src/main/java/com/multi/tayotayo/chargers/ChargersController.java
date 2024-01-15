package com.multi.tayotayo.chargers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.tayotayo.mainpage.MainpageVO;
import com.multi.tayotayo.review.ReviewService;
import com.multi.tayotayo.review.ReviewVO;

@Controller
public class ChargersController {

	@Autowired
	ChargersService chargersService;
	
	@Autowired
	ReviewService reviewService;

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
	
	
	@RequestMapping("chargers/getSearchListForChargers")
	@ResponseBody
	public Map<String, Object> getReviews(@RequestParam("type") String type, @RequestParam("r_statId") String r_statId) throws Exception {
		ReviewVO reviewVO = new ReviewVO();
		reviewVO.setType(type);
		reviewVO.setR_statid(r_statId);
		
		
		System.out.println("리뷰 에러 체크 : 컨트롤러 단계 실행");
		List<ReviewVO> list = reviewService.getSearchListForChargers(reviewVO);
		System.out.println("리뷰 에러 체크 : 컨트롤러 단계 실행2");
		System.out.println(list);
		
		Map<String, Object> result = new HashMap<>();
		result.put("reviewList", list);

		return result;
	}
}
