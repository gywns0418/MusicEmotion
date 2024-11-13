<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>최근 재생 - MusicEmotion</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/resentPlay.css">

</head>
<body>
    <jsp:include page="../header.jsp" />
    
    <div class="recent-play-container">
        <div class="hero-section">
            <h1>My Music History</h1>
            <p>나만의 음악 여정을 확인해보세요</p>
        </div>

        <div class="tab-container">
            <button class="tab-button active" onclick="openTab(event, 'recentList')">최근 재생 목록</button>
            <button class="tab-button" onclick="openTab(event, 'statistics')">청취 통계</button>
        </div>

        <!-- 최근 재생 목록 탭 -->
        <div id="recentList" class="tab-content active">
            <div class="song-list">
                <c:if test="${not empty track}">
                    <c:forEach var="track" items="${track}">
                        <a href="${pageContext.request.contextPath}/spotify/musicDetail.do?song_id=${track.id}">
                            <div class="song-item">
                                <img src="${track.album.images[0].url}" class="song-image" alt="앨범 커버">
                                <div class="song-info">
                                    <div class="song-title">${track.name}</div>
                                    <div class="song-artist">${track.artists[0].name}</div>
                                </div>
                                <div class="song-duration">
                                    <span class="duration">
                                        <c:set var="minutes" value="${track.durationMs / 60000}" />
                                        <c:set var="seconds" value="${(track.durationMs % 60000) / 1000}" />
                                        <fmt:formatNumber value="${minutes}" maxFractionDigits="0" />:
                                        <fmt:formatNumber value="${seconds}" maxFractionDigits="0" pattern="00" />
                                    </span>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:if>
            </div>
        </div>

        <!-- 청취 통계 탭 -->
        <div id="statistics" class="tab-content">
            <div class="stats-summary">
                <div class="stat-card">
                    <h3>총 재생 시간</h3>
					<c:set var="totalMinutes" value="${song_count * 3}" />
					
					<c:choose>
					    <c:when test="${totalMinutes >= 60}">
					        <c:set var="hours" value="${totalMinutes div 60}" />
							<c:set var="minutes" value="${totalMinutes % 60}" />
							<p><fmt:formatNumber value="${hours}" type="number" maxFractionDigits="0"/>시간 ${minutes}분</p>
					    </c:when>
					    <c:otherwise>
					        <p>${totalMinutes}분</p>
					    </c:otherwise>
					</c:choose>
                </div>
                <div class="stat-card">
                    <h3>총 재생 곡수</h3>
                    <p>${song_count}곡</p>
                </div>
                <div class="stat-card">
                    <h3>가장 많이 들은 장르</h3>
                    <p>${most_genre}</p>
                </div>
                <div class="stat-card">
                    <h3>가장 많이 들은 아티스트</h3>
                    <p>${most_artist}</p>
                </div>
            </div>

            <div class="statistics-grid">
                <div class="chart-container">
                    <canvas id="genreChart"></canvas>
                </div>
                <div class="chart-container">
                    <canvas id="artistChart"></canvas>
                </div>
            </div>
        </div>
    </div>

	<script>
	    // 탭 전환 함수
	    function openTab(evt, tabName) {
	        const tabContents = document.getElementsByClassName("tab-content");
	        const tabButtons = document.getElementsByClassName("tab-button");
	
	        for (let content of tabContents) {
	            content.classList.remove("active");
	        }
	
	        for (let button of tabButtons) {
	            button.classList.remove("active");
	        }
	
	        document.getElementById(tabName).classList.add("active");
	        evt.currentTarget.classList.add("active");
	
	        if (tabName === 'statistics') {
	            initializeCharts();
	        }
	    }
	
	    // 차트 초기화 변수
	    let genreChart, artistChart;
	
	    // 랜덤 색상 생성 함수
	    function getRandomColor() {
	        const letters = '0123456789ABCDEF';
	        let color = '#';
	        for (let i = 0; i < 6; i++) {
	            color += letters[Math.floor(Math.random() * 16)];
	        }
	        return color;
	    }
	
	    async function initializeCharts() {
	        try {
	            // 서버에서 상위 재생 곡 데이터를 가져옴
	            const response = await fetch('/recentPlayed/topSongs.do');
	            const topSongsData = await response.json();
	            
	            console.log("topSongsData",topSongsData)
	
	            // song_id와 play_count를 배열로 나눔
	            const labels = topSongsData.map(item => item.trackname);
	            const data = topSongsData.map(item => item.PLAY_COUNT);
	
	            console.log("labels : ",labels)
	            console.log("data : ",data)
	            
	            // 데이터 개수만큼 랜덤 색상 생성
	            const colors = data.map(() => getRandomColor());
	
	            // 장르 차트 업데이트 또는 생성
	            const genreCtx = document.getElementById('genreChart').getContext('2d');
	            if (!genreChart) {
	                genreChart = new Chart(genreCtx, {
	                    type: 'doughnut',
	                    data: {
	                        labels: labels,
	                        datasets: [{
	                            data: data,
	                            backgroundColor: colors
	                        }]
	                    },
	                    options: {
	                        responsive: true,
	                        plugins: {
	                            title: {
	                                display: true,
	                                text: '상위 재생 곡 비율',
	                                font: { size: 16 }
	                            },
	                            legend: {
	                                position: 'bottom'
	                            }
	                        }
	                    }
	                });
	            } else {
	                genreChart.data.labels = labels;
	                genreChart.data.datasets[0].data = data;
	                genreChart.data.datasets[0].backgroundColor = colors;
	                genreChart.update();
	            }
	
	            // 아티스트 차트도 비슷한 방식으로 업데이트 또는 생성
	            const artistCtx = document.getElementById('artistChart').getContext('2d');
	            if (!artistChart) {
	                artistChart = new Chart(artistCtx, {
	                    type: 'bar',
	                    data: {
	                        labels: labels,
	                        datasets: [{
	                            label: '재생 횟수',
	                            data: data,
	                            backgroundColor: colors
	                        }]
	                    },
	                    options: {
	                        responsive: true,
	                        plugins: {
	                            title: {
	                                display: true,
	                                text: '아티스트별 재생 횟수',
	                                font: { size: 16 }
	                            },
	                            legend: {
	                                display: false
	                            }
	                        },
	                        scales: {
	                            y: {
	                                beginAtZero: true
	                            }
	                        }
	                    }
	                });
	            } else {
	                artistChart.data.labels = labels;
	                artistChart.data.datasets[0].data = data;
	                artistChart.data.datasets[0].backgroundColor = colors;
	                artistChart.update();
	            }
	        } catch (error) {
	            console.error("데이터를 가져오는 중 오류가 발생했습니다:", error);
	        }
	    }
	</script>


</main>
</body>
</html>