package com.project.boot.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.boot.service.NoticeService;
import com.project.boot.vo.NoticeVO;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	// 페이징적용 X 공지사항 목록	
	/* @RequestMapping(value="/notice/noticeList.do") */
//	public String noticeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		System.out.println("noticeList()");
//		request.setCharacterEncoding("UTF-8"); // 한글로 읽고싶을 떄 해당코드 작성
//		HttpSession session = request.getSession();
//		List<NoticeVO> noitceList = noticeService.getNoticeList();
//		MemberVO loginMember = (MemberVO) session.getAttribute("LoginMember");
// 
//		request.setAttribute("noitceList", noitceList);
//		request.setAttribute("LoginMember", loginMember);
//
//		return "/notice/noticeList";
//	}

	// 공지사항 목록 페이징	
	@RequestMapping(value="/notice/noticeList.do")
	public String getNoticePageList(NoticeVO notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("컨트롤러_공지사항 목록 페이징");
		request.setCharacterEncoding("UTF-8"); // 한글로 읽고싶을 떄 해당코드 작성
		Map<String, Object> noitceList = noticeService.getNoticePageList(notice);
		
		System.out.println("컨트롤러_공지사항목록페이징 : " + noitceList);
		
		request.setAttribute("result", noitceList);
		
		return "/notice/noticeList";
	}

	// 공지사항 상세페이지	
	@ResponseBody
	@RequestMapping(value = "/notice/noticeView.do", method = RequestMethod.POST)
	public Map<String, Object> noticeView(@RequestBody NoticeVO notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("공지사항 상세페이지 컨트롤러" );
		int noticeId = notice.getNoticeId();
		noticeService.hitUpdate(noticeId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", true);
		map.put("notice", noticeService.getNotice(noticeId)); 
		return map;
	}
	
	// 공지사항 게시글 작성
	@ResponseBody
	@RequestMapping(value = "/notice/insert.do")
	public Map<String, Object> insertForm(@RequestBody NoticeVO notice, HttpServletRequest request, HttpServletResponse response ) throws Exception {
    	System.out.println("컨트롤러 삽입성공 : " + notice);
		Map<String, Object> map = noticeService.insertNotice(notice);
		return map;
	}

	// 공지사항 게시글 수정
	@ResponseBody
	@RequestMapping(value = "/notice/update.do")
	public Map<String, Object> updateForm(@RequestBody NoticeVO notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	System.out.println("updateForm() ");
    	Map<String, Object> map = new HashMap<String, Object>();
    	//공지사항 상세페이지의 데이터를 DB에서 가져온다. 
    	map = noticeService.updateNotice(notice);
    	// 가져온 데이터를 키값 : notice라는 이름으로 설정해서 jsp로 보내준다.   	
    	map.put("notice", notice);
    	
		return map;
	}
	
	// 게시글 삭제	
	@ResponseBody
	@RequestMapping(value = "/notice/delete.do")
	public Map<String, Object> noticeDelete(@RequestBody NoticeVO notice, HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("공지사항 컨트롤러 삭제 호출");
    	Map<String, Object> map = new HashMap<String, Object>();
		
    	map = noticeService.deleteNotice(notice.getNoticeId());
    	
		return map;
	}
}
