<%@page import="com.kosa.gym.notice.service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String[] boardidList = request.getParameterValues("boardId");
	System.out.println(boardidList);
	/* NoticeService.deleteNotices(boardidList); */
	String message = "선택한 게시글 전체를 삭제했습니다.";
	/* String link = (String)session.getAttribute("boardtype"); */
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 게시글 삭제완료</title>
</head>
<body>
	<script type="text/javascript">
		alert("<%= message %>");	 //게시글삭제 결과 알림 메시지 출력
		window.location.href = "noticeList.jsp"; // noticeList.jsp로 리디렉션 */
	</script>
</body>
</html>