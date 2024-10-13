<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>앨범 상세 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/artist.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../header.jsp" />


    <div id="content-area">
        <div class="hero-section">
            <h1>앨범 상세 정보</h1>
            <p>아티스트의 창작물을 자세히 살펴보세요.</p>
        </div>

        <div class="section" id="album-details">
            <div class="album-info">
                <img src="/api/placeholder/300/300" alt="앨범 커버" class="album-cover">
                <div class="album-text">
                    <h2>앨범 제목</h2>
                    <p class="artist-name">아티스트 이름</p>
                    <p class="release-date">발매일: 2024년 1월 1일</p>
                    <p class="genre">장르: Pop, R&B</p>
                    <button class="cta-button">전체 재생</button>
                </div>
            </div>
        </div>

        <div class="section" id="track-list">
            <h2>수록곡</h2>
            <ol class="track-list">
                <li>
                    <div class="track-info">
                        <span class="track-title">트랙 1</span>
                        <span class="track-duration">3:45</span>
                    </div>
                    <button class="play-button">재생</button>
                </li>
                <li>
                    <div class="track-info">
                        <span class="track-title">트랙 2</span>
                        <span class="track-duration">4:12</span>
                    </div>
                    <button class="play-button">재생</button>
                </li>
                <!-- 더 많은 트랙을 추가할 수 있습니다 -->
            </ol>
        </div>

        <div class="section" id="album-description">
            <h2>앨범 소개</h2>
            <p>이 앨범에 대한 상세한 설명이 들어갑니다. 아티스트의 음악적 방향, 앨범의 주제, 작업 과정 등을 포함할 수 있습니다.</p>
        </div>

        <div class="section" id="related-albums">
            <h2>관련 앨범</h2>
            <div class="playlist-grid">
                <div class="playlist-card">
                    <img src="/api/placeholder/200/200" alt="관련 앨범 1">
                    <div class="playlist-title">관련 앨범 1</div>
                    <div class="playlist-description">아티스트 이름</div>
                </div>
                <div class="playlist-card">
                    <img src="/api/placeholder/200/200" alt="관련 앨범 2">
                    <div class="playlist-title">관련 앨범 2</div>
                    <div class="playlist-description">아티스트 이름</div>
                </div>
                <!-- 더 많은 관련 앨범을 추가할 수 있습니다 -->
            </div>
        </div>
    </div>
</main>

<script>
    $(document).ready(function() {
        // 여기에 필요한 JavaScript 코드를 추가할 수 있습니다.
        // 예: 트랙 재생, 전체 재생 기능 등
    });
</script>

</body>
</html>