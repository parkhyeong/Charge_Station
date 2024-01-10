package com.multi.tayotayo.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
	@Autowired
	private SqlSessionTemplate my;

	public int insert(ReviewVO reviewVo) {
		return my.insert("review.create", reviewVo);
	}

	public List<ReviewVO> getReviewList(int start, int end) throws Exception {
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		return my.selectList("review.list", params);
	}

	public int getTotalCount() throws Exception {
		return my.selectOne("review.totalCount");
	}

	public int getSearchTotalCount(ReviewVO reviewVo) throws Exception {
		return my.selectOne("review.searchTotalCount", reviewVo);
	}

	public List<ReviewVO> getSearchList(int start, int end, ReviewVO reviewVo) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		params.put("reviewVo", reviewVo);
		return my.selectList("review.searchReviewList", params);
	}

	public int searchTotalCount(ReviewVO reviewVo) throws Exception {
		return my.selectOne("review.searchTotalCount", reviewVo);
	}

	public List<ReviewVO> selectSearchList(ReviewVO reviewVo) throws Exception {
		return my.selectList("review.searchReviewList", reviewVo);
	}

	public ReviewVO selectReviewDetails(Map<String, Integer> paramMap) throws Exception {
		return my.selectOne("review.selectReviewDetails", paramMap);
	}

	public int updateReviewPost(ReviewVO reviewVO) throws Exception {
		return my.update("review.updateReviewPost", reviewVO);
	}

	public int deleteReviewPost(int r_no, int r_num) {
		my.delete("reply.deleteComments", r_num);

		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("r_no", r_no);
		paramMap.put("r_num", r_num);

		return my.delete("review.deleteReviewPost", paramMap);
	}

	// 댓글 삭제
	public int deleteComment(int rr_num) {
		return my.delete("reply.deleteComment", rr_num);
	}

	// 댓글 전체 삭제 
	public int deleteComments(int rr_num) {
		return my.delete("reply.deleteComments", rr_num);
	}

	// 댓글 추가 
	public int addComment(ReplyVO comment) {
		return my.insert("reply.create", comment);
	}

	// 댓글 가져오기 
	public List<ReplyVO> getComments(int rr_ori_bbs) throws Exception {
		return my.selectList("reply.getComments", rr_ori_bbs);
	}

	// 댓글 수정 
	public int updateComment(ReplyVO replyVO) {
		return my.update("reply.updateComment", replyVO);
	}

	// 댓글 상세 정보 
	public ReplyVO getCommentDetails(int rr_num) throws Exception {
		return my.selectOne("reply.getCommentDetails", rr_num);
	}

}
