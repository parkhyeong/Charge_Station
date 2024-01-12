package com.multi.tayotayo.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.multi.tayotayo.review.ReviewVO;

@Repository
public class NoticeDAO {
	
	@Autowired
	private SqlSessionTemplate my;
	
	public List<NoticeVO> getNoticeList(int start, int end) throws Exception {
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		return my.selectList("notice.list", params);
	}

	public int getTotalCount() throws Exception {
		return my.selectOne("notice.totalCount");
	}
	
	public NoticeVO getNoticeDetails(Map<String, Integer> paramMap) throws Exception {
		return my.selectOne("notice.selectNoticeDetails", paramMap);
	}

}
