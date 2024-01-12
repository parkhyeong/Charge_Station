package com.multi.tayotayo.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Service
public class ReviewService {
	private ReviewDAO reviewDAO;

	@Autowired
	public ReviewService(ReviewDAO reviewDAO) {
		this.reviewDAO = reviewDAO;
	}

	public List<ReviewVO> getReviewList(int page, int pageSize) throws Exception {
		int start = 1 + (page - 1) * pageSize;
		int end = page * pageSize;

		return reviewDAO.getReviewList(start, end);
	}

	public int insert(ReviewVO reviewVO) throws Exception {
		return reviewDAO.insert(reviewVO);
	}

	public int getReviewTotalCount() throws Exception {
		return reviewDAO.getTotalCount();
	}

	public List<ReviewVO> getSearchList(ReviewVO reviewVO) throws Exception {
		return reviewDAO.selectSearchList(reviewVO);
	}

	public int getSearchTotalCount(ReviewVO reviewVO) throws Exception {
		return reviewDAO.getSearchTotalCount(reviewVO);
	}

	public Map<String, Object> getSearchListWithPagination(int page, int pageSize, ReviewVO reviewVO) throws Exception {
		int start = 1 + (page - 1) * pageSize;
		int end = page * pageSize;

		List<ReviewVO> searchList = reviewDAO.getSearchList(start, end, reviewVO);
		int totalCount = reviewDAO.getSearchTotalCount(reviewVO);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		System.out.println("Search Parameters: " + page + ", " + pageSize + ", " + reviewVO.getType() + ", "
				+ reviewVO.getKeyword());
		System.out.println("Search Result: " + searchList);

		Map<String, Object> result = new HashMap<>();
		result.put("numPages", totalPages);
		result.put("posts", searchList);

		return result;
	}

	public ReviewVO getReviewDetails(int r_no, int r_num) throws Exception {
		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("r_no", r_no);
		paramMap.put("r_num", r_num);
		return reviewDAO.selectReviewDetails(paramMap);
	}

	// 게시물 수정
	public int updateReviewPost(ReviewVO reviewVO) throws Exception {
		return reviewDAO.updateReviewPost(reviewVO);
	}

	// 게시글 삭제
	public int deleteReviewPost(int r_no, int r_num) throws Exception {
		try {

			int result = reviewDAO.deleteReviewPost(r_no, r_num);

			return result > 0 ? 1 : 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("게시물 삭제 중 오류 발생", e);
		}
	}

	// 게시글 + 댓글 삭제

	@RequestMapping("deleteReviewPostWithComments")

	@ResponseBody
	public String

			deleteReviewPostWithComments(@RequestParam("r_no") int r_no, @RequestParam("r_num") int r_num) {
		try {
			int commentResult = reviewDAO.deleteComments(r_num);

			int postResult = deleteReviewPost(r_no, r_num);

			if (commentResult > 0 && postResult > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 댓글 추가
	public int addComment(ReplyVO comment) throws Exception {
		return reviewDAO.addComment(comment);
	}

	// 댓글 가져오기
	public List<ReplyVO> getComments(int rr_ori_bbs) throws Exception {
		return reviewDAO.getComments(rr_ori_bbs);
	}

	// 댓글 삭제
	public int deleteComment(int rr_num) throws Exception {
		return reviewDAO.deleteComment(rr_num);
	}

	// 댓글 삭제
	public int deleteComments(int rr_num) throws Exception {
		return reviewDAO.deleteComments(rr_num);
	}

	// 댓글 수정
	public int updateComment(ReplyVO ReplyVO) throws Exception {
		try {
			int result = reviewDAO.updateComment(ReplyVO);

			return result > 0 ? 1 : 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("댓글 수정 중 오류 발생", e);
		}
	}

	// 댓글 상세 정보
	public ReplyVO getCommentDetails(int rr_num) throws Exception {
		return reviewDAO.getCommentDetails(rr_num);
	}

	// 충전소 상세정보 페이지용
	public List<ReviewVO> getSearchListForChargers(ReviewVO reviewVO) throws Exception {
		return reviewDAO.selectSearchListForChargers(reviewVO);
	}

}
