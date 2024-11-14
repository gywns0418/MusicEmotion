<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팔로우한 앨범 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .album-container {
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

        .album-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }

        .album-card {
            background-color: var(--card-color);
            border-radius: 16px;
            height: 420px;
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

        .album-card::before {
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

        .album-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .album-image-container {
            position: relative;
            width: 200px;
            height: 200px;
            margin-bottom: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .album-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .album-card:hover .album-image {
            transform: scale(1.1);
        }

        .album-name {
            font-size: 1.5em;
            font-weight: 700;
            margin-bottom: 8px;
            color: var(--text-color);
            text-align: center;
            width: 100%;
        }

        .album-artist {
            font-size: 1.1em;
            color: var(--text-color);
            opacity: 0.8;
            text-align: center;
            margin-bottom: 12px;
        }

        .album-release {
            font-size: 0.9em;
            color: var(--text-color);
            opacity: 0.7;
            margin-bottom: 12px;
        }

        .album-stats {
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

        
        .search {
            max-width: 600px;
            margin: 2rem auto 3rem;
            padding: 0 1rem;
        }

        .search-bar {
            position: relative;
            width: 100%;
            display: flex;
            align-items: center;
        }

        .search-bar input {
            width: 100%;
            padding: 1rem 3.5rem 1rem 1.5rem;
            font-size: 1rem;
            color: var(--text-color);
            background-color: var(--card-color);
            border: 2px solid transparent;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .album-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 20px;
            }

            .album-card {
                height: 400px;
            }

            .album-image-container {
                width: 180px;
                height: 180px;
            }
        }

        @media (max-width: 480px) {
            .album-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../header.jsp" />

    <div class="album-container">
        <div class="hero-section">
            <h1>Followed Album</h1>
            <p>내가 팔로우한 앨범들을 한눈에 보세요</p>
        </div>

        <div class="search">
            <div class="search-bar">
                <input type="text" id="albumSearch" placeholder="앨범 또는 아티스트 이름으로 검색하기...">
                <i class="fas fa-search search-icon"></i>
            </div>
        </div>
        
        <div class="album-grid">
			<c:forEach items="${albumDetails}" var="album">
			    <a href="${pageContext.request.contextPath}/album/albumDetail.do?album_id=${album.id}">
			        <div class="album-card">
			            <div class="album-image-container">
							<img src="${album.imageUrl}" alt="${album.name}" class="album-image">			            </div>
			            <div class="album-name">${album.name}</div>
			            <div class="album-artist">${album.artistName}</div>
			            <div class="album-release">${album.releaseDate}</div>
			            <div class="album-stats">
			                <div class="stat-item">
			                    <span class="stat-value">${album.totalTracks}</span>
			                    <span class="stat-label">수록곡</span>
			                </div>
			                <div class="stat-item">
			                    <span class="stat-value">${album.popularity}</span>
			                    <span class="stat-label">인기도</span>
			                </div>
			            </div>
			        </div>
			    </a>
			</c:forEach>
			<c:out value="${album.imageUrl}" />
        </div>
    </div>
</body>
</html>