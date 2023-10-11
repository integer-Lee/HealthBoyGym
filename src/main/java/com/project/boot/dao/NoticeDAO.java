package com.project.boot.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.boot.vo.NoticeVO;

@Mapper
public interface NoticeDAO {
	// 선택된 게시판에 따른 목록불러오기
//	public List<NoticeVO> getTop5NoticeList();
	
	//게시판 글 목록 전체보기 
//	public List<NoticeVO> getNoticeList();
	
	// 조회수 증가하기	
	public void hitUpdate(int noticeId);
	
	//게시판 글 삽입 : C
	public int insertNotice(NoticeVO notice);
	
	//게시판 글 상세보기 : R
	public NoticeVO getNotice(int noticeId);
	
	//게시판 글 수정하기 : U
	public int updateNotice(NoticeVO notice);
	
	//게시판 글 삭제하기 : D
	public int deleteNotice(int noticeId);

	//공지사항 게시판 선택된 체크박스 게시글 삭제하기 
	public void deleteNotices(String noticeIds[]);
	
	// 페이징 : 검색된 전체 건수를 얻는다.
	public int getTotalCount(NoticeVO notice);

	// 페이징 : 게시판 글 목록 전체보기 	
	public List<NoticeVO> getNoticeList(NoticeVO notice);

}
