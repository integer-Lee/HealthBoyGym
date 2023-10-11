package com.project.boot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.boot.dao.NoticeDAO;
import com.project.boot.vo.NoticeVO;

@Service
public class NoticeService {
	
	@Autowired
	public NoticeDAO noticeDAO;
	
	public void setNoticeDAO(NoticeDAO noticeDAO) {
		this.noticeDAO = noticeDAO;
	}
	
//	public List<NoticeVO> getTop5NoticeList() {
//		return noticeDAO.getTop5NoticeList();
//	}
	
	// 1. 공지사항 목록	
//	public List<NoticeVO> getNoticeList(){
//		return noticeDAO.getNoticeList();
//	}

	// 2. 공지사항 페이지 목록 조회
	// 인자(매개변수)1 : 검색키(아직구현안함)
	// 인자(매개변수)2 : 페이지 번호		
	public Map<String, Object> getNoticePageList(NoticeVO notice) throws Exception{
		// 1. 전체 건수를 얻는다.
		notice.setTotalCount(noticeDAO.getTotalCount(notice));
		System.out.println("서비스_게시물전체 건수 :" + notice.getTotalCount());
		System.out.println("서비스_notice : " + notice);
		List<NoticeVO> list = noticeDAO.getNoticeList(notice);
		Map<String, Object> result = new HashMap<>();
		
		result.put("notice", notice);
		// 페이징에 관련된 목록을 가져온다.
		// 검색에대한 페이지번호도 가지고 있다.	
		result.put("list", list);
		
		return result ;
	}
	
	public Map<String, Object> insertNotice(NoticeVO notice) {
		Map<String, Object> map = new HashMap<String, Object>();
		int rowCount = noticeDAO.insertNotice(notice);
		System.out.println("서비스 삽입성공 : " + notice);
		if (rowCount > 0){
			map.put("status", true);
			map.put("message", "공지사항 글 작성이 등록되었습니다.");
		}else {
			map.put("status", false);
			map.put("message", "공지사항 글 작성시 오류가 발생하였습니다.");
		}
		return map;
	}
	
//	공지사항 게시글 상세보기메서드
	public NoticeVO getNotice(int noticeId) {
		NoticeVO notice = noticeDAO.getNotice(noticeId);
		return notice;
	}
	
	public Map<String, Object> updateNotice(NoticeVO notice) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(">>>>>>서비스>>>>>>>" + notice);
		int rowCount = noticeDAO.updateNotice(notice);
		if (rowCount > 0) {	
			map.put("status", true);
			map.put("message", "공지사항 글 수정되었습니다.");
		}else {
			map.put("status", false);
			map.put("message", "공지사항 글 수정시 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	public Map<String, Object> deleteNotice(int noticeId) {
		System.out.println("공지사항 서비스 삭제 호출");
		Map<String, Object> map = new HashMap<String, Object>();
		int rowCount = noticeDAO.deleteNotice(noticeId);
		if (rowCount > 0) {
			map.put("status", true);
			map.put("message", "공지사항 글이 삭제되었습니다");
		}else {
			map.put("status", false);
			map.put("message", "공지사항 글 삭제시 오류가 발생하였습니다");
		}
		return map;
	}
	
	// 공지사항 게시판에서 체크박스로 선택된 게시글을 삭제한다.
	public void deleteNotices(String [] noticeIds) {
		noticeDAO.deleteNotices(noticeIds);
	}
	
	// 조회수증가
	public void hitUpdate(int noticeId) {
		noticeDAO.hitUpdate(noticeId);
	}
}
