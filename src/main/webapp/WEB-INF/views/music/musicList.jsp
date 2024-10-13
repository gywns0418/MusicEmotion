<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 음악 리스트 - AI 음악 추천 서비스</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicList.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
    <jsp:include page="../header.jsp" />
    

        <div id="content-area">
            
 			<div class="hero-section">
                <h1>음악 리스트</h1>
            </div>

            <div class="music-list">
                <!-- 음악 카드 예시 (실제로는 서버에서 데이터를 받아와 동적으로 생성해야 합니다) -->
                <div class="music-card">
                    <img src="${albumImage}" alt="Album Cover" width="300px"/>
                    <div class="music-info">
                        <h3>${trackName}</h3>
                        <p>${artistName}</p>
                    </div>
                    <div class="button-group">
                        <button class="button play-button" onclick="togglePlay(this, 1)"></button>
                        <span class="duration">3:19</span>
                        <button class="button like-button" onclick="toggleLike(this, 1)"></button>
                    </div>
                </div>
                
                <div class="music-card">
                    <img src="https://via.placeholder.com/200" alt="앨범 커버">
                    <div class="music-info">
                        <h3>눈의 꽃</h3>
                        <p>박효신</p>
                    </div>
                    <div class="button-group">
                        <button class="button play-button" onclick="togglePlay(this, 2)"></button>
                        <span class="duration">4:05</span>
                        <button class="button like-button" onclick="toggleLike(this, 2)"></button>
                    </div>
                </div>
                
                <div class="music-card">
                    <img src="https://via.placeholder.com/200" alt="앨범 커버">
                    <div class="music-info">
                        <h3>Celebrity</h3>
                        <p>IU</p>
                    </div>
                    <div class="button-group">
                        <button class="button play-button" onclick="togglePlay(this, 3)"></button>
                        <span class="duration">3:14</span>
                        <button class="button like-button" onclick="toggleLike(this, 3)"></button>
                    </div>
                </div>
                
                <!-- 추가 음악 카드들... -->
            </div>
        </div>
    </main>

    <script>
        function togglePlay(button, musicId) {
            button.classList.toggle('active');
            if (button.classList.contains('active')) {
                console.log('재생: ' + musicId);
                // 여기에 음악 재생 로직을 구현하세요
            } else {
                console.log('일시정지: ' + musicId);
                // 여기에 음악 일시정지 로직을 구현하세요
            }
        }

        function toggleLike(button, musicId) {
            button.classList.toggle('active');
            console.log('좋아요 토글: ' + musicId);
            // 여기에 좋아요 상태를 서버에 전송하는 로직을 구현하세요
        }

        function searchMusic() {
            const searchTerm = document.getElementById('search-input').value;
            console.log('검색어: ' + searchTerm);
            // 여기에 검색 로직을 구현하세요
        }
    </script>
</body>
</html>