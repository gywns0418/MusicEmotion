<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <style>
        .recent-play-container {
            max-width: 100%;
            margin: 0 auto;
            padding: 20px;
        }
        .tab-container {
            display: flex;
            margin-bottom: 30px;
            border-bottom: 2px solid var(--hover-color);
        }
        .tab-button {
            padding: 15px 30px;
            font-size: 16px;
            background: none;
            border: none;
            color: var(--text-color);
            cursor: pointer;
            opacity: 0.7;
            position: relative;
            transition: all 0.3s ease;
        }
        .tab-button::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: var(--primary-color);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        .tab-button.active {
            opacity: 1;
            font-weight: bold;
        }
        .tab-button.active::after {
            transform: scaleX(1);
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* 통계 차트 스타일 */
        .statistics-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .chart-container {
            background-color: var(--card-color);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 6px var(--shadow-color);
        }
        .stats-summary {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: linear-gradient(145deg, var(--card-color), var(--hover-color));
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 6px var(--shadow-color);
        }
        .stat-card h3 {
            font-size: 14px;
            color: var(--text-color);
            opacity: 0.8;
            margin-bottom: 10px;
        }
        .stat-card p {
            font-size: 24px;
            font-weight: bold;
            color: var(--text-color);
        }
        
        /* 최근 재생 목록 스타일 */
        .song-list {
            background-color: var(--card-color);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 6px var(--shadow-color);
        }
        .song-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }
        .song-item:hover {
            background-color: var(--hover-color);
            transform: translateX(5px);
        }
        .song-image {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            margin-right: 15px;
        }
        .song-info {
            flex-grow: 1;
        }
        .song-title {
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--text-color);
        }
        .song-artist {
            color: var(--text-color);
            opacity: 0.7;
            font-size: 14px;
        }
        .song-duration {
            color: var(--text-color);
            opacity: 0.7;
            font-size: 14px;
            margin-left: 15px;
        }
    </style>
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
                    <p>14시간 23분</p>
                </div>
                <div class="stat-card">
                    <h3>총 재생 곡수</h3>
                    <p>247곡</p>
                </div>
                <div class="stat-card">
                    <h3>가장 많이 들은 장르</h3>
                    <p>Pop</p>
                </div>
                <div class="stat-card">
                    <h3>가장 많이 들은 아티스트</h3>
                    <p>BTS</p>
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
            
            // 모든 탭 컨텐츠 숨기기
            for (let content of tabContents) {
                content.classList.remove("active");
            }
            
            // 모든 탭 버튼 비활성화
            for (let button of tabButtons) {
                button.classList.remove("active");
            }
            
            // 선택된 탭 컨텐츠와 버튼 활성화
            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");

            // statistics 탭이 활성화될 때만 차트 초기화
            if (tabName === 'statistics') {
                initializeCharts();
            }
        }

        // 차트 초기화 함수
        function initializeCharts() {
            // 장르 차트
            const genreCtx = document.getElementById('genreChart').getContext('2d');
            new Chart(genreCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Pop', 'K-pop', 'R&B', 'Hip-hop', 'Rock'],
                    datasets: [{
                        data: [30, 25, 20, 15, 10],
                        backgroundColor: [
                            '#FF6384',
                            '#36A2EB',
                            '#FFCE56',
                            '#4BC0C0',
                            '#9966FF'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: '장르별 청취 비율',
                            font: { size: 16 }
                        },
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // 아티스트 차트
            const artistCtx = document.getElementById('artistChart').getContext('2d');
            new Chart(artistCtx, {
                type: 'bar',
                data: {
                    labels: ['BTS', 'IU', 'NewJeans', 'LE SSERAFIM', 'aespa'],
                    datasets: [{
                        label: '재생 횟수',
                        data: [150, 120, 100, 80, 60],
                        backgroundColor: '#36A2EB'
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
        }
    </script>
</body>
</html>