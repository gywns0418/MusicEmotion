<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
	    $(document).ready(function() {
	
	        // 검색 버튼 클릭 시 검색 창 토글
	        $('.nav-menu a:contains("검색")').click(function(e) {
	            e.preventDefault();
	            $('#search-container').slideToggle();  // 검색 창 열기/닫기
	        });
	
	        // 검색 버튼 클릭 시 검색 창 닫기
	        $('#search-submit').click(function() {
	            var searchTerm = document.getElementById("search-input").value.trim();
	            window.location.href = "/spotify/musicList.do"; // ?search=" + encodeURIComponent(searchTerm);
	            $('#search-container').slideUp();  // 검색 버튼 클릭 시 창 닫기
	        });
	
	        // 검색 창 외부 클릭 시 검색 창 닫기
	        $(document).click(function(event) {
	            if (!$(event.target).closest('#search-container, .nav-menu a:contains("검색")').length) {
	                $('#search-container').slideUp();
	            }
	        });
	    });
	</script>
</head>
<body>
	<header>
	    <div class="sidebar">
	        <div class="logo"><a href="/">MusicEmotion</a></div>
	        <sec:authorize access="isAuthenticated()">
	        	<p>안녕하세요, <sec:authentication property="principal.name" />님!</p><br>
	       	</sec:authorize>
	        <ul class="nav-menu">
			    <li><a href="${pageContext.request.contextPath}/">홈</a></li>
			    <li><a href="#">검색</a></li>
			    
			    <sec:authorize access="isAnonymous()">
			    	<li><a href="${pageContext.request.contextPath}/member/login.do" id="login-link">로그인</a></li>
			    </sec:authorize>
			    
			    <sec:authorize access="isAuthenticated()">
			    	<li><a href="<c:url value='/logout'/>">로그아웃</a></li>
			    	<li><a href="${pageContext.request.contextPath}/member/myPage.do" id="mypage-link">마이페이지</a></li>
			    </sec:authorize>
			    
			    <li><a href="${pageContext.request.contextPath}/commu/commuList.do" id="commu-link">커뮤니티</a></li>
			    <li><a href="${pageContext.request.contextPath}/notice/noticeList.do" id="notice-link">공지사항</a></li>
			</ul>
	    </div>
	</header>
	<main>
	     <div id="search-container" class="search-container">
            <input type="text" id="search-input" placeholder="노래, 아티스트, 앨범 검색...">
            <button id="search-submit">검색</button>
        </div>