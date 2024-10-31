<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            max-width: 100%;
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
           	<div class="hero-section">
                <h1>최근 재생</h1>
                <p>지난 30일 동안 들은 곡들입니다</p>
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
            
            <br>
            
            <div class="song-list">
                <c:if test="${not empty track}">
	                <c:forEach var="track" items="${track}">
	                	<a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${track.id}">
			                <div class="song-item">
			                    <img src="${track.album.images[0].url}" class="song-image" alt="앨범 커버" width="200" height="200">
			                    <div class="song-info">
			                        <div class="song-title">${track.name}</div>
			                        <div class="song-artist">${track.artists[0].name}</div>
			                    </div>
			                    <div class="song-duration">								
			                    	<span class="duration">
										<c:set var="minutes" value="${track.durationMs / 60000}" />
										<c:set var="seconds" value="${(track.durationMs % 60000) / 1000}" />
										<fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
										<fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
									</span>
								</div>
			                </div>
		                </a>
	                </c:forEach>
                </c:if>
            </div>
        </div>
    </main>
</body>
</html>