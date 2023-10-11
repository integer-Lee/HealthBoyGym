<%@page import="com.project.boot.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.boot.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>득근득근</title>
</head>
<body>
	<div class = "container" id = "main">
		<div id="slideShow">
			<div id="slides">
				<c:url value="/images/photo-1.jpg" var="img1Url" />
				<img src="${img1Url}" alt="" />

				<c:url value="/images/photo-2.jpg" var="img2Url" />
				<img src="${img2Url}" alt="" />

				<c:url value="/images/photo-3.jpg" var="img3Url" />
				<img src="${img3Url}" alt="" />
				<!-- <button id="prev">&lang;</button>
          <button id="next">&rang;</button> -->
			</div>
		</div>
		<div id="contents">
			<div id="tabMenu">
				<input type="radio" id="tab1" name="tabs" checked /> 
				<label for="tab1">공지사항</label> 
				<input type="radio" id="tab2" name="tabs" />
				<label for="tab2">문의</label>

				<div id="notice" class="tabContent">
					<table class = "TOP5">
						<!-- 아래와 같이 향상된 for문으로 사용하는 이유는 게시글이 한건도 존재하지 않을 때
                	 발생하는 ERROR를 예방하기 위해서다.
                 -->
						<thead>
							<tr>
								<td style="text-align: center;"><b>게시판ID</b></td>
								<td style="text-align: center;"><b>제목</b></td>
								<td style="text-align: center;"><b>작성자</b></td>
							</tr>
						</thead>
						<c:forEach var="notice" items="${noticeList }">
							<tr class="${notice.getFixed_yn().equals('Y') ? 'fixed' : '' }">
								<td style="text-align: center;">${notice.getNoticeId()}</td>
								<td style="text-align: center;"><a href="<c:url value='/notice/noticeView.do?noticeId=${notice.getNoticeId()}'/>">${notice.getTitle()}</a></td>
								<td style="text-align: center;">${notice.getUserId()}</td>
							</tr>
						</c:forEach>
						<!-- 게시글이 한건도 존재하지 않을 때 '현재 자료가 존재 하지 않습니다'문구가
						출력될 수 있도록 코딩한다. -->
						<c:if test="${noticeList.size() == 0 }">
							<tr>
								<td>현재 자료가 존재 하지 않습니다</td>
							</tr>
						</c:if>
					</table>
				</div>
				<div id="board" class="tabContent">
					<table class = "TOP5">
						<!-- 아래와 같이 향상된 for문으로 사용하는 이유는 게시글이 한건도 존재하지 않을 때
                	 발생하는 ERROR를 예방하기 위해서다.
                 -->
						<tr>
							<td style="text-align: center;"><b>게시판ID</b></td>
							<td style="text-align: center;"><b>제목</b></td>
							<td style="text-align: center;"><b>작성자</b></td>
						</tr>
						<c:forEach var="board" items="${boardList }">
							<tr>
								<td style="text-align: center;">${board.getBoardId()}</td>
								<td style="text-align: center;"><a href='board/boardView.jsp?boardId=${board.getBoardId()}'>${board.getTitle()}</a></td>
								<td style="text-align: center;">${board.getUserId()}</td>
							</tr>
						</c:forEach>
						<!-- // 게시글이 한건도 존재하지 않을 때 '현재 자료가 존재 하지 않습니다'문구가
						// 출력될 수 있도록 코딩한다. -->
						<c:if test="${boardList.size() == 0 }">
							<tr>
								<td colspan=3>현재 자료가 존재 하지 않습니다</td>
							</tr>
						</c:if>
					</table>
				</div>
			</div>
			<div id="links">
				<ul>
					<li><a href="#"> <span id="quick-icon1"></span>
							<p>오시는길</p>
					</a></li>
					<li><a href="#"> <span id="quick-icon2"></span>
							<p>문의하기</p>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<script src="<c:url value='/js/slideshow.js' />"></script>
</body>
</html>