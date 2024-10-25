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
	                        <c:forEach var="emotion" items="${emotion}">
	                        	<option value="${emotion.emotion_id}">${emotion.emotion_name}</option>
	                        </c:forEach>
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
							    <c:forEach var="genre" items="${genres}">
							        <option value="${genre}">${genre}</option>
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
			<a href="${pageContext.request.contextPath}/spotify/musicDetail.do">musicDetail</a>
			<a href="${pageContext.request.contextPath}/spotify/musicList.do">musicList.do</a>
			<a href="${pageContext.request.contextPath}/playlist/playListMain.do">playListMain</a>
			<a href="${pageContext.request.contextPath}/spotify/resentPlay.do">resentPlay.do</a>
			<a href="${pageContext.request.contextPath}/album/album.do">album.do</a>
			<a href="${pageContext.request.contextPath}/artist/artist.do">artist.do</a>
			<br>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property='principal.name'/>/user_name`
				<br>
				<sec:authentication property='principal.username'/>/user_id
			</sec:authorize>
	
		<script>
		    $(document).ready(function() {
		        const contextPath = "${pageContext.request.contextPath}";
		
		        $('#mood-form').on('submit', function(e) {
		            e.preventDefault();
		
		            const mood = $('#mood').val();
		            const genre = $('#genre').val();
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
		                },
		                error: function(jqXHR, textStatus, errorThrown) {
		                    console.error("AJAX Error: " + textStatus + ": " + errorThrown);
		                    console.error("Response Text: " + jqXHR.responseText);
		                    playlistSection.html('<p>추천을 가져오는 데 실패했습니다. 다시 시도해 주세요.</p>');
		                }
		            });
		        });
		    });
		</script>


</main>
</body>
</html>