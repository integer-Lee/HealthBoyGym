package com.project.boot.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CommentVO {
	private int commentNo;		// 댓글 번호: 기본키, 시퀀스로 생성
	private String comments; 	// 댓글내용
	private String regDate;		// 댓글 생성 날짜
	private String userId;		// 댓글 작성자 ID = 로그인ID
	private int boardId;		// 부모 게시글 번호(외래키로 생성)
}
