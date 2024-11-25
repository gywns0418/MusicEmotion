<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member/myPage.css">

    <!-- jQuery 라이브러리 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function showPlaylistModal() {
        document.getElementById('playlistModal').style.display = 'block';
    }
    
    function closePlaylistModal() {
        document.getElementById('playlistModal').style.display = 'none';
    }
    
    function previewImage(event) {
        const imagePreview = document.getElementById('imagePreview');
        imagePreview.src = URL.createObjectURL(event.target.files[0]);
        imagePreview.style.display = 'block';
    }

    // Ajax로 플레이리스트 생성
	function addPlaylist() {
	    console.log("addPlaylist 함수 호출됨");
	    const formData = new FormData();
	    formData.append("title", $('#playlistTitle').val());
	    formData.append("description", $('#playlistDescription').val());
	    formData.append("image", $('#playlistImage')[0].files[0]);
	
	    $.ajax({
	        url: "${pageContext.request.contextPath}/playlist/addPlaylistAjax",
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(playlist) {
	        	console.log("playlist", playlist)
				const newCard = 
				    '<div class="playlist-card" data-playlist-id="' + playlist.playlist_id + '">' +
				        '<button class="delete-btn" onclick="deletePlaylist(' + playlist.playlist_id + ')">&times;</button>' +
				        '<a href="${pageContext.request.contextPath}/playlist/playListMain.do?playlist_id=' + playlist.playlist_id + '">' +
				            '<img src="${pageContext.request.contextPath}/uploads/' + playlist.image + '" alt="' + playlist.title + '">' +
				            '<div class="playlist-title">' + playlist.title + '</div>' +
				            '<div class="playlist-description">' + playlist.description + '</div>' +
				        '</a>' +
				    '</div>';
	            $('#playlistGrid').append(newCard);
	            resetForm();
	            closePlaylistModal();
	        },
	        error: function(error) {
	            console.error(error);
	            alert('플레이리스트 추가 실패');
	        }
	    });
	}


    // 폼 및 미리보기 초기화 함수
    function resetForm() {
        $('#playlistTitle').val('');
        $('#playlistDescription').val('');
        $('#playlistImage').val('');
        $('#imagePreview').hide();
    }
    
    function deletePlaylist(playlistId) {
        if (confirm('플레이리스트를 삭제하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/playlist/deletePlaylistAjax",
                type: 'POST',
                data: { playlist_id: playlistId },
                success: function(response) {
                    // 성공적으로 삭제되면 페이지 리로드
                    alert('플레이리스트가 성공적으로 삭제되었습니다.');
                    location.reload(); // 페이지를 리로드합니다.
                },
                error: function(error) {
                    console.error(error);
                    alert('플레이리스트 삭제 실패');
                }
            });
        }
    }

</script>

</head>


<jsp:include page="../header.jsp" />

<div id="content-area">
    <div class="hero-section">
        <h1>My Music</h1>
        <p>나만의 음악 세계를 탐험하세요</p>
        <button class="edit-profile-btn" onclick="location.href='${pageContext.request.contextPath}/member/myEdit.do'">내 정보 수정</button>
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
        <button class="cta-button" onclick="showPlaylistModal()">새 플레이리스트 만들기</button><br><br>

		<div id="playlistGrid" class="playlist-grid">
		    <c:forEach var="playlist" items="${plist}">
		        <div class="playlist-card">
		            <button class="delete-btn" onclick="deletePlaylist(${playlist.playlist_id})">&times;</button>
		            <a href="${pageContext.request.contextPath}/playlist/myPlayList.do?playlist_id=${playlist.playlist_id}">
		                <img src="${pageContext.request.contextPath}/uploads/${playlist.image}" alt="${playlist.title}">
		                <div class="playlist-title">${playlist.title}</div>
		                <div class="playlist-description">${playlist.description}</div>
		            </a>
		        </div>
		    </c:forEach>
		</div>
    </div>

	<div id="playlistModal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closePlaylistModal()">&times;</span>
	        <h2>새 플레이리스트 만들기</h2>
	        <form id="playlistForm" enctype="multipart/form-data" onsubmit="event.preventDefault(); addPlaylist();">
	            <input type="hidden" name="user_id" value="<sec:authentication property='principal.username'/>">
	            
	            <label for="playlistTitle">타이틀:</label>
	            <input type="text" id="playlistTitle" name="title" required>
	
	            <label for="playlistDescription">설명:</label>
	            <textarea id="playlistDescription" name="description" required></textarea>
	
	            <label for="playlistImage">이미지:</label>
	            <input type="file" id="playlistImage" name="image" accept="image/*" onchange="previewImage(event)">
	            <img id="imagePreview" style="display:none; max-width: 300px; margin-top: 10px;">
	
	            <button type="button" class="button" onclick="addPlaylist()">생성</button>
	        </form>
	    </div>
	</div>

</div>
</body>
</html>