<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member/myPage.css">

	<script>
        function showPlaylistModal() {
            document.getElementById('playlistModal').style.display = 'block';
        }
        
        function closePlaylistModal() {
            document.getElementById('playlistModal').style.display = 'none';
        }
        
        function previewImage(event) {
            const file = event.target.files[0];
            const reader = new FileReader();

            reader.onload = function() {
                const preview = document.getElementById('imagePreview');
                preview.src = reader.result;
                preview.style.display = 'block';
            };

            if (file) {
                reader.readAsDataURL(file);
            }
        }

        function createPlaylist() {
            const title = document.getElementById('playlistTitle').value;
            const description = document.getElementById('playlistDescription').value;
            const imagePreview = document.getElementById('imagePreview').src;
            
            const link = "${pageContext.request.contextPath}/playlist/playListMain.do";

            if (!title || !description || !imagePreview) {
                alert('모든 필드를 입력하세요.');
                return;
            }

            const playlistGrid = document.querySelector('.section:nth-child(3) .playlist-grid');

            // 새로운 카드 요소 생성
            const newCard = document.createElement('div');
            newCard.classList.add('playlist-card');

            newCard.innerHTML = 
            	'<a href="'+ link +'">'+
                '<img src="' + imagePreview + '" alt="' + title + '">' +
                '<div class="playlist-title">' + title + '</div>' +
                '<div class="playlist-description">' + description + '</div>'+
                '</a>';

            // 카드 추가
            playlistGrid.appendChild(newCard);

            // 모달 닫기 및 초기화
            closePlaylistModal();
            document.getElementById('playlistTitle').value = '';
            document.getElementById('playlistDescription').value = '';
            document.getElementById('playlistImage').value = '';
            document.getElementById('imagePreview').style.display = 'none';
        }

    </script>

</head>


<jsp:include page="../header.jsp" />


    <div id="content-area">
	    <div class="hero-section">
	        <h1>마이 뮤직</h1>
	        <p>나만의 음악 세계를 탐험하세요</p>
	    </div>
	
	    <div class="section">
	        <h2>내 라이브러리</h2>
	        <div class="playlist-grid">
	        	<a href="${pageContext.request.contextPath}/recentPlayed/resentPlay.do">
		            <div class="playlist-card">
		                <img src="${pageContext.request.contextPath}/images/play.jpg" alt="최근 재생" width="300" height="300">
		                <div class="playlist-title">최근 재생</div>
		                <div class="playlist-description">최근에 들은 곡들</div>
		            </div>
	            </a>
	            <a href="${pageContext.request.contextPath}/likes/likes.do">
		            <div class="playlist-card">
		                <img src="${pageContext.request.contextPath}/images/likes.jpg" alt="좋아요 표시한 곡" width="300" height="300">
		                <div class="playlist-title">좋아요 표시한 곡</div>
		                <div class="playlist-description">I'm Yours</div>
		            </div>
	            </a>
	            <a href="${pageContext.request.contextPath}/artist/artist.do">
		            <div class="playlist-card">
		                <img src="${pageContext.request.contextPath}/images/artist.jpg" alt="아티스트" width="300" height="300">
		                <div class="playlist-title">아티스트</div>
		                <div class="playlist-description">내가 팔로우한 아티스트</div>
		            </div>
	            </a>
	            <a href="${pageContext.request.contextPath}/album/album.do">
		            <div class="playlist-card">
		                <img src="${pageContext.request.contextPath}/images/album.jpg" alt="앨범" width="300" height="300">
		                <div class="playlist-title">앨범</div>
		                <div class="playlist-description">저장한 앨범 모음</div>
		            </div>
	            </a>
	        </div>
	    </div>
	
	    <div class="section">
	        <h2>내 플레이리스트</h2>
	        <button class="cta-button" onclick="showPlaylistModal()">새 플레이리스트 만들기</button>	<br><br>
	
	        <div class="playlist-grid">
	        	<a href="${pageContext.request.contextPath}/playlist/playListMain.do?playlist_id=37i9dQZF1DX9tPFwDMOaN1">
		            <div class="playlist-card">
		                <img src="${pageContext.request.contextPath}/images/playlist.jpg" alt="플레이리스트" width="300" height="300">
		                <div class="playlist-title">내 플레이리스트 1</div>
		                <div class="playlist-description">좋아하는 팝송 모음</div>
		            </div>
	            </a>

	        </div>
	    </div>
	
		<div id="playlistModal" class="modal">
		    <div class="modal-content">
		        <span class="close" onclick="closePlaylistModal()">&times;</span>
		        <h2>새 플레이리스트 만들기</h2>
		        <form action="${pageContext.request.contextPath}/playlist/addPlaylist.do" method="post" onsubmit="createPlaylist(); return false;"> 
		            <input type="hidden" name="user_id" value="<sec:authentication property='principal.username'/>">
		            <label for="playlistTitle">타이틀:</label>
		            <input type="text" id="playlistTitle" name="playlistTitle" required>
		            
		            <label for="playlistDescription">설명:</label>
		            <textarea id="playlistDescription" name="playlistDescription" required></textarea>
		
					<label for="playlistImage">이미지:</label>
					<input type="file" id="playlistImage" name="playlistImage" accept="image/*" onchange="previewImage(event)">
					<img id="imagePreview" style="display:none; max-width: 300px; margin-top: 10px;">
		
		            <button type="submit" class="button">생성</button>
		        </form>
		    </div>
		</div>
		
	</div>
</main>
</body>
</html>