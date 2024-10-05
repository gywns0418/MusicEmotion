<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<jsp:include page="header.jsp" />

	        <div id="content-area">
	            <div class="hero-section">
	                <h1>당신만의 음악 여행을 시작하세요</h1>
	                <p>AI가 추천하는 맞춤형 플레이리스트로 새로운 음악을 발견하세요.</p>
	                <a class="cta-button" href="${pageContext.request.contextPath}/member/login.do">지금 시작하기</a>
	            </div>
	
	        <div class="recommendation-form">
	            <h2>맞춤 음악 추천</h2>
	            <form id="mood-form">
	                <div class="form-group">
	                    <label for="mood">현재 감정:</label>
	                    <select id="mood" name="mood">
	                        <option value="happy">행복</option>
	                        <option value="sad">슬픔</option>
	                        <option value="excited">신남</option>
	                        <option value="relaxed">편안</option>
	                    </select>
	                </div>
	                <div class="form-group">
	                    <label for="activity">현재 활동:</label>
	                    <select id="activity" name="activity">
	                        <option value="working">일하는 중</option>
	                        <option value="exercising">운동 중</option>
	                        <option value="relaxing">휴식 중</option>
	                        <option value="studying">공부 중</option>
	                    </select>
	                </div>
	                <div class="form-group">
	                    <label for="genre">선호 장르:</label>
	                    <select id="genre" name="genre">
	                        <option value="pop">팝</option>
	                        <option value="rock">록</option>
	                        <option value="classical">클래식</option>
	                        <option value="jazz">재즈</option>
	                        <option value="hiphop">힙합</option>
	                    </select>
	                </div>
	                <button type="submit">음악 추천받기</button>
	            </form>
	        </div>
	
				<div class="section" id="playlist-section">
				    <!-- 추천 플레이리스트 섹션이 여기에 동적으로 추가됩니다 -->
				</div>
	
	            <div class="section">
	            <h2>최근 인기 플레이리스트</h2>
	            <div class="playlist-grid">
	                <div class="playlist-card">
	                    <img src="https://via.placeholder.com/300" alt="플레이리스트 커버">
	                    <div class="playlist-title">인기 팝 모음</div>
	                    <div class="playlist-description">최신 팝 히트곡 모음</div>
	                </div>
	                <div class="playlist-card">
	                    <img src="https://via.placeholder.com/300" alt="플레이리스트 커버">
	                    <div class="playlist-title">집중을 위한 클래식</div>
	                    <div class="playlist-description">공부와 일에 집중하기 좋은 클래식</div>
	                </div>
	                <div class="playlist-card">
	                    <img src="https://via.placeholder.com/300" alt="플레이리스트 커버">
	                    <div class="playlist-title">운동할 때 듣기 좋은 음악</div>
	                    <div class="playlist-description">에너지 넘치는 비트</div>
	                </div>
	                <div class="playlist-card">
	                    <img src="https://via.placeholder.com/300" alt="플레이리스트 커버">
	                    <div class="playlist-title">편안한 재즈</div>
	                    <div class="playlist-description">휴식과 함께하는 재즈 선율</div>
	                </div>
	            </div>
	        </div>
	        </div>
			<a href="commu/musicDetail.do">musicDetail</a>
			<a href="commu/musicList.do">musicList.do</a>
			<a href="commu/playListMain.do">playListMain</a>
			<a href="commu/resentPlay.do">resentPlay.do</a>
			
	
	    <script>
	        $(document).ready(function() {
	
	            document.getElementById('mood-form').addEventListener('submit', function(e) {
	                e.preventDefault();
	                
	                const playlistSection = document.getElementById('playlist-section');
	                playlistSection.innerHTML = '<p>플레이리스트를 생성 중입니다...</p>';
	                
	                // 여기에 실제 AI 추천 로직을 추가하세요
	                setTimeout(() => {
	                    let recommendationContent = `
	                        <h2>추천 플레이리스트</h2>
	                        <div class="playlist-grid" id="recommendation-result">
	                    `;
	                    
	                    // 6개의 추천 플레이리스트를 생성
	                    for (let i = 0; i < 6; i++) {
	                        recommendationContent += `
	                            <div class="playlist-card">
	                                <img src="https://via.placeholder.com/300" alt="플레이리스트 커버">
	                                <div class="playlist-title">추천 플레이리스트 ${i+1}</div>
	                                <div class="playlist-description">AI가 추천하는 맞춤 음악</div>
	                            </div>
	                        `;
	                    }
	                    
	                    recommendationContent += `</div>`;
	                    playlistSection.innerHTML = recommendationContent;
	                }, 2000);
	            });      

	        });
	    </script>

</main>
</body>
</html>