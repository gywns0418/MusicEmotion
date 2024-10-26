<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${artistDetail.name} - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/artist.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<jsp:include page="../header.jsp" />

<div id="content-area">
    <!-- 아티스트 헤더 섹션 -->
    <div class="artist-header" style="background-image: url('${artistImageUrl}')">
        <div class="header-overlay">
            <div class="artist-profile">
                <div class="artist-image-container">
                    <img src="${artistImageUrl}" alt="${artistDetail.name}" class="artist-image">
                </div>
                <div class="artist-info">
                    <div class="artist-title">
                        <h1>${artistDetail.name}</h1>
                    </div>
                    <p class="artist-genre">${artistGenre}</p>
                    <div class="artist-stats">
                        <div class="stat-item">
                            <span class="stat-value">${popularity}</span>
                            <span class="stat-label">인기도</span>
                        </div>
                        <div class="stat-divider"></div>
                        <div class="stat-item">
                            <span class="stat-value">${followers}</span>
                            <span class="stat-label">팔로워</span>
                        </div>
                    </div>
                    <div class="action-buttons">
					    <button class="button-follow ${fn:contains(followedArtistIds, artistDetail.id) ? 'active' : ''}" 
					            onclick="toggleFollow(this, '${artistDetail.id}')">
					        <i class="fas ${fn:contains(followedArtistIds, artistDetail.id) ? 'fa-user-check' : 'fa-user-plus'}"></i>
					        ${fn:contains(followedArtistIds, artistDetail.id) ? '팔로잉' : '팔로우'}
					    </button>
					</div>
                </div>
            </div>
        </div>
    </div>

    <!-- 인기 트랙 섹션 -->
    <div class="section popular-tracks">
        <div class="section-header">
            <h2>인기 트랙</h2>
        </div>
        <div class="track-list">
            <c:forEach items="${popularTracks}" var="track" varStatus="status">
                <div class="track-item">
                    <div class="track-number">${status.index + 1}</div>
                    <img src="${track.albumCover}" alt="${track.albumName}" class="track-album-cover">
                    <div class="track-info">
                        <span class="track-name">${track.name}</span>
                        <span class="track-album">${track.albumName}</span>
                    </div>
					<div class="track-duration">
					    <span class="duration">
							<c:set var="minutes" value="${track.durationMs / 60000}" />
							<c:set var="seconds" value="${(track.durationMs % 60000) / 1000}" />
							<fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
							<fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
					    </span>
					</div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 앨범 섹션 -->
    <div class="section artist-albums">
        <div class="section-header">
            <h2>앨범</h2>
            <div class="album-filters">
                <button class="filter-button active">전체</button>
            </div>
        </div>
        <div class="album-grid">
            <c:forEach var="album" items="${albums}">
                <div class="album-card">
                    <div class="album-cover-container">
                        <img src="${album.images[0].url}" alt="${album.name}" class="album-cover">
                        <div class="album-hover-overlay">
                            <button class="album-play-button">▶</button>
                        </div>
                    </div>
                    <div class="album-info">
                        <h3 class="album-title">${album.name}</h3>
                        <p class="album-details">
                            <span class="album-year">${fn:substring(album.releaseDate, 0, 4)}</span>
                            <span class="album-type">${album.albumType}</span>
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 팔로우 버튼 토글


    // 앨범 필터 토글
    $('.filter-button').click(function() {
        $('.filter-button').removeClass('active');
        $(this).addClass('active');
    });

    // 트랙 호버 효과
    $('.track-item').hover(
        function() {
            $(this).find('.play-button').fadeIn(200);
        },
        function() {
            $(this).find('.play-button').fadeOut(200);
        }
    );

    // 앨범 호버 효과
    $('.album-card').hover(
        function() {
            $(this).find('.album-hover-overlay').fadeIn(200);
        },
        function() {
            $(this).find('.album-hover-overlay').fadeOut(200);
        }
    );
});

function toggleFollow(button, artistId) {
    button.classList.toggle('active');
    const isFollowing = button.classList.contains('active');
    button.innerHTML = isFollowing ? 
        '<i class="fas fa-user-check"></i> 팔로잉' : 
        '<i class="fas fa-user-plus"></i> 팔로우';
    
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
</script>

</body>
</html>