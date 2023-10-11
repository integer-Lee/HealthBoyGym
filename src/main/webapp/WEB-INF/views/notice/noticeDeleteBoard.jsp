<%@page import="com.kosa.gym.notice.service.NoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int boardId = Integer.parseInt(request.getParameter("boardId"));
    	/* NoticeService.deleteNotice(boardId); */
    	String message ="문의 게시글 삭제완료";
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 게시글 삭제완료</title>
</head>
<body>
	<script type="text/javascript">
		alert("<%= message %>");	 //게시글삭제 결과 알림 메시지 출력
		window.location.href = "boardList.jsp"; // boardView.jsp로 리디렉션 */
	</script>
</body>
</html>