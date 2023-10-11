package com.project.boot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.boot.dao.BoardDAO;
import com.project.boot.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	public BoardDAO boardDAO;
	
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	
//	public List<BoardVO> getTop5BoardList() {
//		return boardDAO.getTop5BoardList();
//	}
	
	/*
	 게시판 페이지 목록 조회
		 인자(매개변수)1 : 검색키(아직구현안함)
		 인자(매개변수)2 : 페이지 번호
	*/		
	public Map<String, Object> getBoardPageList(BoardVO board) throws Exception{
		// 1. 전체 건수를 얻는다.
		board.setTotalCount(boardDAO.getTotalCount(board));
		System.out.println("서비스_게시물전체 건수 :" + board.getTotalCount());
		System.out.println("서비스_board : " + board);
		List<BoardVO> list = boardDAO.getBoardList(board);
		Map<String, Object> result = new HashMap<>();
		
		result.put("board", board);
		// 페이징에 관련된 목록을 가져온다.
		// 검색에대한 페이지번호도 가지고 있다.	
		result.put("list", list);
		
		return result ;
	}
		
		
	// 게시판 상세보기
	public BoardVO getBoard(int boardId) throws Exception {
		BoardVO board = boardDAO.getBoard(boardId);
		System.out.println("게시판 상세보기 서비스");
		return board;
	}
	
	// 조회수증가
	public void hitUpdate(int boardId) {
		boardDAO.hitUpdate(boardId);
	}
	
	// 게시글 삽입 
	public Map<String, Object> insertBoard(BoardVO board) {
		Map<String, Object> map = new HashMap<String, Object>();
		int rowCount = boardDAO.insertBoard(board);
		System.out.println("게시글 삽입 서비스성공 : " + board);
		if (rowCount > 0){
			map.put("status", true);
			map.put("message", "게시글 글 작성이 등록되었습니다.");
		}else {
			map.put("status", false);
			map.put("message", "게시글 글 작성시 오류가 발생하였습니다.");
		}
		return map;
	}
	
	// 게시글 수정 : U
	public Map<String, Object> updateBoard(BoardVO board) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(">>>>>>서비스>>>>>>>" + board);
		int rowCount = boardDAO.updateBoard(board);
		if (rowCount > 0) {	
			map.put("status", true);
			map.put("message", "게시글이 수정되었습니다.");
		}else {
			map.put("status", false);
			map.put("message", "게시글 수정시 오류가 발생하였습니다.");
		}
		
		return map;
	}

	// 게시글 삭제 : D
	public Map<String, Object> deleteBoard(BoardVO board) {
		System.out.println("게시글 서비스 삭제 호출");
		Map<String, Object> map = new HashMap<String, Object>();
		int rowCount = boardDAO.deleteBoard(board.getBoardId());
		if (rowCount > 0) {
			map.put("status", true);
			map.put("message", "게시글이 삭제되었습니다");
		}else {
			map.put("status", false);
			map.put("message", "게시글 삭제시 오류가 발생하였습니다");
		}
		return map;
	}
	//게시판 답글 삽입 : C
	public Map<String, Object> insertBoardReply(BoardVO board) {
		Map<String, Object> map = new HashMap<String, Object>();
		int rowCount = boardDAO.insertBoardReply(board);
		System.out.println("답글 삽입_서비스성공 : " + board);
		if (rowCount > 0){
			map.put("status", true);
			map.put("message", "답글 작성이 등록되었습니다.");
		}else {
			map.put("status", false);
			map.put("message", " 답글 작성시 오류가 발생하였습니다.");
		}
		return map;
	}
}
