<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 음악 리스트 - AI 음악 추천 서비스</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicList.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
    <jsp:include page="../header.jsp" />
    

        <div id="content-area">
            
 			<div class="hero-section">
                <h1>음악 리스트</h1>
            </div>

            <div class="music-list">
				<c:if test="${not empty tracks}">
					<c:forEach var="track" items="${tracks}">
						<a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${track.id}">
						<div class="music-card">
							<img src="${track.album.images[0].url}" alt="앨범 커버" width="200" height="200">
							<div class="music-info">
								<h3>${track.name}</h3>
								<p>${track.artists[0].name}</p>
							</div>
				
							<div class="button-group">
								<button class="button play-button" onclick="togglePlay(this, '${track.id}')"></button>
								<span class="duration">
									<c:set var="minutes" value="${track.durationMs / 60000}" />
									<c:set var="seconds" value="${(track.durationMs % 60000) / 1000}" />
									<fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
									<fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
								</span>
				           		<button class="button like-button" onclick="toggleLike(this, '${track.id}')"></button>
			       			</div>
		         		</div>
	       				</a>
		 			</c:forEach>  
				</c:if>
				  
				<c:if test="${empty tracks}">
				  	<p>No search results found.</p>
				</c:if>

            </div>
        </div>
    </main>

    <script>
        function togglePlay(button, musicId) {
            button.classList.toggle('active');
            if (button.classList.contains('active')) {
                console.log('재생: ' + musicId);
                // 여기에 음악 재생 로직을 구현하세요
            } else {
                console.log('일시정지: ' + musicId);
                // 여기에 음악 일시정지 로직을 구현하세요
            }
        }

        function toggleLike(button, musicId) {
            button.classList.toggle('active');
            console.log('좋아요 토글: ' + musicId);
            // 여기에 좋아요 상태를 서버에 전송하는 로직을 구현하세요
        }

        function searchMusic() {
            const searchTerm = document.getElementById('search-input').value;
            console.log('검색어: ' + searchTerm);
            // 여기에 검색 로직을 구현하세요
        }
    </script>
</body>
</html>