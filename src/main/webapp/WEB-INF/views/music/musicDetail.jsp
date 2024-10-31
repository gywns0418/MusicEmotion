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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicDetail.css">

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
				<button class="button button-play" onclick="toggleRecentlyPlayed(this, '${track.id}')">
                    <i class="fas fa-play"></i>
                    play
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
	                <div class="artist-list">
	                    <c:forEach items="${artistNames}" var="artistName" varStatus="status">
						    <div class="artist-item">
						        <span>${artistName}</span>
						        <button class="button-follow ${fn:contains(followedArtistIds, artistId) ? 'active' : ''}" 
						                onclick="toggleFollow(this, '${artistId}')">
						            <i class="fas ${fn:contains(followedArtistIds, artistId) ? 'fa-user-check' : 'fa-user-plus'}"></i> 
						            ${fn:contains(followedArtistIds, artistId) ? '팔로잉' : '팔로우'}
						        </button>
						    </div>
						</c:forEach>
	                </div>
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
                    <source src="${previewUrl}" type="audio/mpeg">
                    Your browser does not support the audio element.
                </audio>
            </div>
        </div>
    </div>

    <h1>YouTube 비디오 재생</h1>
    <div id="player"></div>
    <button onclick="playVideo()">재생</button>
    <button onclick="pauseVideo()">일시 정지</button>

    <script>
        let player;

        // YouTube IFrame API가 준비되면 호출됨
        function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
                height: '360',
                width: '640',
                videoId: 'dQw4w9WgXcQ', // 예시 비디오 ID 설정
                events: {
                    'onReady': onPlayerReady,
                    'onStateChange': onPlayerStateChange
                }
            });
        }

        function onPlayerReady(event) {
            console.log("비디오 플레이어 준비 완료");
        }

        function onPlayerStateChange(event) {
            if (event.data === YT.PlayerState.ENDED) {
                console.log('비디오가 종료되었습니다.');
            }
        }

        function playVideo() {
            player.playVideo();
        }

        function pauseVideo() {
            player.pauseVideo();
        }
    </script>

    <script src="https://www.youtube.com/iframe_api"></script>

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

        function toggleFollow(button, artistId) {
            button.classList.toggle('active');
            const isFollowing = button.classList.contains('active');
            button.innerHTML = isFollowing ? '<i class="fas fa-user-check"></i> 팔로잉' : '<i class="fas fa-user-plus"></i> 팔로우';

            console.log('아티스트 아이디: '+artistId);
            
            fetch('${pageContext.request.contextPath}/artist/follow', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    artist_id: artistId, // 아티스트 이름을 식별자로 사용
                    following: isFollowing
                })
            }).then(response => response.json())
              .then(data => {
            	  if (data.success) {
                      console.log('팔로우 상태가 서버에 성공적으로 반영되었습니다.');
                  } else {
                	  console.error('팔로우 실패');
                  }
              })
              .catch(error => console.error('오류 발생:', error));
        }
        
        function toggleRecentlyPlayed(button, musicId) {
            // 버튼 활성화 상태 토글
            button.classList.toggle('active');
            const isPlaying = button.classList.contains('active');

            // 버튼 텍스트 또는 아이콘 업데이트
            button.innerHTML = isPlaying 
                ? '<i class="fas fa-pause"></i> pause' 
                : '<i class="fas fa-play"></i> play';

            

            // 재생 상태를 서버에 전송하여 최근 재생 목록에 추가
            if (isPlaying) {
            	console.log('트랙 아이디: ' + musicId);
                const formData = new URLSearchParams();
                formData.append("musicId", musicId);

                fetch('<%= request.getContextPath() %>/recentPlayed/addRecentlyPlayed', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        console.log('최근 재생 목록에 성공적으로 추가되었습니다.');
                    } else {
                        console.error('추가 실패');
                    }
                })
                .catch(error => console.error('오류 발생:', error));
            }
        }




    </script>
    </main>
</body>
</html>