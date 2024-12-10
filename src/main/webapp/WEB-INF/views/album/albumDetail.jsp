<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>앨범 상세 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/albumDetail.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

    <jsp:include page="../header.jsp" />

    <div id="content-area">             
        <div class="artist-header" style="background-image: url('${album.coverUrl}')">
            <div class="header-overlay">
                <div class="artist-profile">
                    <div class="artist-image-container">
                        <img src="${album.coverUrl}" alt="${album.title}" class="artist-image">
                    </div>
                    <div class="artist-info">
                        <div class="artist-title">
                            <h1>${album.artist}</h1>
                        </div>
                        <p class="artist-genre">${album.genre}</p>
                        <div class="artist-stats">
                            <div class="stat-item">
                                <span class="stat-value">${album.releaseDate}</span>
                                <span class="stat-label">발매일</span>
                            </div>
                            <div class="stat-divider"></div>
                            <div class="stat-item">
                                <span class="stat-value">${album.trackCount}</span>
                                <span class="stat-label">총 곡</span>
                            </div>
                            <div class="stat-divider"></div>
                            <div class="stat-item">
                                <span class="stat-value">${album.duration}</span>
                                <span class="stat-label">전체 곡 길이</span>
                            </div>                        
                            <div class="stat-divider"></div>
                            <div class="stat-item">
                                <span class="stat-value">${album.likes}</span>
                                <span class="stat-label">좋아요</span>
                            </div>
                        </div>
                        <div class="action-buttons">
                            <button class="button-follow ${fn:contains(followedAlbumIds, albumDetail.id) ? 'active' : ''}" 
                                    onclick="toggleFollow(this, '${albumDetail.id}')">
                                <i class="fas ${fn:contains(followedAlbumIds, albumDetail.id) ? 'fa-user-check' : 'fa-user-plus'}"></i>
                                ${fn:contains(followedAlbumIds, albumDetail.id) ? '팔로잉' : '팔로우'}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="section" id="track-list">
            <h2>수록곡</h2>
            <div class="track-list-container">
                <table class="track-list-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>제목</th>
                            <th>길이</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${album.tracks}" var="track" varStatus="loop">
                            <tr class="track-item">
                                <td class="track-number">${loop.index + 1}</td>
                                <td class="track-title" data-tooltip="${track.name} - ${track.artist}">${track.name}</td>
                                <td class="track-duration">${track.duration}</td>
                                <td class="track-actions">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </div>

    <script>

        function toggleLike(button, trackId) {
            button.classList.toggle('active');
            const isLiked = button.classList.contains('active');
            
            fetch('${pageContext.request.contextPath}/track/like', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    track_id: trackId,
                    liked: isLiked
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('트랙 좋아요 상태가 서버에 성공적으로 반영되었습니다.');
                } else {
                    console.error('트랙 좋아요 실패');
                }
            })
            .catch(error => console.error('오류 발생:', error));
        }
        
        function toggleFollow(button, albumId) {
            button.classList.toggle('active');
            const isFollowing = button.classList.contains('active');
            button.innerHTML = isFollowing ? 
                '<i class="fas fa-user-check"></i> 팔로잉' : 
                '<i class="fas fa-user-plus"></i> 팔로우';
            
            fetch('${pageContext.request.contextPath}/album/follow', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    album_id: albumId,
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
    </script>
</main>
</body>
</html>