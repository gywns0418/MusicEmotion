<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팔로우한 아티스트 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/artist/artist.css">

</head>
<body>
    <jsp:include page="../header.jsp" />

	    <div class="artist-container">
	        <div class="hero-section">
	            <h1>Followed Artist</h1>
	            <p>내가 팔로우한 아티스트들을 한눈에 보세요</p>
	        </div>
	
	         <div class="search">
			    <div class="search-bar">
			        <input type="text" id="artistSearch" placeholder="아티스트 이름으로 검색하기...">
			        <i class="fas fa-search search-icon" id="searchIcon"></i>
			    </div>
			</div>
            
	        <div class="artist-grid">
	            <c:forEach items="${artistList}" var="artist">
	                <a href="${pageContext.request.contextPath}/artist/artistDetail.do?artist_id=${artist.id}">
	                    <div class="artist-card">
	                        <div class="artist-image-container">
	                            <img src="${artist.images[0].url}" alt="${artist.name}" class="artist-image">
	                        </div>
	                        <div class="artist-name">${artist.name}</div>
	                        <div class="artist-genre">
	                            <c:forEach items="${artist.genres}" var="genre" varStatus="status">
	                                ${genre}<c:if test="${!status.last}">, </c:if>
	                            </c:forEach>
	                        </div>
	                        <div class="artist-stats">
	                            <div class="stat-item">
	                                <span class="stat-value">${artist.followers.total}</span>
	                                <span class="stat-label">팔로워</span>
	                            </div>
	                            <div class="stat-item">
	                                <span class="stat-value">${artist.popularity}</span>
	                                <span class="stat-label">인기도</span>
	                            </div>
	                        </div>
	                    </div>
	                </a>
	            </c:forEach>
	        </div>
	    </div>
    </main>
    
	<script>
	    // 검색 함수
	    function searchArtists() {
	        const artistName = document.getElementById('artistSearch').value;
			console.log(artistName)
	        // 입력값 검증
	        if (!artistName) {
	            alert('아티스트 이름을 입력하세요.');
	            return;
	        }
	
	        // 서버로 검색 요청
	        fetch(`/artist/search?name=artistName`)
	            .then(response => response.json())
	            .then(data => {
	                const resultsContainer = document.getElementById('searchResults');
	                resultsContainer.innerHTML = '';
	
	                if (data.success && data.artists.length > 0) {
	                    data.artists.forEach(artist => {
	                        const artistElement = document.createElement('div');
	                        artistElement.classList.add('artist-card');
	                        artistElement.innerHTML = `
	                            <div class="artist-image-container">
	                                <img src="${artist.images[0].url}" alt="${artist.name}" class="artist-image">
	                            </div>
	                            <div class="artist-name">${artist.name}</div>
	                            <div class="artist-genre">${artist.genres?.join(', ') || '장르 없음'}</div>
	                            <div class="artist-stats">
	                                <div class="stat-item">
	                                    <span class="stat-value">${artist.followers?.total || 0}</span>
	                                    <span class="stat-label">팔로워</span>
	                                </div>
	                                <div class="stat-item">
	                                    <span class="stat-value">${artist.popularity || 0}</span>
	                                    <span class="stat-label">인기도</span>
	                                </div>
	                            </div>
	                        `;
	                        resultsContainer.appendChild(artistElement);
	                    });
	                } else {
	                    resultsContainer.innerHTML = `<p>검색 결과가 없습니다.</p>`;
	                }
	            })
	            .catch(error => {
	                alert('검색 중 오류가 발생했습니다.');
	                console.error(error);
	            });
	    }
	
	    // 버튼 및 아이콘 클릭 이벤트 리스너
	    document.getElementById('searchButton')?.addEventListener('click', searchArtists);
	    document.getElementById('searchIcon')?.addEventListener('click', searchArtists);
	
	    // Enter 키로도 검색 가능하도록 추가
	    document.getElementById('artistSearch').addEventListener('keyup', function (event) {
	        if (event.key === 'Enter') {
	            searchArtists();
	        }
	    });
	</script>
</body>
</html>