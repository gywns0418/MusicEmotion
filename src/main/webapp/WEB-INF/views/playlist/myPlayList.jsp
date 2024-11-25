<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 플레이리스트</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .playlist-container {
            max-width: 80%;
            margin: 2rem auto;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .playlist-header {
            background: linear-gradient(45deg, #1db954, #1ed760);
            color: white;
            padding: 2rem;
            display: flex;
            align-items: center;
        }
        .playlist-image {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .playlist-info h1 {
            margin: 0 0 1rem 0;
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
        }
        .playlist-info p {
            margin: 0;
            opacity: 0.9;
            font-size: 1.1rem;
            line-height: 1.6;
        }
        .track-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        .empty-playlist {
            text-align: center;
            padding: 4rem 2rem;
            color: #666;
        }
        .empty-playlist i {
            font-size: 3rem;
            color: #1db954;
            margin-bottom: 1rem;
        }
        .empty-playlist p {
            font-size: 1.2rem;
            margin: 0;
        }
        .track-item {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #eee;
            transition: background-color 0.2s;
            text-decoration: none;
            color: inherit;
        }
        .track-item:hover {
            background-color: #f8f8f8;
        }
        .track-item:last-child {
            border-bottom: none;
        }
        .track-number {
            font-size: 0.9rem;
            color: #999;
            width: 30px;
        }
        .track-album-cover {
            width: 60px;
            height: 60px;
            border-radius: 6px;
            margin: 0 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .track-info {
            flex-grow: 1;
            margin-right: 1rem;
        }
        .track-title {
            color: #333;
            font-weight: 600;
            margin-bottom: 0.3rem;
            font-size: 1.1rem;
        }
        .track-artist {
            font-size: 0.9rem;
            color: #666;
        }
        .track-duration {
            color: #999;
            font-size: 0.9rem;
            margin-right: 1rem;
        }
        .delete-btn {
            padding: 0.5rem 1rem;
            background-color: #ff5555;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 0.9rem;
        }
        .delete-btn:hover {
            background-color: #ff3333;
        }
        .track-wrapper {
            display: flex;
            align-items: center;
            width: 100%;
            text-decoration: none;
            color: inherit;
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>


<jsp:include page="../header.jsp" />

<div class="playlist-container">
    <div class="playlist-header">
        <img src="${pageContext.request.contextPath}/uploads/${listId.image}" alt="플레이리스트 커버" class="playlist-image">
        <div class="playlist-info">
            <h1>${listId.title}</h1>
            <p>${listId.description}</p>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty tracks}">
            <div class="empty-playlist">
                <i class="fas fa-music"></i>
                <p>등록된 곡이 없습니다.</p>
            </div>
        </c:when>
        <c:otherwise>
            <ul class="track-list">
                <c:forEach items="${tracks}" var="tracks" varStatus="status">
                    <li class="track-item">
                        <a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${tracks.id}" class="track-wrapper">
                            <span class="track-number">${status.index + 1}</span>
                            <img src="${tracks.album.images[0].url}" alt="${tracks.name}" class="track-album-cover">
                            <div class="track-info">
                                <div class="track-title">${tracks.name}</div>
                                <div class="track-artist">
                                    <c:forEach var="artist" items="${tracks.artists}" varStatus="artistStatus">
                                        ${artist.name}<c:if test="${!artistStatus.last}">, </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <span class="track-duration">
                                <c:choose>
                                    <c:when test="${tracks.durationMs > 0}">
                                        <c:set var="minutes" value="${tracks.durationMs / 60000}" />
                                        <c:set var="seconds" value="${(tracks.durationMs % 60000) / 1000}" />
                                        <fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
                                        <fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
                                    </c:when>
                                </c:choose>
                            </span>
                        </a>
                        <button class="delete-btn" onclick="deleteTrack('${tracks.id}')">
                            <i class="fas fa-trash"></i>
                        </button>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>

<script>
function deleteTrack(trackId) {
    if (confirm('정말로 이 곡을 삭제하시겠습니까?')) {
        fetch('${pageContext.request.contextPath}/playlistSong/deleteTrack.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                trackId: trackId,
                playlist_id: '${listId.playlist_id}'
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            } else {
                alert('곡 삭제에 실패했습니다. 다시 시도해주세요.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('오류가 발생했습니다. 다시 시도해주세요.');
        });
    }
}
</script>

</body>
</html>