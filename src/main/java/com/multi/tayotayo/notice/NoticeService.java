package com.multi.tayotayo.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.tayotayo.review.ReviewVO;


@Service
public class NoticeService {
	private NoticeDAO noticeDAO;
	
	@Autowired
	public NoticeService(NoticeDAO noticeDAO) {
		this.noticeDAO = noticeDAO;
	}
	
	public List<NoticeVO> getNoticeList(int page, int pageSize) throws Exception {
		int start = 1 + (page - 1) * pageSize;
		int end = page * pageSize;

		return noticeDAO.getNoticeList(start, end);
	}
	
	public int getNoticeTotalCount() throws Exception {
		return noticeDAO.getTotalCount();
	}
	
	public NoticeVO getNoticeDetails(int n_no, int n_num) throws Exception {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("n_no", n_no);
		paramMap.put("n_num", n_num);
		return noticeDAO.getNoticeDetails(paramMap);
	}


}
