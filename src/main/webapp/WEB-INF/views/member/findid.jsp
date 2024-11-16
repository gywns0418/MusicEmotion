<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
        }

        .find-id-container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 40px auto;
        }

        .find-id-container h2 {
            color: #1db954;
            text-align: center;
            margin-bottom: 24px;
            font-size: 24px;
        }

        .description {
            text-align: center;
            color: #666;
            margin-bottom: 32px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333333;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .form-input {
            width: 100%;
            padding: 12px;
            padding-left: 40px;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-input:focus {
            border-color: #1db954;
            outline: none;
            box-shadow: 0 0 0 2px rgba(29, 185, 84, 0.1);
        }

        .error-message {
            color: #dc2626;
            background-color: #fef2f2;
            border: 1px solid #fee2e2;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 20px;
            display: none;
            font-size: 14px;
        }

        .submit-button {
            background-color: #1db954;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            transition: all 0.3s;
        }

        .submit-button:hover {
            background-color: #1ed760;
            transform: scale(1.02);
        }

        .submit-button:disabled {
            background-color: #9CA3AF;
            cursor: not-allowed;
            transform: none;
        }

        .loading-spinner {
            display: none;
            margin-right: 8px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .success-message {
            text-align: center;
            display: none;
            padding: 20px;
        }

        .success-icon {
            background-color: #ecfdf5;
            color: #1db954;
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .login-link {
            text-align: center;
            margin-top: 24px;
        }

        .login-link a {
            color: #1db954;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .login-link a:hover {
            color: #1ed760;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<jsp:include page="../header.jsp" />

<main>
    <div class="find-id-container">
        <h2>아이디 찾기</h2>
        <p class="description">가입 시 등록한 이메일로 아이디를 찾을 수 있습니다.</p>

        <form id="findIdForm" action="findId.do" method="POST">
            <div class="form-group">
                <label for="email" class="form-label">이메일</label>
                <div class="input-wrapper">
                    <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                        <polyline points="22,6 12,13 2,6"></polyline>
                    </svg>
                    <input type="email" id="email" name="email" class="form-input" placeholder="가입하신 이메일을 입력하세요" required>
                </div>
            </div>

            <div id="errorMessage" class="error-message">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="12" y1="8" x2="12" y2="12"></line>
                    <line x1="12" y1="16" x2="12.01" y2="16"></line>
                </svg>
                <span id="errorText"></span>
            </div>

            <button type="submit" id="submitButton" class="submit-button">
                <span id="loadingSpinner" class="loading-spinner">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"></circle>
                    </svg>
                </span>
                이메일로 아이디 받기
            </button>
        </form>

        <div id="successMessage" class="success-message">
            <div class="success-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20 6L9 17l-5-5"></path>
                </svg>
            </div>
            <h3>이메일이 발송되었습니다!</h3>
            <p>입력하신 이메일로 아이디 정보를 발송했습니다.<br>이메일을 확인해주세요.</p>
        </div>

        <div class="login-link">
            <a href="${pageContext.request.contextPath}/member/login.do">로그인 페이지로 돌아가기</a>
        </div>
    </div>
</main>

<script>
    document.getElementById('findIdForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const email = document.getElementById('email').value;
        const errorMessage = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        const submitButton = document.getElementById('submitButton');
        const loadingSpinner = document.getElementById('loadingSpinner');
        const successMessage = document.getElementById('successMessage');
        
        // 이메일 유효성 검사
        if (!email) {
            errorMessage.style.display = 'block';
            errorText.textContent = '이메일을 입력해주세요.';
            return;
        }
        
        if (!email.includes('@')) {
            errorMessage.style.display = 'block';
            errorText.textContent = '올바른 이메일 형식이 아닙니다.';
            return;
        }

        // 로딩 상태 표시
        errorMessage.style.display = 'none';
        submitButton.disabled = true;
        loadingSpinner.style.display = 'inline-block';
        
        // 여기에 실제 서버 요청 코드를 작성하세요
        // 예시: form.submit();
        
        // 데모를 위한 타이머 (실제 구현시에는 제거)
        setTimeout(function() {
            submitButton.disabled = false;
            loadingSpinner.style.display = 'none';
            document.querySelector('form').style.display = 'none';
            successMessage.style.display = 'block';
        }, 1500);
    });
</script>

</body>
</html>