<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>곡 상세 정보 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --background-color: #ffffff;
            --text-color: #333333;
            --highlight-color: #1db954;
            --card-color: #ffffff;
            --hover-color: #f0f0f0;
            --shadow-color: rgba(0, 0, 0, 0.1);
            --button-primary: #1db954;
            --button-secondary: #ffffff;
            --button-danger: #ff4d4d;
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

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            align-items: center;
        }

        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .button i {
            font-size: 18px;
        }

        .button-play {
            background-color: var(--button-primary);
            color: white;
            min-width: 140px;
        }

        .button-play:hover {
            background-color: #1ed760;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(30, 215, 96, 0.3);
        }

        .button-playlist {
            background-color: var(--button-secondary);
            color: var(--text-color);
            border: 2px solid var(--text-color);
        }

        .button-playlist:hover {
            background-color: var(--hover-color);
            transform: translateY(-2px);
        }

        .button-like {
            background-color: transparent;
            color: var(--text-color);
            border: 2px solid var(--text-color);
            padding: 12px 16px;
            position: relative;
            overflow: hidden;
        }

        .button-like:hover {
            color: var(--button-danger);
            border-color: var(--button-danger);
            transform: translateY(-2px);
        }

        .button-like.active {
            background-color: #fff0f0;
            color: var(--button-danger);
            border-color: var(--button-danger);
        }

        .button-like i {
            transition: transform 0.3s ease;
        }

        .button-like:hover i {
            transform: scale(1.2);
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
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background-color: var(--card-color);
            box-shadow: 0 2px 5px var(--shadow-color);
            transform: translateY(-2px);
        }

        .detail-label {
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--highlight-color);
        }

        .detail-value {
            color: var(--text-color);
        }

        .lyrics-section {
            background-color: var(--card-color);
            padding: 30px;
            border-radius: 12px;
            margin-top: 30px;
            position: relative;
            box-shadow: 0 2px 8px var(--shadow-color);
        }

        .lyrics-content {
            max-height: 200px;
            overflow: hidden;
            transition: all 0.5s ease;
            padding: 0 20px;
            line-height: 1.8;
        }

        .lyrics-content.expanded {
            max-height: none;
        }

        .lyrics-toggle {
            position: absolute;
            bottom: -15px;
            right: 30px;
            background-color: var(--button-secondary);
            color: var(--text-color);
            border: 2px solid var(--text-color);
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .lyrics-toggle:hover {
            background-color: var(--hover-color);
            transform: translateY(-2px);
        }

        .audio-player {
            margin-top: 30px;
            background-color: var(--hover-color);
            padding: 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px var(--shadow-color);
        }

        .audio-player audio {
            flex-grow: 1;
            height: 40px;
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
            transition: all 0.3s ease;
        }

        .recommendation-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px var(--shadow-color);
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
                padding: 20px 10px;
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

            .song-title {
                font-size: 28px;
            }

            .song-artist {
                font-size: 20px;
            }

            .action-buttons {
                flex-wrap: wrap;
                gap: 10px;
            }

            .button {
                width: 100%;
                justify-content: center;
            }

            .button-like {
                width: auto;
                flex: 0 0 auto;
            }

            .lyrics-toggle {
                right: 50%;
                transform: translateX(50%);
            }
        }
    </style>
</head>

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
                <button class="button button-play">
                    <i class="fas fa-play"></i>
                    재생
                </button>
                <button class="button button-playlist">
                    <i class="fas fa-plus"></i>
                    플레이리스트에 추가
                </button>
                <button class="button-like ${fn:contains(likedSongIds, track.id) ? 'active' : ''}" onclick="toggleLike(this, '${track.id}')">
                    <i class="fas fa-heart"></i>
                </button>
            </div>

            <div class="song-details">
                <div class="detail-item">
                    <div class="detail-label">발매일</div>
                    <div class="detail-value">${releaseDate}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">장르</div>
                    <div class="detail-value">${genre}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">재생 시간</div>
                    <div class="detail-value">
                        <c:set var="minutes" value="${track.durationMs / 60000}" />
                        <c:set var="seconds" value="${(track.durationMs % 60000) / 1000}" />
                        <fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
                        <fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
                    </div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">참여 아티스트</div>
                    <div class="detail-value">${artistNames}</div>
                </div>
            </div>

            <div class="lyrics-section">
                <h2>가사</h2>
                <div class="lyrics-content">
                    <p>${lyrics}</p>
                </div>
                <button class="lyrics-toggle">전체 가사 보기</button>
            </div>

            <div class="audio-player">
                <audio controls>
                    <source src="path_to_audio_file.mp3" type="audio/mpeg">
                    Your browser does not support the audio element.
                </audio>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 가사 토글 기능
            const lyricsContent = document.querySelector('.lyrics-content');
            const lyricsToggle = document.querySelector('.lyrics-toggle');
            
            lyricsToggle.addEventListener('click', function() {
                lyricsContent.classList.toggle('expanded');
                lyricsToggle.textContent = lyricsContent.classList.contains('expanded') ? '가사 접기' : '전체 가사 보기';
            });

            // 재생 버튼 클릭 이벤트
            const playButton = document.querySelector('.button-play');
            
            playButton.addEventListener('click', function() {
                const audio = document.querySelector('audio');
                if (audio.paused) {
                    audio.play();
                    this.querySelector('i').classList.replace('fa-play', 'fa-pause');
                } else {
                    audio.pause();
                    this.querySelector('i').classList.replace('fa-pause', 'fa-play');
                }
            });
        });
        
     	// 좋아요 버튼 토글 기능 및 서버 전송
        function toggleLike(button, musicId) {
            // 버튼 상태를 토글 (active 클래스 추가/제거)
            button.classList.toggle('active');
            console.log('좋아요 토글: ' + musicId);

            // 좋아요 상태를 서버에 전송하는 로직
            let isLiked = button.classList.contains('active'); // 버튼이 활성화된 상태인지 확인
            let userId = "${sessionScope.user_id}"; // 세션에서 사용자 ID를 가져옴

            // 서버로 POST 요청을 보냄
            fetch('${pageContext.request.contextPath}/likes/addLike', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    song_id: musicId,
                    liked: isLiked // 좋아요 상태 전송
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('좋아요 상태가 서버에 성공적으로 반영되었습니다.');
                } else {
                    console.log('서버 처리 중 오류 발생');
                }
            })
            .catch(error => {
                console.error('오류 발생:', error);
            });
        }

    </script>
    </main>
</body>
</html>