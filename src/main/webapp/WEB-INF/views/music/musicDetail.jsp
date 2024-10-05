<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>곡 상세 정보 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f6f6f6;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #191414;
        }
        .song-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .song-image {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }
        .song-info {
            flex-grow: 1;
        }
        .song-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .song-artist {
            font-size: 18px;
            color: #666;
            margin-bottom: 10px;
        }
        .song-album {
            font-size: 16px;
            color: #888;
        }
        .song-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .detail-item {
            background-color: #f7f7f7;
            padding: 15px;
            border-radius: 8px;
        }
        .detail-label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .detail-value {
            color: #666;
        }
        .button {
            background-color: #1db954;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.2s;
        }
        .button:hover {
            background-color: #1ed760;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<jsp:include page="../header.jsp" />

    <div class="container">
        <div class="section">
            <div class="song-header">
                <img src="/api/placeholder/200/200" alt="앨범 커버" class="song-image">
                <div class="song-info">
                    <h1 class="song-title">Dynamite</h1>
                    <div class="song-artist">BTS</div>
                    <div class="song-album">앨범: Dynamite (Single)</div>
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="button">재생</button>
                <button class="button">플레이리스트에 추가</button>
                <button class="button">좋아요</button>
            </div>

            <div class="song-details">
                <div class="detail-item">
                    <div class="detail-label">발매일</div>
                    <div class="detail-value">2020년 8월 21일</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">장르</div>
                    <div class="detail-value">디스코 팝</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">재생 시간</div>
                    <div class="detail-value">3:19</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">작곡가</div>
                    <div class="detail-value">David Stewart, Jessica Agombar</div>
                </div>
            </div>

            <h2>가사</h2>
            <p>
                'Cause I, I, I'm in the stars tonight<br>
                So watch me bring the fire and set the night alight<br>
                Shoes on, get up in the morn'<br>
                Cup of milk, let's rock and roll<br>
                King Kong, kick the drum, rolling on like a Rolling Stone<br>
                Sing song when I'm walking home<br>
                Jump up to the top, LeBron<br>
                Ding dong, call me on my phone<br>
                Ice tea and a game of ping pong, huh
            </p>
            <button class="button">전체 가사 보기</button>
        </div>
    </div>
</main>
</body>
</html>