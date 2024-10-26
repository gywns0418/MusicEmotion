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
    <style>
        .artist-container {
            max-width: 100%;
            margin: 0 auto;
        }

        .hero-section {
            text-align: center;
            margin-bottom: 40px;
            padding: 40px 0;
            background: linear-gradient(to right, var(--highlight-color), #4a90e2);
            border-radius: 16px;
            color: white;
        }

        .hero-section h1 {
            font-size: 2.5em;
            margin-bottom: 16px;
            font-weight: 700;
        }

        .hero-section p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .artist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }

        .artist-card {
            background-color: var(--card-color);
            border-radius: 16px;
            height: 400px; /* 고정된 높이 */
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 24px;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 6px var(--shadow-color);
            position: relative;
            overflow: hidden;
        }

        .artist-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 160px;
            background: linear-gradient(45deg, var(--highlight-color), #4a90e2);
            opacity: 0.1;
            transition: opacity 0.3s;
        }

        .artist-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .artist-card:hover::before {
            opacity: 0.2;
        }

        .artist-image-container {
            position: relative;
            width: 200px;
            height: 200px;
            margin-bottom: 24px;
            border-radius: 50%;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .artist-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .artist-card:hover .artist-image {
            transform: scale(1.1);
        }

        .artist-name {
            font-size: 1.5em;
            font-weight: 700;
            margin-bottom: 12px;
            color: var(--text-color);
            text-align: center;
            width: 100%;
        }

        .artist-genre {
            font-size: 0.95em;
            color: var(--text-color);
            opacity: 0.8;
            text-align: center;
            max-width: 90%;
            margin: 0 auto;
            line-height: 1.4;
        }

        .artist-stats {
            display: flex;
            gap: 20px;
            margin-top: auto;
            padding-top: 20px;
            border-top: 1px solid var(--hover-color);
            width: 100%;
            justify-content: center;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 4px;
        }

        .stat-value {
            font-weight: 700;
            color: var(--highlight-color);
        }

        .stat-label {
            font-size: 0.85em;
            color: var(--text-color);
            opacity: 0.7;
        }

        /* 반응형 디자인 개선 */
        @media (max-width: 768px) {
            .artist-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 20px;
            }

            .artist-card {
                height: 380px;
            }

            .artist-image-container {
                width: 180px;
                height: 180px;
            }
        }

        @media (max-width: 480px) {
            .artist-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .hero-section {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />

	    <div class="artist-container">
	        <div class="hero-section">
	            <h1>팔로우한 아티스트</h1>
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
</body>
</html>