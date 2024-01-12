package com.multi.tayotayo.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.tayotayo.review.ReviewVO;


@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("notice_list")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int pageSize) throws Exception {
		int totalCount = noticeService.getNoticeTotalCount();

		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		List<NoticeVO> NoticeList = noticeService.getNoticeList(page, pageSize); // 1, 10

		Map<String, Object> result = new HashMap<>();
		result.put("numPages", totalPages);
		result.put("posts", NoticeList);

		return result;
	}
	
	// 게시글 상세페이지
		@RequestMapping("getNoticeDetails")
		@ResponseBody
		private NoticeVO getNoticeDetails(@RequestParam("n_no") int n_no, @RequestParam("n_num") int n_num)
				throws Exception {
			return noticeService.getNoticeDetails(n_no, n_num);
		}

}
