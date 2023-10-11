<%@page import="com.project.boot.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.boot.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
</head>
<body>
	<div class = "container">
		<footer>
			<div id="bottomMenu">
				<ul>
					<li><a href="#">회사 소개</a></li>
					<li><a href="#">개인정보처리방침</a></li>
					<li><a href="#">센터이용 약관</a></li>
					<li><a href="#">사이트맵</a></li>
				</ul>
				<div id="sns">
					<ul>
						<li><a href="#"><img src="<c:url value='/resources/images/sns-1.png'/>"></a></li>
						<li><a href="#"><img src="<c:url value='/resources/images/sns-2.png'/>"></a></li>
						<li><a href="#"><img src="<c:url value='/resources/images/sns-3.png'/>"></a></li>
					</ul>
				</div>
			</div>
			<div id="company">
				<p>서울 종로구 창경궁로 254 7층 (바지사장 이정수) 손전화 : 010-1234-1324</p>
			</div>
		</footer>
	</div>
</body>
</html>