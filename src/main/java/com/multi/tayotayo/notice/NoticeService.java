package com.multi.tayotayo.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


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

}
