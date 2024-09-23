<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>최근 재생 - MusicEmotion</title>
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
        h1, h2 {
            color: #191414;
        }
        .section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .song-item {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .song-item:last-child {
            border-bottom: none;
        }
        .song-image {
            width: 60px;
            height: 60px;
            margin-right: 15px;
            border-radius: 4px;
        }
        .song-info {
            flex-grow: 1;
        }
        .song-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .song-artist {
            color: #666;
            font-size: 14px;
        }
        .song-duration {
            color: #999;
            font-size: 14px;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="section">
            <h1>최근 재생</h1>
            <p>지난 30일 동안 들은 곡들입니다.</p>
            
            <div class="song-list">
                <div class="song-item">
                    <img src="/api/placeholder/60/60" alt="노래 1" class="song-image">
                    <div class="song-info">
                        <div class="song-title">Dynamite</div>
                        <div class="song-artist">BTS</div>
                    </div>
                    <div class="song-duration">3:19</div>
                </div>
                <div class="song-item">
                    <img src="/api/placeholder/60/60" alt="노래 2" class="song-image">
                    <div class="song-info">
                        <div class="song-title">Blinding Lights</div>
                        <div class="song-artist">The Weeknd</div>
                    </div>
                    <div class="song-duration">3:20</div>
                </div>
                <div class="song-item">
                    <img src="/api/placeholder/60/60" alt="노래 3" class="song-image">
                    <div class="song-info">
                        <div class="song-title">Don't Start Now</div>
                        <div class="song-artist">Dua Lipa</div>
                    </div>
                    <div class="song-duration">3:03</div>
                </div>
                <!-- 더 많은 노래 항목을 추가할 수 있습니다 -->
            </div>
            
            <br>
            <button class="button">전체 재생</button>
        </div>
    </div>
</body>
</html>