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