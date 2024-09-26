<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스 - 커뮤니티</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .community-container {
            background-color: var(--card-color);
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 4px 6px var(--shadow-color);
        }

        .community-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .community-header h2 {
            color: var(--highlight-color);
            margin-bottom: 0;
        }

        .new-post-button {
            background-color: var(--highlight-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }

        .new-post-button:hover {
            background-color: #1ed760;
            transform: scale(1.05);
        }

        .post-list {
            list-style-type: none;
        }

        .post-item {
            border-bottom: 1px solid #eee;
            padding: 16px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .post-item:last-child {
            border-bottom: none;
        }

        .post-title {
            font-weight: bold;
            color: var(--text-color);
            text-decoration: none;
            transition: color 0.3s;
        }

        .post-title:hover {
            color: var(--highlight-color);
        }

        .post-meta {
            font-size: 12px;
            color: #888;
        }

        .pagination {
            display: flex;
            justify-content: center;
            list-style-type: none;
            margin-top: 20px;
        }

        .pagination li {
            margin: 0 5px;
        }

        .pagination a {
            color: var(--text-color);
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
            transition: background-color 0.3s;
        }

        .pagination a:hover, .pagination .active a {
            background-color: var(--highlight-color);
            color: white;
        }
    </style>
</head>
<body>
        <div class="community-container">
            <div class="community-header">
                <h2>커뮤니티 게시판</h2>
                <button class="new-post-button" onclick="window.location.href='commu/addCommu.do'">새 글 작성</button>
            </div>
            
            <ul class="post-list">
                <li class="post-item">
                    <a href="commu/commuContent.do?post_id=1" class="post-title">이번 주 최고의 플레이리스트를 공유합니다!</a>
                    <div class="post-meta">
                        <span class="author">작성자: 음악매니아</span>
                        <span class="date">2024-09-23</span>
                        <span class="comments">댓글: 15</span>
                    </div>
                </li>
                <li class="post-item">
                    <a href="#" class="post-title">AI 추천 시스템에 대한 의견을 들려주세요</a>
                    <div class="post-meta">
                        <span class="author">작성자: AI연구원</span>
                        <span class="date">2024-09-22</span>
                        <span class="comments">댓글: 32</span>
                    </div>
                </li>
                <c:forEach var="postList" items="${commuList}">
	                <li class="post-item">
	                    <a href="commu/commuContent.do?post_id=${postList.post_id}" class="post-title">${postList.title}</a>
	                    <div class="post-meta">
	                        <span class="author">작성자: ${postList.member_name} </span>
	                        <span class="date">2024-09-22 /${postList.created_at}</span>
	                        <span class="comments">댓글: 32</span>
	                    </div>
	                </li>
                </c:forEach>
            </ul>
            <ul class="pagination">
                <li><a href="#">&laquo;</a></li>
                <li><a href="#" class="active">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&raquo;</a></li>
            </ul>
        </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 기존 스크립트 로직을 여기에 추가
        });
    </script>
</body>
</html>