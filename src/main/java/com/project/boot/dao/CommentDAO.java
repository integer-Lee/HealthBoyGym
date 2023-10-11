package com.project.boot.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.boot.vo.CommentVO;

@Mapper
public interface CommentDAO {

	// boardId에 존재하는 모든 댓글 조회 
	List<CommentVO> selectAllCommentList(int boardId) throws Exception;

	// 댓글 1개에 대한 data 조회
	CommentVO selectOneComment(int commentNo) throws Exception;
	
	// 댓글 삽입 : C	
	int insertComment(CommentVO commetVO);

}
