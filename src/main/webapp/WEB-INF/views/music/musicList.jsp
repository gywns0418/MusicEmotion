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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>
<body>
    <jsp:include page="../header.jsp" />
    

        <div id="content-area">
            
 			<div class="hero-section">
                <h1>음악 리스트</h1>
            </div>

			<h1>Track</h1>
            <div class="music-list">
            
				<c:if test="${not empty tracks}">
					<c:forEach var="track" items="${tracks}">
						
						<div class="music-card">
							<a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${track.id}">
								<img src="${track.album.images[0].url}" alt="앨범 커버" width="200" height="200">
								<div class="music-info">
									<h3>${track.name}</h3>
									<p>${track.artists[0].name}</p>
								</div>
							</a>
							<div class="button-group"><br>
								<span class="duration">
									<c:set var="minutes" value="${track.durationMs / 60000}" />
									<c:set var="seconds" value="${(track.durationMs % 60000) / 1000}" />
									<fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
									<fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
								</span>
				      			<!-- 좋아요 여부 확인 후 active 클래스 추가 -->
	                            <button class="button like-button ${fn:contains(likedSongIds, track.id) ? 'active' : ''}" 
	                                onclick="toggleLike(this, '${track.id}')">
	                            </button>
			       			</div>
		         		</div>
	       				
		 			</c:forEach>  
				</c:if>
				  
				<c:if test="${empty tracks}">
				  	<p>No search results found.</p>
				</c:if>

            </div>
            <br>
            <h1>Album</h1>
            <div class="music-list">
            
				<c:if test="${not empty tracks}">
					<c:forEach var="album" items="${Album}">
						
						<div class="music-card">
						<a href="${pageContext.request.contextPath}/album/albumDetail.do?album_id=${album.id}">
							<img src="${album.images[0].url}" alt="앨범 커버" width="200" height="200">
							<div class="music-info">
								<h3>${album.name}</h3>
								<p>${album.artists[0].name}</p>
							</div>
						</a>
							<div class="button-group"><br>
								<span class="duration">
									${album.getReleaseDate()}
								</span>
		                        <div class="action-buttons">
		                            <button class="button-follow ${fn:contains(followedAlbumIds, album.id) ? 'active' : ''}" 
		                                    onclick="toggleFollow(this, '${album.id}')">
		                                <i class="fas ${fn:contains(followedAlbumIds, album.id) ? 'fa-user-check' : 'fa-user-plus'}"></i>
		                                ${fn:contains(followedAlbumIds, album.id) ? '팔로잉' : '팔로우'}
		                            </button>
		                        </div>
			       			</div>
		         		</div>
	       				
		 			</c:forEach>  
				</c:if>
				  
				<c:if test="${empty tracks}">
				  	<p>No search results found.</p>
				</c:if>

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
    
        
        function toggleFollow(button, albumId) {
            button.classList.toggle('active');
            const isFollowing = button.classList.contains('active');
            console.log('팔로우: ' + isFollowing);
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
</body>
</html>