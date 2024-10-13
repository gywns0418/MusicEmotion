<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팔로우한 아티스트 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .artist-container {
            max-width: 100%;
            margin: 0 auto;
            padding: 20px;
        }
        .artist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }
        .artist-card {
            background-color: var(--card-color);
            border-radius: 8px;
            padding: 16px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 4px var(--shadow-color);
        }
        .artist-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px var(--shadow-color);
        }
        .artist-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 16px;
            object-fit: cover;
        }
        .artist-name {
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--text-color);
        }
        .artist-genre {
            font-size: 14px;
            color: var(--text-color);
            opacity: 0.7;
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .search-bar input {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--hover-color);
            border-radius: 20px;
            font-size: 16px;
        }
    </style>
</head>

    <jsp:include page="../header.jsp" />

        <div class="artist-container">
            <div class="hero-section">
                <h1>팔로우한 아티스트</h1>
                <p>내가 팔로우한 아티스트들을 한눈에 보세요</p>
            </div>

            <div class="search-bar">
                <input type="text" placeholder="아티스트 검색...">
            </div>

            <div class="artist-grid">
            	<a href="${pageContext.request.contextPath}/album/albumDetail.do">
	                <div class="artist-card">
	                    <img src="/api/placeholder/150/150" alt="BTS" class="artist-image">
	                    <div class="artist-name">BTS</div>
	                    <div class="artist-genre">K-Pop</div>
	                </div>
	            </a>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Adele" class="artist-image">
                    <div class="artist-name">Adele</div>
                    <div class="artist-genre">Pop</div>
                </div>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Ed Sheeran" class="artist-image">
                    <div class="artist-name">Ed Sheeran</div>
                    <div class="artist-genre">Pop</div>
                </div>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Beyoncé" class="artist-image">
                    <div class="artist-name">Beyoncé</div>
                    <div class="artist-genre">R&B</div>
                </div>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Coldplay" class="artist-image">
                    <div class="artist-name">Coldplay</div>
                    <div class="artist-genre">Alternative Rock</div>
                </div>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Taylor Swift" class="artist-image">
                    <div class="artist-name">Taylor Swift</div>
                    <div class="artist-genre">Pop</div>
                </div>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Drake" class="artist-image">
                    <div class="artist-name">Drake</div>
                    <div class="artist-genre">Hip-Hop</div>
                </div>
                <div class="artist-card">
                    <img src="/api/placeholder/150/150" alt="Ariana Grande" class="artist-image">
                    <div class="artist-name">Ariana Grande</div>
                    <div class="artist-genre">Pop</div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>