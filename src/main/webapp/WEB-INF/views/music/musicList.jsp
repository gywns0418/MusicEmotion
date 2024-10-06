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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>

        .music-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 24px;
            margin-top: 30px;
        }
        .music-card {
            background-color: var(--card-color);
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 4px var(--shadow-color);
        }
        .music-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px var(--shadow-color);
        }
        .music-card img {
            width: 100%;
            aspect-ratio: 1;
            object-fit: cover;
        }
        .music-info {
            padding: 16px;
        }
        .music-info h3 {
            margin: 0 0 8px;
            color: var(--highlight-color);
            font-size: 16px;
        }
        .music-info p {
            margin: 0;
            color: var(--text-color);
            font-size: 14px;
            opacity: 0.7;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 16px 16px;
        }
        .button {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 24px;
            transition: transform 0.2s;
        }
        .play-button {
            color: var(--highlight-color);
        }

        .play-button::before {
            content: '▶';
        }
        .play-button.active::before {
            content: '⏸';
        }
        .like-button {
            transition: color 0.3s;
            color: #e0e0e0;
        }
        .like-button::before {
            content: '♥';
        }
        .like-button.active {
            color: #ff4d4d;
        }
        .duration {
            font-size: 12px;
            color: var(--text-color);
            opacity: 0.7;
        }

    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />
    

        <div id="content-area">
            <h1>내 음악 리스트</h1>
           

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