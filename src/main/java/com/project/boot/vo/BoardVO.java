package com.project.boot.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class BoardVO {
	private String searchTitle = "";
	private int boardId;
	private String title;
	private String contents;
	private String userId;
	private String regDate;
	private int hit;
	private String DeleteYN;
	private int pid;	//게시글 부모번호, 부모번호가 없을 때 0
	private int level = 1;	//계층형 쿼리를 위해 필요한 필드
	
	// 페이징	
		private int pageNo = 1;	// 현재 페이지 번호
		private int totalCount;	//전체 건수
		private int totalPageSize;	//전체 페이지 번호
		private int pageLength = 10; // 한페이지의 길이
		private int navSize = 10; // 페이지 하단에 출력되는 페이지의 항목수 
		private int navStart = 0; //페이지 하단에 출력되는 페이지 시작 번호 : NavStart = (PageNo / NavSize) * NavSize + 1
	  	private int navEnd = 0;// 페이지 하단에 출력되는 페이지 끝 번호 : NavEnd = (PageNo / NavSize + 1) * NavSize

	  	
	  	// 응집력을 강화하기위해 NoticeService가 아닌 Notice하위에 setTotalCount라는 메서드로 만들어준다.  	
	  	public void setTotalCount(int totalCount) {
	  		this.totalCount = totalCount;
	  		
			// 2. 전체 페이지 건수를 계산한다.
	  		totalPageSize = (int) Math.ceil((double) totalCount / pageLength);
			
			// 3. 페이지 네비게이터 시작 페이지번호를 계산한다.		
			navStart = (((pageNo - 1) / navSize) * navSize + 1);
			
			// 4. 페이지 네비게이터 끝 페이지번호를 계산한다.
			navEnd = ((pageNo - 1) / navSize + 1) * navSize;
			
			// 5. 전체 페이지보다 크면 전체 페이지 값을 변경한다.
			if (navEnd >= totalPageSize) {
				navEnd = totalPageSize;
			}
	  	}
	  	
	  	// 페이지 하단에 출력되는 페이지 시작 번호
	  	public int getStartNo() {
	  		return (pageNo - 1) * pageLength + 1;
	  	}
	  	
	  	// 페이지 하단에 출력되는 페이지 끝 번호
	  	public int getEndNo() {
	  		return pageNo * pageLength;
	  	}
}
