<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>간단한 플레이리스트</title>
    <style>
        .playlist-container {
            max-width: 80%;
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
            color: white;
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
            color: black;
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


    <div class="playlist-container">
        <div class="playlist-header">
            <img src="${listAll.}" alt="플레이리스트 커버" class="playlist-image">
            <div class="playlist-info">
                <h1>${playlistName}</h1>
                <p>${playlistDescription}</p>
            </div>
        </div>
		<ul class="track-list">
		    <c:forEach items="${tracks}" var="track" varStatus="status">
		    	<a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${track.track.id}">
			        <li class="track-item">
			            <span class="track-number">${status.index + 1}</span>
			            <div class="track-info">
			                <div class="track-title">${track.track.name}</div>
			                <div class="track-artist">
			                    <c:forEach var="artist" items="${track.track.artists}" varStatus="artistStatus">
			                        ${artist.name}<c:if test="${!artistStatus.last}">, </c:if>
			                    </c:forEach>
			                </div>
			            </div>
			            <span class="track-duration">
			                <c:choose>
			                    <c:when test="${track.track.durationMs > 0}">
			                        <c:set var="minutes" value="${track.track.durationMs / 60000}" />
			                        <c:set var="seconds" value="${(track.track.durationMs % 60000) / 1000}" />
			                        <fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
									<fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
			                    </c:when>
			                    <c:otherwise>Unknown</c:otherwise>
			                </c:choose>
			            </span>
			        </li>
		        </a>
		    </c:forEach>
		</ul>


    </div>
    </main>
</body>
</html>