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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
            position: relative;
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
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus, textarea:focus {
            border-color: var(--highlight-color);
            box-shadow: 0 0 0 2px rgba(30, 215, 96, 0.2);
            outline: none;
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

        .character-count {
            position: absolute;
            right: 10px;
            bottom: 10px;
            font-size: 12px;
            color: #888;
        }

        .form-icons {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            color: #888;
        }

        .form-group input[type="text"],
        .form-group textarea {
            padding-left: 30px;
        }

        .preview-button {
            background-color: #f0f0f0;
            color: #333;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin-right: 10px;
            transition: background-color 0.3s;
        }

        .preview-button:hover {
            background-color: #e0e0e0;
        }

        .button-group {
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }

        .preview-modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .preview-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 800px;
            border-radius: 8px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="new-post-container">
        <h2>새 글 작성</h2>
        <form class="new-post-form" action="submitPost" method="POST">
        	<!-- <input type="hidden" name="member_name" value="<sec:authentication property='principal.username'/>">-->
            <div class="form-group">
                <label for="post-title">제목</label>
                <input type="text" id="post-title" name="title" required maxlength="100"> 
                <span class="character-count">0 / 100</span>
            </div>
            <div class="form-group">
                <label for="post-content">내용</label>
                <textarea id="post-content" name="content" required maxlength="1000"></textarea>
                <span class="character-count">0 / 1000</span>
            </div>
            <div class="button-group">
                <button type="button" class="preview-button" onclick="previewPost()">미리보기</button>
                <button type="submit" class="submit-button">글 작성</button>
            </div>
        </form>
    </div>

    <div id="previewModal" class="preview-modal">
        <div class="preview-content">
            <span class="close">&times;</span>
            <div class="preview-header">
                <h2 id="previewTitle" class="preview-title"></h2>
                <div class="preview-meta">
                    <span class="author">작성자: <span id="previewAuthor"></span></span>
                    <span class="date" id="previewDate"></span>
                </div>
            </div>
            <div id="previewContent" class="preview-body"></div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 글자 수 카운트 기능
            $('input[type="text"], textarea').on('input', function() {
                var charCount = $(this).val().length;
                var maxLength = $(this).attr('maxlength');
                $(this).siblings('.character-count').text(charCount + ' / ' + maxLength);
            });

            // 모달 닫기 기능
            $('.close').click(function() {
                $('#previewModal').hide();
            });

            $(window).click(function(event) {
                if (event.target == document.getElementById('previewModal')) {
                    $('#previewModal').hide();
                }
            });
        });

        // 미리보기 기능
        function previewPost() {
            var title = $('#post-title').val();
            var content = $('#post-content').val();
            var author = $('input[name="member_name"]').val();
            var currentDate = new Date().toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' });
            
            $('#previewTitle').text(title);
            $('#previewAuthor').text(author);
            $('#previewDate').text(currentDate);
            $('#previewContent').html(content.replace(/\n/g, '<br>'));
            $('#previewModal').show();
        }
    </script>
</body>
</html>