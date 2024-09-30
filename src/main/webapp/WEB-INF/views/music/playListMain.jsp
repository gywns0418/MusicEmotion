<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>간단한 플레이리스트</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .playlist-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .playlist-header {
            background-color: #1db954;
            color: white;
            padding: 20px;
            display: flex;
            align-items: center;
        }
        .playlist-image {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 20px;
        }
        .playlist-info h1 {
            margin: 0 0 10px 0;
        }
        .playlist-info p {
            margin: 0;
            opacity: 0.8;
        }
        .track-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        .track-item {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            border-bottom: 1px solid #eee;
        }
        .track-item:last-child {
            border-bottom: none;
        }
        .track-number {
            font-size: 14px;
            color: #999;
            width: 30px;
        }
        .track-info {
            flex-grow: 1;
        }
        .track-title {
            font-weight: bold;
            margin-bottom: 3px;
        }
        .track-artist {
            font-size: 14px;
            color: #666;
        }
        .track-duration {
            color: #999;
            font-size: 14px;
        }
    </style>
</head>

<jsp:include page="../header.jsp" />

<main>
    <div class="playlist-container">
        <div class="playlist-header">
            <img src="https://via.placeholder.com/150" alt="플레이리스트 커버" class="playlist-image">
            <div class="playlist-info">
                <h1>여름 느낌 플레이리스트</h1>
                <p>시원한 여름을 느낄 수 있는 음악 모음</p>
            </div>
        </div>
        <ul class="track-list">
            <li class="track-item">
                <span class="track-number">1</span>
                <div class="track-info">
                    <div class="track-title">여름 바다</div>
                    <div class="track-artist">해변의 가수</div>
                </div>
                <span class="track-duration">3:24</span>
            </li>
            <li class="track-item">
                <span class="track-number">2</span>
                <div class="track-info">
                    <div class="track-title">시원한 바람</div>
                    <div class="track-artist">산들바람</div>
                </div>
                <span class="track-duration">4:12</span>
            </li>
            <li class="track-item">
                <span class="track-number">3</span>
                <div class="track-info">
                    <div class="track-title">서핑의 추억</div>
                    <div class="track-artist">파도타기</div>
                </div>
                <span class="track-duration">3:56</span>
            </li>
            <li class="track-item">
                <span class="track-number">4</span>
                <div class="track-info">
                    <div class="track-title">열대야의 밤</div>
                    <div class="track-artist">밤하늘</div>
                </div>
                <span class="track-duration">3:45</span>
            </li>
            <li class="track-item">
                <span class="track-number">5</span>
                <div class="track-info">
                    <div class="track-title">아이스크림</div>
                    <div class="track-artist">달콤한 여름</div>
                </div>
                <span class="track-duration">3:18</span>
            </li>
        </ul>
    </div>
    </main>
</body>
</html>