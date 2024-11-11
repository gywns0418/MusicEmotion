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
    <style>
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .modal-content {
            position: relative;
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .close-button {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            padding: 0;
            color: #666;
        }

        .playlist-search {
            margin-bottom: 20px;
        }

        .playlist-search input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .playlist-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .playlist-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s;
        }

        .playlist-item:hover {
            background-color: #f5f5f5;
        }

        .playlist-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .playlist-cover {
            width: 50px;
            height: 50px;
            border-radius: 5px;
            object-fit: cover;
        }

        .playlist-details h3 {
            margin: 0;
            font-size: 1rem;
        }

        .playlist-details p {
            margin: 5px 0 0;
            font-size: 0.9rem;
            color: #666;
        }

        .add-to-playlist-btn {
            padding: 8px 16px;
            background-color: #1DB954;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .add-to-playlist-btn:hover {
            background-color: #1ed760;
        }
        
		.youtube-section {
		    margin: 30px 0;
		    border-radius: 12px;
		    overflow: hidden;
		    background-color: #f5f5f5;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    position: relative;
		    padding-top: 56.25%; /* 16:9 비율 */
		    width: 100%;
		}
		
		.youtube-section iframe {
		    position: absolute;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    border: none;
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

			<div class="youtube-section">
			    <div id="youtubePlayer"></div>
			</div>
        </div>

        <!-- 플레이리스트 모달 -->
        <div id="playlistModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>플레이리스트 선택</h2>
                    <button class="close-button">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="playlist-search">
                        <input type="text" id="playlistSearch" placeholder="플레이리스트 검색...">
                    </div>
                    <div class="playlist-list">
                        <c:forEach items="${userPlaylists}" var="playlist">
                            <div class="playlist-item" data-playlist-id="${playlist.playlist_id}">
                                <div class="playlist-info">
                                    <img src="${pageContext.request.contextPath}/uploads/${playlist.image != null ? playlist.image : '/images/playlist.jpg'}" 
                                         alt="Playlist Cover" class="playlist-cover">
                                    <div class="playlist-details">
                                        <h3>${playlist.title}</h3>
                                        <p>총 ${playlist.songCount}곡</p>
                                    </div>
                                </div>
                                <button class="add-to-playlist-btn" onclick="addToPlaylist('${playlist.playlist_id}', '${track.id}')">
                                    추가
                                </button>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	<!-- YouTube IFrame API 추가 -->
	<script src="https://www.youtube.com/iframe_api"></script>
	
	<!-- jQuery 추가 (이미 있다면 생략) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
	    const songTitle = "${trackName}";  // 노래 제목
	    const artistName = "${artistName}";     // 가수 이름
	    let youtubePlayer; // 전역 변수로 YouTube 플레이어 선언
	
	    function searchYouTubeAndPlay() {
	        const query = songTitle + " " + artistName;
	        const encodedQuery = encodeURIComponent(query);
	        const apiUrl = '/youtube/search?query=' + encodedQuery;

	        console.log("Query:", query);
	        console.log("API 요청 URL:", apiUrl);

	        $.getJSON(apiUrl, function(response) {
	            console.log("API 응답:", response);

	            if (response.items && response.items.length > 0) {
	                const videoId = response.items[0].id.videoId;
	                // YouTube 플레이어 생성
	                youtubePlayer = new YT.Player('youtubePlayer', {
	                    videoId: videoId,
	                    playerVars: {
	                        'autoplay': 0,
	                        'controls': 1,
	                        'rel': 0,  // 관련 동영상 표시하지 않음
	                        'modestbranding': 1  // YouTube 로고 최소화
	                    },
	                    events: {
	                        'onStateChange': onPlayerStateChange
	                    }
	                });
	            } else {
	                alert("YouTube에서 해당 곡을 찾을 수 없습니다.");
	            }
	        }).fail(function(jqXHR, textStatus, errorThrown) {
	            console.error("YouTube API 요청 실패:", textStatus, errorThrown);
	            alert("YouTube API 요청 중 문제가 발생했습니다. 나중에 다시 시도해 주세요.");
	        });
	    }
	
	    // 플레이어 상태 변경 이벤트 핸들러
	    function onPlayerStateChange(event) {
	        const playButton = document.querySelector('.button-play');
	        if (event.data === YT.PlayerState.PLAYING) {
	            playButton.innerHTML = '<i class="fas fa-pause"></i> pause';
	            playButton.classList.add('active');
	        } else if (event.data === YT.PlayerState.PAUSED || event.data === YT.PlayerState.ENDED) {
	            playButton.innerHTML = '<i class="fas fa-play"></i> play';
	            playButton.classList.remove('active');
	        }
	    }
	
	    // 재생/일시정지 토글 및 최근 재생 목록 추가 함수
	    function toggleRecentlyPlayed(button, musicId) {
	        if (!youtubePlayer) return;
	
	        if (youtubePlayer.getPlayerState() === YT.PlayerState.PLAYING) {
	            youtubePlayer.pauseVideo();
	        } else {
	            youtubePlayer.playVideo();
	            
	            // 최근 재생 목록에 추가하는 로직
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
	
	    // YouTube API 준비 완료 시 실행
	    function onYouTubeIframeAPIReady() {
	        searchYouTubeAndPlay();
	    }
	
	    // DOM 로드 완료 시 실행되는 함수들
	    document.addEventListener('DOMContentLoaded', function() {
	        // 가사 토글 기능
	        const lyricsContent = document.querySelector('.lyrics-content');
	        const lyricsToggle = document.querySelector('.lyrics-toggle');
	        
	        lyricsToggle.addEventListener('click', function() {
	            lyricsContent.classList.toggle('expanded');
	            lyricsToggle.textContent = lyricsContent.classList.contains('expanded') ? '가사 접기' : '전체 가사 보기';
	        });
	
	        // 플레이리스트 모달 관련
	        const modal = document.getElementById('playlistModal');
	        const playlistButton = document.querySelector('.button-playlist');
	        const closeButton = document.querySelector('.close-button');
	        const searchInput = document.getElementById('playlistSearch');
	        
	        // 플레이리스트 버튼 클릭 시 모달 열기
	        playlistButton.addEventListener('click', function() {
	            modal.style.display = 'block';
	        });
	        
	        // 닫기 버튼 클릭 시 모달 닫기
	        closeButton.addEventListener('click', function() {
	            modal.style.display = 'none';
	        });
	        
	        // 모달 외부 클릭 시 닫기
	        window.addEventListener('click', function(event) {
	            if (event.target === modal) {
	                modal.style.display = 'none';
	            }
	        });
	        
	        // 플레이리스트 검색 기능
	        searchInput.addEventListener('input', function() {
	            const searchTerm = this.value.toLowerCase();
	            const playlistItems = document.querySelectorAll('.playlist-item');
	            
	            playlistItems.forEach(item => {
	                const playlistName = item.querySelector('h3').textContent.toLowerCase();
	                if (playlistName.includes(searchTerm)) {
	                    item.style.display = 'flex';
	                } else {
	                    item.style.display = 'none';
	                }
	            });
	        });
	    });
	
	    // 좋아요 버튼 토글 기능
	    function toggleLike(button, musicId) {
	        button.classList.toggle('active');
	        console.log('좋아요 토글: ' + musicId);
	
	        let isLiked = button.classList.contains('active');
	        let userId = "${sessionScope.user_id}";
	
	        fetch('${pageContext.request.contextPath}/likes/addLike', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                song_id: musicId,
	                liked: isLiked
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
	
	    // 팔로우 버튼 토글 기능
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
	                artist_id: artistId,
	                following: isFollowing
	            })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                console.log('팔로우 상태가 서버에 성공적으로 반영되었습니다.');
	            } else {
	                console.error('팔로우 실패');
	            }
	        })
	        .catch(error => console.error('오류 발생:', error));
	    }
	
	    // 플레이리스트에 곡 추가하는 함수
	    function addToPlaylist(playlistId, trackId) {
	        fetch('${pageContext.request.contextPath}/playlistSong/addTrack', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                playlist_id: playlistId,
	                track_id: trackId
	            })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                alert('플레이리스트에 곡이 추가되었습니다.');
	                document.getElementById('playlistModal').style.display = 'none';
	                location.reload();
	            } else {
	                alert('곡 추가에 실패했습니다.');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            alert('오류가 발생했습니다.');
	        });
	    }
	
	    // 페이지 로드 시 실행
	    $(document).ready(function() {
	        // YouTube API가 이미 로드된 경우를 위한 처리
	        if (typeof YT !== 'undefined' && YT.loaded) {
	            searchYouTubeAndPlay();
	        }
	    });
	</script>
</main>
</body>
</html>