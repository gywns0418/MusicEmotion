<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스 - 게시글 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .post-detail-container {
            background-color: var(--card-color);
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 4px 6px var(--shadow-color);
            max-width: 800px;
            margin: 20px auto;
        }

        .post-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .post-title {
            color: var(--highlight-color);
            margin-bottom: 10px;
        }

        .post-meta {
            font-size: 14px;
            color: #888;
        }

        .post-content {
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .comment-section {
            margin-top: 30px;
        }

        .comment-list {
            list-style-type: none;
            padding: 0;
        }

        .comment-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }

        .comment-author {
            font-weight: bold;
            margin-right: 10px;
        }

        .comment-date {
            font-size: 12px;
            color: #888;
        }

        .comment-form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .comment-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        .comment-submit {
            background-color: var(--highlight-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .post-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .post-action-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
            background-color: var(--highlight-color);
            color: white;
        }

        .delete-btn {
            background-color: #dc3545;
        }

        .post-action-btn:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="post-detail-container">
        <div class="post-header">
            <h2 class="post-title">이번 주 최고의 플레이리스트를 공유합니다!</h2>
            <div class="post-meta">
                <span class="author">작성자: 음악매니아</span>
                <span class="date">2024-09-23</span>
                <span class="comments">댓글: 15</span>
            </div>
        </div>
        <div class="post-content">
            <p>안녕하세요, 음악 팬 여러분! 이번 주에 AI가 추천해준 노래들로 만든 최고의 플레이리스트를 공유하고자 합니다. 다양한 장르를 아우르는 이 플레이리스트는 여러분의 일상에 활력을 불어넣어줄 거예요.</p>
            <p>1. "Blinding Lights" - The Weeknd<br>
               2. "Dynamite" - BTS<br>
               3. "drivers license" - Olivia Rodrigo<br>
               4. "Leave The Door Open" - Silk Sonic<br>
               5. "Save Your Tears" - The Weeknd & Ariana Grande</p>
            <p>이 노래들은 각각 독특한 매력을 가지고 있어요. 여러분도 한번 들어보시고 느낌을 공유해주세요!</p>
        </div>
        <div class="post-actions">
            <button class="post-action-btn" onclick="location.href='notice/noticeList.do'">글 목록</button>
            <button class="post-action-btn" onclick="location.href='editPost.jsp?id=1'">글 수정</button>
            <button class="post-action-btn delete-btn" onclick="confirmDelete()">글 삭제</button>
        </div>
        <div class="comment-section">
            <h3>댓글</h3>
            <ul class="comment-list">
                <li class="comment-item">
                    <span class="comment-author">음악애호가</span>
                    <span class="comment-date">2024-09-23 15:30</span>
                    <p>와우, 정말 좋은 선곡이네요! 특히 BTS의 Dynamite는 제 최애곡이에요.</p>
                </li>
                <li class="comment-item">
                    <span class="comment-author">팝뮤직팬</span>
                    <span class="comment-date">2024-09-23 16:45</span>
                    <p>The Weeknd의 노래들이 두 곡이나 있네요. 역시 인기가 많아요!</p>
                </li>
            </ul>
            <form class="comment-form">
                <textarea class="comment-input" placeholder="댓글을 입력하세요" rows="3"></textarea>
                <button type="submit" class="comment-submit">댓글 작성</button>
            </form>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 필요한 경우 여기에 JavaScript 로직을 추가하세요
        });

        function confirmDelete() {
            if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
                // 여기에 삭제 로직을 추가하세요
                alert("글이 삭제되었습니다.");
                window.location.href = 'notice/noticeList.do';
            }
        }
    </script>
</body>
</html>