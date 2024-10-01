<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
	<header>
	    <div class="sidebar">
	        <div class="logo"><a href="/">MusicEmotion</a></div>
	        <ul class="nav-menu">
	            <li><a href="/">홈</a></li>
	            <li><a href="#">검색</a></li>
	            <li><a href="member/login.do" id="login-link">로그인</a></li>
	            <li><a href="member/myPage.do" id="mypage-link">마이페이지</a></li>
	            <li><a href="commu/commuList.do" id="commu-link">커뮤니티</a></li>
	            <li><a href="notice/noticeList.do" id="notice-link">공지사항</a></li>
	        </ul>
	    </div>
	</header>
</body>
</html>