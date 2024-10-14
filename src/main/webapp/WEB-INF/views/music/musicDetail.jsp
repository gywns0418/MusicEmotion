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
        :root {
            --background-color: #ffffff;
            --text-color: #333333;
            --highlight-color: #1db954;
            --card-color: #ffffff;
            --hover-color: #f0f0f0;
            --shadow-color: rgba(0, 0, 0, 0.1);
        }



        .container {
            max-width: 90%;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .section {
            background-color: var(--card-color);
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 10px var(--shadow-color);
            transition: transform 0.3s ease;
        }

        .section:hover {
            transform: translateY(-5px);
        }

        h1, h2 {
            color: var(--highlight-color);
            margin-bottom: 20px;
        }

        .song-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .song-image {
            width: 250px;
            height: 250px;
            object-fit: cover;
            border-radius: 12px;
            margin-right: 30px;
            box-shadow: 0 4px 10px var(--shadow-color);
            transition: transform 0.3s ease;
        }

        .song-image:hover {
            transform: scale(1.05);
        }

        .song-info {
            flex-grow: 1;
        }

        .song-title {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 15px;
            color: var(--text-color);
        }

        .song-artist {
            font-size: 24px;
            color: var(--highlight-color);
            margin-bottom: 10px;
        }

        .song-album {
            font-size: 18px;
            color: #666;
        }

        .song-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .detail-item {
            background-color: var(--hover-color);
            padding: 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .detail-item:hover {
            background-color: var(--card-color);
            box-shadow: 0 2px 5px var(--shadow-color);
        }

        .detail-label {
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--highlight-color);
        }

        .detail-value {
            color: var(--text-color);
        }

        .button {
            background-color: var(--highlight-color);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .button:hover {
            background-color: #1ed760;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .lyrics-section {
            background-color: var(--hover-color);
            padding: 30px;
            border-radius: 12px;
            margin-top: 30px;
            position: relative;
            overflow: hidden;
        }

        .lyrics-content {
            max-height: 200px;
            overflow: hidden;
            transition: max-height 0.5s ease;
        }

        .lyrics-content.expanded {
            max-height: none;
        }

        .lyrics-toggle {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background-color: var(--highlight-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .lyrics-toggle:hover {
            background-color: #1ed760;
        }

        .audio-player {
            margin-top: 30px;
            background-color: var(--hover-color);
            padding: 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .audio-player audio {
            flex-grow: 1;
        }

        .recommendations {
            margin-top: 40px;
        }

        .recommendation-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }

        .recommendation-card {
            background-color: var(--card-color);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px var(--shadow-color);
            transition: transform 0.3s ease;
        }

        .recommendation-card:hover {
            transform: translateY(-5px);
        }

        .recommendation-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .recommendation-info {
            padding: 15px;
        }

        .recommendation-title {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .recommendation-artist {
            font-size: 14px;
            color: #666;
        }

        @media (max-width: 768px) {
            .container {
                max-width: 95%;
            }

            .song-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .song-image {
                width: 100%;
                height: auto;
                margin-right: 0;
                margin-bottom: 20px;
            }

            .action-buttons {
                flex-wrap: wrap;
            }

            .button {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />

    <div class="container">
        <div class="section">
            <div class="song-header">
                <img src="${albumImage}" alt="Album Cover" class="song-image"/>
                <div class="song-info">
                    <h1 class="song-title">${trackName}</h1>
                    <div class="song-artist">${artistName}</div>
                    <div class="song-album">앨범: ${track.album.name}</div>
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
                    <div class="detail-value">${releaseDate}</div>
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

            <div class="lyrics-section">
                <h2>가사</h2>
                <div class="lyrics-content">
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
                </div>
                <button class="lyrics-toggle">전체 가사 보기</button>
            </div>

            <div class="audio-player">
                <audio controls>
                    <source src="path_to_audio_file.mp3" type="audio/mpeg">
                    Your browser does not support the audio element.
                </audio>
            </div>

 
            <!-- <div class="recommendations">
                <h2>비슷한 노래</h2>
                <div class="recommendation-grid">
                    <div class="recommendation-card">
                        <img src="path_to_album_cover.jpg" alt="Album Cover" class="recommendation-image">
                        <div class="recommendation-info">
                            <div class="recommendation-title">Song Title</div>
                            <div class="recommendation-artist">Artist Name</div>
                        </div>
                    </div>
                </div>
            </div> -->
            
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const lyricsContent = document.querySelector('.lyrics-content');
            const lyricsToggle = document.querySelector('.lyrics-toggle');

            lyricsToggle.addEventListener('click', function() {
                lyricsContent.classList.toggle('expanded');
                lyricsToggle.textContent = lyricsContent.classList.contains('expanded') ? '가사 접기' : '전체 가사 보기';
            });
        });
    </script>
</body>
</html>