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
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/albumDetail.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

    <jsp:include page="../header.jsp" />

    <div id="content-area">
        <div class="hero-section">
            <h1>${album.title}</h1>
            <p>${album.artist}의 음악 세계로 초대합니다.</p>
        </div>

        <div class="section" id="album-details">
            <div class="album-info">
                <img src="${album.coverUrl}" alt="${album.title} 앨범 커버" class="album-cover">
                <div class="album-text">
                    <h2>${album.title}</h2>
                    <p class="artist-name">${album.artist}</p>
                    <p class="release-date">발매일: ${album.releaseDate}</p>
                    <p class="genre">장르: ${album.genre}</p>
                    <div class="album-stats">
                        <span>총 ${album.trackCount}곡</span> • 
                        <span>${album.duration}</span> • 
                        <span>${album.likes} 좋아요</span>
                    </div>
                    <button class="cta-button" onclick="playAll()">
                        <i class="fas fa-play"></i> 전체 재생
                    </button>
                </div>
            </div>
        </div>

        <div class="section" id="track-list">
            <h2>수록곡</h2>
            <ol class="track-list">
                <c:forEach items="${album.tracks}" var="track">
                    <li>
                        <div class="track-info">
                            <span class="track-title">${track.title}</span>
                            <span class="track-duration">${track.duration}</span>
                        </div>
                        <button class="play-button" onclick="playTrack('${track.id}')">
                            재생
                        </button>
                    </li>
                </c:forEach>
            </ol>
        </div>

        <div class="section" id="album-description">
            <h2>앨범 소개</h2>
            <p>${album.description}</p>
        </div>

        <div class="section" id="related-albums">
            <h2>관련 앨범</h2>
            <div class="playlist-grid">
                <c:forEach items="${relatedAlbums}" var="related">
                    <div class="playlist-card">
                        <img src="${related.coverUrl}" alt="${related.title}">
                        <div class="playlist-title">${related.title}</div>
                        <div class="playlist-description">${related.artist}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script>
        function playAll() {
            // 전체 재생 로직 구현
            console.log("전체 재생");
        }

        function playTrack(trackId) {
            // 개별 트랙 재생 로직 구현
            console.log("트랙 재생:", trackId);
        }

        $(document).ready(function() {
            // 페이지 로드 시 필요한 초기화 작업
        });
    </script>
</main>
</body>
</html>