package com.project.boot.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class NoticeVO {
	// 기본 필드	
	private int noticeId;
	private String title;
	private String searchTitle = ""; // 검색 필드
	private String contents;
	private String userId;	// Member DTO의 기본키와 같은거다.
	private String regDate;
	private int hit;
	private String DeleteYN;	
	private String fixed_yn;	//고정게시글 유무
	
	
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
