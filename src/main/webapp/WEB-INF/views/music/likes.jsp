<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

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
            	<h1>좋아요 표시한 음악</h1>
            	<p>내가 좋아요 표시한 곡들입니다</p>
            </div>
           

            <div class="music-list">
                <c:forEach var="song" items="${songs}">
                
                    <div class="music-card">
                    	<a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${song.id}">
                        <img src="${song.album.images[0].url}" alt="앨범 커버">
                        <div class="music-info">
                            <h3>${song.name}</h3> <!-- 곡 제목 -->
                            <p>
                                <c:forEach var="artist" items="${song.artists}">
                                    ${artist.name}
                                    <c:if test="${!artistStatus.last}">, </c:if>
                                </c:forEach>
                            </p> <!-- 아티스트 이름 -->
                        </div>
                        </a>
                        <div class="button-group">
                            <button class="button play-button" onclick="togglePlay(this, '${song.id}')"></button>
								<span class="duration">
									<c:set var="minutes" value="${song.durationMs / 60000}" />
									<c:set var="seconds" value="${(song.durationMs % 60000) / 1000}" />
									<fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
									<fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
								</span>
                            	<!-- 좋아요 여부 확인 후 active 클래스 추가 -->
	                            <button class="button like-button ${fn:contains(likedSongIds, track.id) ? 'active' : ''}" 
	                                onclick="toggleLike(this, '${song.id}')">
	                            </button>
                        </div>
                    </div>
                
                </c:forEach>
                

            </div>
        </div>
    </main>

    <script>

	    function toggleLike(button, musicId) {
	        button.classList.toggle('active');
	        console.log('좋아요 토글: ' + musicId);
	
	        // 좋아요 상태를 서버에 전송하는 로직
	        let isLiked = button.classList.contains('active');	
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


        function searchMusic() {
            const searchTerm = document.getElementById('search-input').value;
            console.log('검색어: ' + searchTerm);
            // 여기에 검색 로직을 구현하세요
        }
    </script>
</body>
</html>