package com.project.boot.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.boot.vo.BoardVO;
import com.project.boot.vo.CommentVO;

@Mapper
public interface BoardDAO {
	// 선택된 게시판에 따른 목록불러오기
//	public List<BoardVO> getTop5BoardList();
	
	// 페이징 : 검색된 전체 건수를 얻는다.
	public int getTotalCount(BoardVO board);
	
	// 페이징 : 게시판 글 목록 전체보기 	
	public List<BoardVO> getBoardList(BoardVO board);
	
	// 조회수 증가하기	
	public void hitUpdate(int boardId);
	
	//게시판 글 삽입 : C
	public int insertBoard(BoardVO board);
	
	//게시판 글 상세보기 : R
	public BoardVO getBoard(int boardId);
	
	//게시판 글 수정하기 : U
	public int updateBoard(BoardVO board);
	
	//게시판 글 삭제하기 : D
	public int deleteBoard(int boardId);

	//게시판 선택된 체크박스 게시글 삭제하기 
	public void deleteBoards(String boardIds[]);

	// 게시판 답글삽입 : C 
	int insertBoardReply(BoardVO board);
	
	// 댓글 조회
	public List<CommentVO> selectAllCommentList(int boardId) throws Exception;
}
