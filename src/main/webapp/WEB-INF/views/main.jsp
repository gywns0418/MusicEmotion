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
    <style type="text/css">
    .emotion-selector {
    padding: 20px;
    margin: 20px 0;
}

.emotion-grid {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    gap: 15px;
    max-width: 100%;
    margin: 0 auto;
}

.emotion-item {
    position: relative;
    cursor: pointer;
    text-align: center;
    padding: 15px;
    border-radius: 12px;
    background: #f8f9fa;
    transition: all 0.3s ease;
}

.emotion-item:hover {
    transform: translateY(-5px);
    background: #e9ecef;
}

.emotion-item.selected {
    background: #4263eb;
    color: white;
}

.emotion-emoji {
    font-size: 2.5rem;
    margin-bottom: 8px;
    display: block;
}

.emotion-label {
    font-size: 0.9rem;
    font-weight: 500;
}

input[type="radio"] {
    position: absolute;
    opacity: 0;
}

input[type="radio"]:checked + .emotion-item {
    background: #4263eb;
    color: white;
    box-shadow: 0 4px 12px rgba(66, 99, 235, 0.2);
}
    </style>
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
            <label>현재 감정을 선택하세요:</label>
            <div class="emotion-selector">
                <div class="emotion-grid">
                    <c:forEach var="emotion" items="${emotion}">
                        <div>
                            <input type="radio" id="emotion${emotion.emotion_id}" name="mood" value="${emotion.emotion_id}">
                            <label class="emotion-item" for="emotion${emotion.emotion_id}">
                                <c:choose>
                                    <c:when test="${emotion.emotion_id == 1}">
                                        <span class="emotion-emoji">😊</span>
                                    </c:when>
                                    <c:when test="${emotion.emotion_id == 2}">
                                        <span class="emotion-emoji">😢</span>
                                    </c:when>
                                    <c:when test="${emotion.emotion_id == 3}">
                                        <span class="emotion-emoji">😌</span>
                                    </c:when>
                                    <c:when test="${emotion.emotion_id == 4}">
                                        <span class="emotion-emoji">😠</span>
                                    </c:when>
                                    <c:when test="${emotion.emotion_id == 5}">
                                        <span class="emotion-emoji">😰</span>
                                    </c:when>
                                    <c:when test="${emotion.emotion_id == 6}">
                                        <span class="emotion-emoji">🥰</span>
                                    </c:when>
                                </c:choose>
                                <span class="emotion-label">${emotion.emotion_name}</span>
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>
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
							    <c:forEach var="genre" items="${genres}">
							        <option value="${genre.genres}">${genre.genres}</option>
							    </c:forEach>
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
						
					    <c:forEach var="playlist" items="${popularPlaylists}">
					    <a href="playlist/playListMain.do?playlist_id=${playlist.id}">
					        <div class="playlist-card">
					            <img src="${playlist.images[0].url}" alt="플레이리스트 커버">
					            <div class="playlist-title">${playlist.name}</div>
					            <div class="playlist-description">${playlist.description}</div>
					        </div>
					  	</a>
					    </c:forEach>
	
		            </div>
 				</div>
	        
	</div>
	<script>
		$(document).ready(function() {
		    const contextPath = "${pageContext.request.contextPath}";

		    $('#mood-form').on('submit', function(e) {
		        e.preventDefault();

		        // 선택된 라디오 버튼의 값을 가져옴
		        const mood = $('input[name="mood"]:checked').val();
		        const genre = $('#genre').val();
		        
		        // 감정이 선택되지 않았을 경우 처리
		        if (!mood) {
		            alert('감정을 선택해주세요.');
		            return;
		        }

		        console.log("Selected mood:", mood);
		        console.log("Selected genre:", genre);
		        
		        const playlistSection = $('#playlist-section');
		        playlistSection.html('<p>플레이리스트를 생성 중입니다...</p>');

		        $.ajax({
		            url: contextPath + "/emotion/recommendMusic.do",
		            type: "POST",
		            data: {
		                emotion_id: mood,
		                genre: genre
		            },
		            success: function(response) {
		                // contextPath를 클라이언트 측에서 response 내용에 추가
		                response = response.replaceAll('href=\'/spotify', 'href=\'' + contextPath + '/spotify');
		                playlistSection.html(response);
		                
		                // 선택된 감정 항목 시각적 표시 유지
		                $('.emotion-item').removeClass('selected');
		                $(`label[for="emotion${mood}"]`).addClass('selected');
		            },
		            error: function(jqXHR, textStatus, errorThrown) {
		                console.error("AJAX Error: " + textStatus + ": " + errorThrown);
		                console.error("Response Text: " + jqXHR.responseText);
		                playlistSection.html('<p>추천을 가져오는 데 실패했습니다. 다시 시도해 주세요.</p>');
		            }
		        });
		    });

		    // 감정 선택 시 시각적 피드백
		    $('input[name="mood"]').on('change', function() {
		        $('.emotion-item').removeClass('selected');
		        $(this).next('.emotion-item').addClass('selected');
		    });
		});
	</script>
</main>
</body>
</html>