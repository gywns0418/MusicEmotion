<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[아티스트/앨범] - MusicEmotion</title>
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
        .playlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .playlist-card {
            background-color: #f7f7f7;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.2s;
        }
        .playlist-card:hover {
            transform: translateY(-5px);
        }
        .playlist-card img {
            width: 100%;
            height: auto;
        }
        .playlist-title {
            font-weight: bold;
            padding: 10px;
        }
        .playlist-description {
            font-size: 14px;
            color: #666;
            padding: 0 10px 10px;
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
            <h1>[아티스트/앨범]</h1>
            <p>[설명 텍스트]</p>
            
            <div class="playlist-grid">
                <div class="playlist-card">
                    <img src="/api/placeholder/200/200" alt="[아이템 1]">
                    <div class="playlist-title">[아이템 제목 1]</div>
                    <div class="playlist-description">[부제목 1]</div>
                </div>
                <div class="playlist-card">
                    <img src="/api/placeholder/200/200" alt="[아이템 2]">
                    <div class="playlist-title">[아이템 제목 2]</div>
                    <div class="playlist-description">[부제목 2]</div>
                </div>
                <div class="playlist-card">
                    <img src="/api/placeholder/200/200" alt="[아이템 3]">
                    <div class="playlist-title">[아이템 제목 3]</div>
                    <div class="playlist-description">[부제목 3]</div>
                </div>
                <!-- 더 많은 아이템을 추가할 수 있습니다 -->
            </div>
            
            <br>
            <button class="button">[버튼 텍스트]</button>
        </div>
    </div>
</body>
</html>