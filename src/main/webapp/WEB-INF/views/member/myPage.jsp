<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .main-content {
            padding: 20px;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .nav-menu {
            list-style-type: none;
            padding: 0;
        }
        .nav-menu li {
            margin-bottom: 15px;
        }

        .section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #191414;
        }
        .playlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .playlist-card {
            background-color: #f7f7f7;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.2s;
        }
        .playlist-card:hover {
            transform: translateY(-5px);
        }
        .playlist-card img {
            width: 100%;
            height: auto;
        }
        .playlist-title {
            font-weight: bold;
            padding: 10px;
        }
        .playlist-description {
            font-size: 14px;
            color: #666;
            padding: 0 10px 10px;
        }
        .button {
            background-color: #1db954;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.2s;
        }
        .button:hover {
            background-color: #1ed760;
        }
    </style>
</head>


<jsp:include page="../header.jsp" />

<main>
    <div id="content-area">
	    <div class="hero-section">
	        <h1>마이 뮤직</h1>
	        <p>나만의 음악 세계를 탐험하세요</p>
	    </div>
	
	    <div class="section">
	        <h2>내 라이브러리</h2>
	        <div class="playlist-grid">
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="최근 재생">
	                <div class="playlist-title">최근 재생</div>
	                <div class="playlist-description">최근에 들은 곡들</div>
	            </div>
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="즐겨찾기">
	                <div class="playlist-title">즐겨찾기</div>
	                <div class="playlist-description">자주 듣는 곡 모음</div>
	            </div>
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="아티스트">
	                <div class="playlist-title">아티스트</div>
	                <div class="playlist-description">내가 팔로우한 아티스트</div>
	            </div>
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="앨범">
	                <div class="playlist-title">앨범</div>
	                <div class="playlist-description">저장한 앨범 모음</div>
	            </div>
	        </div>
	    </div>
	
	    <div class="section">
	        <h2>내 플레이리스트</h2>
	        <button class="cta-button">새 플레이리스트 만들기</button>	<br><br>

	        <div class="playlist-grid">
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="플레이리스트 1">
	                <div class="playlist-title">내 플레이리스트 1</div>
	                <div class="playlist-description">좋아하는 팝송 모음</div>
	            </div>
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="플레이리스트 2">
	                <div class="playlist-title">내 플레이리스트 2</div>
	                <div class="playlist-description">운동할 때 듣는 음악</div>
	            </div>
	            <!-- 더 많은 플레이리스트 카드를 추가할 수 있습니다 -->
	        </div>
	    </div>
	
	    <div class="section">
	        <h2>좋아요 표시한 곡</h2>
	        <div class="playlist-grid">
	            <div class="playlist-card">
	                <img src="https://via.placeholder.com/300" alt="좋아요 표시한 곡">
	                <div class="playlist-title">좋아요 표시한 곡</div>
	                <div class="playlist-description">I'm Yours</div>
	            </div>
	        </div>
	    </div>
	</div>
</main>
</body>
</html>