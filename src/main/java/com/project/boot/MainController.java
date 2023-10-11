package com.project.boot;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.project.boot.service.BoardService;
import com.project.boot.service.NoticeService;
import com.project.boot.vo.BoardVO;
import com.project.boot.vo.MemberVO;
import com.project.boot.vo.NoticeVO;



@Controller
public class MainController {
	
//	@Autowired
//	private NoticeService noticeService;
	
//	@Autowired
//	private BoardService boardService;
	
	// 메인페이지 이동
	@RequestMapping("/")
	public String main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("LoginMember");
//		List<NoticeVO> noticeList = noticeService.getTop5NoticeList(); 
//		List<BoardVO> boardList = boardService.getTop5BoardList();
		request.setAttribute("LoginMember", loginMember);
//		request.setAttribute("noticeList", noticeList);
//		request.setAttribute("boardList", boardList);
		return "main";
	}
}