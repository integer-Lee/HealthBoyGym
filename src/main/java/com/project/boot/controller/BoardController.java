package com.project.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.project.boot.service.BoardService;
import com.project.boot.service.CommentService;
import com.project.boot.vo.BoardVO;
import com.project.boot.vo.CommentVO;


@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	// 게시판 목록 페이징	
	@RequestMapping(value="/board/boardList.do")
	public String getBoardPageList(BoardVO board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("컨트롤러_게시판 목록 페이징");
		request.setCharacterEncoding("UTF-8"); // 한글로 읽고싶을 떄 해당코드 작성
		Map<String, Object> boardList = boardService.getBoardPageList(board);
		
		System.out.println("컨트롤러_게시판목록페이징 : " + boardList);
		
		request.setAttribute("result", boardList);
		
		return "/board/boardList";
	}
	
	
	// 게시판 상세페이지	
		@ResponseBody
		@RequestMapping(value = "/board/boardView.do", method = RequestMethod.POST)
		public Map<String, Object> boardView(@RequestBody BoardVO board, HttpServletRequest request, HttpServletResponse response) throws Exception {
			System.out.println("게시판 상세페이지 컨트롤러");
			Map<String, Object> map = new HashMap<String, Object>();
			
			int boardId = board.getBoardId();
			boardService.hitUpdate(boardId);
			BoardVO boardVO =  boardService.getBoard(boardId);
			
			List<CommentVO> listComment = commentService.commentList(boardId);
			System.out.println("컨트롤러 listComment : " + listComment);
			map.put("status", true);
			
			// 게시판 상세보기 시 댓글 list도 뽑아온다.
			map.put("board", boardVO); 
			map.put("listComment", listComment); 
			
			return map;
		}
		
		// 게시판 게시글 작성
		@ResponseBody
		@RequestMapping(value = "/board/insert.do")
		public Map<String, Object> insertForm(@RequestBody BoardVO board, HttpServletRequest request, HttpServletResponse response ) throws Exception {
	    	System.out.println("일반 게시판 컨트롤러 게시글 작성 : " + board);
			Map<String, Object> map = boardService.insertBoard(board);
			return map;
		}

		// 답글 등록
		@ResponseBody
		@RequestMapping(value = "/board/replyBoard", method = RequestMethod.POST)
		public Map<String, Object> registerReflyBoarduser(@RequestBody BoardVO board, HttpServletRequest req, HttpServletResponse res) throws Exception {
			System.out.println("board 답글 컨트롤러 진입");
			Map<String, Object> result = boardService.insertBoardReply(board);
			return result;
		}

	
		// 게시판 게시글 수정
		@ResponseBody
		@RequestMapping(value = "/board/update.do")
		public Map<String, Object> updateForm(@RequestBody BoardVO board, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	System.out.println("updateForm() ");
	    	Map<String, Object> map = new HashMap<String, Object>();
	    	//공지사항 상세페이지의 데이터를 DB에서 가져온다. 
	    	map = boardService.updateBoard(board);
	    	// 가져온 데이터를 키값 : notice라는 이름으로 설정해서 jsp로 보내준다.   	
	    	map.put("board", board);
	    	
			return map;
		}
		// 게시판 게시글 삭제	
		@ResponseBody
		@RequestMapping(value = "/board/delete.do")
		public Map<String, Object> noticeDelete(@RequestBody BoardVO board, HttpServletRequest req, HttpServletResponse res) throws Exception {
	    	System.out.println("게시판 게시글 컨트롤러 삭제 호출");
	    	Map<String, Object> map = new HashMap<String, Object>();
			
	    	map = boardService.deleteBoard(board);
	    	
			return map;
		}
		
}
