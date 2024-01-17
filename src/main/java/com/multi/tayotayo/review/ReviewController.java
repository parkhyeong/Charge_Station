package com.multi.tayotayo.review;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;

	@PostMapping("/review_list")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int pageSize) throws Exception {
		int totalCount = reviewService.getReviewTotalCount();

		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		List<ReviewVO> ReviewList = reviewService.getReviewList(page, pageSize); // 1, 10

		Map<String, Object> result = new HashMap<>();
		result.put("numPages", totalPages);
		result.put("posts", ReviewList);

		return result;
	}

	// 게시글 메인에서 검색하기
	@RequestMapping("getSearchList")
	@ResponseBody
	private Map<String, Object> getSearchList(@RequestParam("page") int page, @RequestParam("pageSize") int pageSize,
			@RequestParam("type") String type, @RequestParam("keyword") String keyword) throws Exception {
		ReviewVO reviewVO = new ReviewVO();
		reviewVO.setType(type);
		reviewVO.setKeyword(keyword);

		int totalCount = reviewService.getSearchTotalCount(reviewVO);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		if (page > totalPages) {
			page = totalPages;
		}

		Map<String, Object> result = reviewService.getSearchListWithPagination(page, pageSize, reviewVO);
		result.put("numPages", totalPages);

		return result;
	}

	// 게시글 작성하기
	@RequestMapping("review_board_insert")
	public String insert(HttpServletRequest request, MultipartFile file, ReviewVO reviewVO, Model model) {
		System.out.println("insert 호출!");
		try {
			String sessionUserId = (String) request.getSession().getAttribute("member_id");
			String sessionStatId = (String) request.getSession().getAttribute("es_statId");
			String sessionStatNm = (String) request.getSession().getAttribute("es_statNm");

			model.addAttribute("sessionUserId", sessionUserId);
			model.addAttribute("sessionStatId", sessionStatId);
			model.addAttribute("sessionStatNm", sessionStatNm);
			
			// 사진 첨부
			if (file != null && !file.isEmpty()) {
				String savedName = file.getOriginalFilename();
				String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
				System.out.println(uploadPath + "/" + savedName);

				File target = new File(uploadPath + "/" + savedName);

				file.transferTo(target);
				reviewVO.setR_photo(savedName);
			} else {
				reviewVO.setR_photo("");
			}

			reviewVO.setR_statid(sessionStatId);
			reviewVO.setR_statNm(sessionStatNm);

			int result = reviewService.insert(reviewVO);
			if (result > 0) {
				model.addAttribute("result", "게시글이 성공적으로 작성되었습니다.");
			} else {
				model.addAttribute("result", "게시글 작성에 실패했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("result", "에러가 발생했습니다.");
		}

		return "redirect:initReviewBoard.jsp";
	}

	// 게시글 상세페이지
	@RequestMapping("getReviewDetails")
	@ResponseBody
	private ReviewVO getReviewDetails(@RequestParam("r_no") int r_no, @RequestParam("r_num") int r_num)
			throws Exception {
		ReviewVO reviewDetails = reviewService.getReviewDetails(r_no, r_num);
		if (reviewDetails.getR_photo() != null && !reviewDetails.getR_photo().isEmpty()) {
			reviewDetails.setR_photo("/tayotayo/resources/upload/" + reviewDetails.getR_photo());
		} else {
			reviewDetails.setR_photo(""); 
		}

		return reviewDetails;
	}

	// 게시글 수정

	@RequestMapping("updateReviewPost")
	@ResponseBody
	private String updateReviewPost(@RequestParam("r_no") int r_no, @RequestParam("r_title") String r_title,

			@RequestParam("r_content") String r_content, @RequestParam("r_num") int r_num,
			@RequestParam("r_rank") int r_rank) {
		try {
			ReviewVO existingPost = reviewService.getReviewDetails(r_no, r_num);

			existingPost.setR_title(r_title);
			existingPost.setR_content(r_content);
			existingPost.setR_rank(r_rank);

			int result = reviewService.updateReviewPost(existingPost);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 게시글 + 게시글 댓글 삭제

	@RequestMapping("deleteReviewPostWithComments")

	@ResponseBody
	public String deleteReviewPostWithComments(@RequestParam("r_no") int r_no, @RequestParam("r_num") int r_num) {
		try {
			reviewService.deleteComments(r_num);

			int result = reviewService.deleteReviewPost(r_no, r_num);

			if (result > 0) {
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

	@RequestMapping("addComment")

	@ResponseBody
	private String addComment(@RequestParam("rr_ori_review") int rr_ori_review,

			@RequestParam("rr_content") String rr_content,
			@RequestParam("rr_writer") String rr_writer) {
		try {
			ReplyVO comment = new ReplyVO();
			comment.setRr_ori_review(rr_ori_review);
			comment.setRr_content(rr_content);
			comment.setRr_writer(rr_writer);

			int result = reviewService.addComment(comment);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 댓글 가져오기

	@RequestMapping("getComments")

	@ResponseBody
	private List<ReplyVO> getComments(@RequestParam("rr_ori_review") int rr_ori_review) throws Exception {
		return reviewService.getComments(rr_ori_review);
	}

	// 댓글 수정

	@RequestMapping("updateComment")

	@ResponseBody
	private String updateComment(@RequestParam("rr_num") int rr_num, @RequestParam("rr_content") String rr_content) {
		try {
			ReplyVO existingComment = reviewService.getCommentDetails(rr_num);

			if (existingComment != null) {
				existingComment.setRr_content(rr_content);

				int result = reviewService.updateComment(existingComment);

				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 댓글 삭제

	@RequestMapping("deleteComment")

	@ResponseBody
	private String deleteComment(@RequestParam("rr_num") int rr_num) {
		try {
			int result = reviewService.deleteComment(rr_num);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 좋아요 처리
	@PostMapping("/likeReviewPost")
	@ResponseBody
	public String likeReviewPost(@RequestParam("r_no") int r_no, @RequestParam("r_num") int r_num) {
		try {
			int result = reviewService.likeReviewPost(r_no, r_num);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 좋아요 수 가져오기
	@RequestMapping("getLikeCount")
	@ResponseBody
	public int getLikeCount(@RequestParam("r_no") int r_no, @RequestParam("r_num") int r_num) {
		try {
			return reviewService.getLikeCount(r_no, r_num);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	// 충전소 리뷰 계산
		@RequestMapping("selectAvg")
		@ResponseBody
		public double selectSearchChargeIdAvg(@RequestParam("r_statId") String r_statId) {
			return reviewService.selectSearchChargeIdAvg(r_statId);
		}

}
