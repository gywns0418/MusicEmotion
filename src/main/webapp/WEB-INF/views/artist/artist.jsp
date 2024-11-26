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
            
	        <div class="artist-grid">
	            <c:forEach items="${artistList}" var="artist">
	                <a href="${pageContext.request.contextPath}/artist/artistDetail.do?artist_id=${artist.id}">
	                    <div class="artist-card">
	                        <div class="artist-image-container">
	                            <img src="${artist.images[0].url}" alt="${artist.name}" class="artist-image">
	                        </div>
	                        <div class="artist-name">${artist.name}</div>
	                        <div class="artist-genre">
							    <c:choose>
							        <c:when test="${not empty artist.genres}">
							            <c:forEach items="${artist.genres}" var="genre" varStatus="status">
							                ${genre}<c:if test="${!status.last}">, </c:if>
							            </c:forEach>
							        </c:when>
							        <c:otherwise>
							            장르 없음
							        </c:otherwise>
							    </c:choose>
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
    

</body>
</html>