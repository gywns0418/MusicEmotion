<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스 - 새 글 작성</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .new-post-container {
            background-color: var(--card-color);
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 4px 6px var(--shadow-color);
            max-width: 800px;
            margin: 20px auto;
        }

        .new-post-form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: var(--text-color);
            font-weight: bold;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        textarea {
            height: 200px;
            resize: vertical;
        }

        .submit-button {
            background-color: var(--highlight-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            align-self: flex-start;
            transition: background-color 0.3s, transform 0.3s;
        }

        .submit-button:hover {
            background-color: #1ed760;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="new-post-container">
        <h2>새 글 작성</h2>
        <form class="new-post-form" action="submitPost" method="POST">
            <div class="form-group">
                <label for="post-title">제목</label>
                <input type="text" id="post-title" name="title" required>
            </div>
            <div class="form-group">
                <label for="post-content">내용</label>
                <textarea id="post-content" name="content" required></textarea>
            </div>
            <button type="submit" class="submit-button">글 작성</button>
        </form>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 필요한 경우 여기에 JavaScript 로직을 추가하세요
        });
    </script>
</body>
</html>