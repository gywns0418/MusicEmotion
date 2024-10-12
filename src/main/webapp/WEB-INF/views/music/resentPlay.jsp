<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>최근 재생 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .recent-play-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .song-list {
            background-color: var(--card-color);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px var(--shadow-color);
        }
        .song-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid var(--hover-color);
            transition: background-color 0.3s;
        }
        .song-item:last-child {
            border-bottom: none;
        }
        .song-item:hover {
            background-color: var(--hover-color);
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
            color: var(--text-color);
        }
        .song-artist {
            color: var(--text-color);
            opacity: 0.7;
            font-size: 14px;
        }
        .song-duration {
            color: var(--text-color);
            opacity: 0.5;
            font-size: 14px;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .statistics {
            background-color: var(--card-color);
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 2px 4px var(--shadow-color);
        }
        .stat-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
    </style>
</head>

    <jsp:include page="../header.jsp" />

        <div class="recent-play-container">
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
                <div class="song-item">
                    <img src="/api/placeholder/60/60" alt="노래 4" class="song-image">
                    <div class="song-info">
                        <div class="song-title">Watermelon Sugar</div>
                        <div class="song-artist">Harry Styles</div>
                    </div>
                    <div class="song-duration">2:54</div>
                </div>
                <div class="song-item">
                    <img src="/api/placeholder/60/60" alt="노래 5" class="song-image">
                    <div class="song-info">
                        <div class="song-title">Dance Monkey</div>
                        <div class="song-artist">Tones and I</div>
                    </div>
                    <div class="song-duration">3:29</div>
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="cta-button">전체 재생</button>
                <button class="cta-button">플레이리스트 생성</button>
            </div>

            <div class="statistics">
                <h2>나의 청취 통계</h2>
                <div class="stat-item">
                    <span>총 재생 시간</span>
                    <span>14시간 23분</span>
                </div>
                <div class="stat-item">
                    <span>가장 많이 들은 장르</span>
                    <span>Pop</span>
                </div>
                <div class="stat-item">
                    <span>가장 많이 들은 아티스트</span>
                    <span>BTS</span>
                </div>
                <div class="stat-item">
                    <span>이 달의 최다 재생곡</span>
                    <span>Dynamite - BTS</span>
                </div>
            </div>
        </div>
    </main>
</body>
</html>