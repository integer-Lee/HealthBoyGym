package com.project.boot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.boot.dao.CommentDAO;
import com.project.boot.vo.CommentVO;

@Service
public class CommentService {
	@Autowired
	public CommentDAO commentDAO;
	
	// 댓글 상세보기
	public List<CommentVO> commentList(int boardId) throws Exception {
		System.out.println("댓글 서비스");
		// 해당 게시글의 댓글 조회
		List<CommentVO> commentList = commentDAO.selectAllCommentList(boardId);

		return commentList;
	}

	// 댓글 삽입	
	public Map<String, Object> insertComment(CommentVO commetVO) throws Exception {
		System.out.println("댓글 삽입 서비스");
		Map<String, Object> map = new HashMap<String, Object>();
		int rowCount = commentDAO.insertComment(commetVO);
		
		CommentVO commetVo =commentDAO.selectOneComment(commetVO.getCommentNo());
//		System.out.println(">>>>>>>>>>>>.commentno : " + commetVo.getCommentNo());
		if (rowCount > 0){
			map.put("status", true);
			map.put("message", "댓글이 등록되었습니다.");
			map.put("commetVo", commetVo);	// 댓글삽입 Ajax에서 날짜삽입을 위해 CommentVO를 map으로 보내준다.
		}else {
			map.put("status", false);
			map.put("message", "댓글 작성시 오류가 발생하였습니다.");
		}
		return map;
	}
}
