<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>

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

        .verification-container {
            display: none;
            margin-top: 20px;
        }

        .timer {
            color: #dc2626;
            font-size: 14px;
            text-align: center;
            margin-top: 8px;
            font-weight: bold;
        }

        .verification-group {
            position: relative;
        }

        .resend-button {
            background: none;
            border: none;
            color: #1db954;
            font-size: 12px;
            cursor: pointer;
            padding: 5px;
            position: absolute;
            right: 0;
            top: 40px;
            display: none;
        }

        .resend-button:hover {
            text-decoration: underline;
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

        .step {
            display: none;
        }

        .step.active {
            display: block;
        }
    </style>
</head>

<jsp:include page="../header.jsp" />

    <div class="find-id-container">
        <h2>아이디 찾기</h2>
        <p class="description">이름과 이메일로 아이디를 찾을 수 있습니다.</p>

        <form id="findIdForm">
            <!-- Step 1: 이름과 이메일 입력 -->
            <div id="step1" class="step active">
                <div class="form-group">
                    <label for="name" class="form-label">이름</label>
                    <div class="input-wrapper">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        <input type="text" id="name" name="name" class="form-input" placeholder="이름을 입력하세요" required>
                    </div>
                </div>

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

                <button type="button" id="sendVerificationButton" class="submit-button">인증번호 받기</button>
            </div>

            <!-- Step 2: 인증번호 확인 -->
            <div id="step2" class="step">
                <div class="form-group verification-group">
                    <label for="verificationCode" class="form-label">인증번호</label>
                    <div class="input-wrapper">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                        <input type="text" id="verificationCode" name="verificationCode" class="form-input" placeholder="인증번호 6자리를 입력하세요" maxlength="6" required>
                    </div>
                    <button type="button" id="resendButton" class="resend-button">재발송</button>
                    <div id="timer" class="timer"></div>
                </div>

                <button type="button" id="verifyCodeButton" class="submit-button">인증번호 확인</button>
            </div>
        </form>

		<br>
        <div id="errorMessage" class="error-message">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="10"></circle>
                <line x1="12" y1="8" x2="12" y2="12"></line>
                <line x1="12" y1="16" x2="12.01" y2="16"></line>
            </svg>
            <span id="errorText"></span>
        </div>

        <div id="successMessage" class="success-message">
            <div class="success-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20 6L9 17l-5-5"></path>
                </svg>
            </div>
            <h3>인증이 완료되었습니다!</h3>
            <p>입력하신 이메일로 아이디 정보를 발송했습니다.<br>이메일을 확인해주세요.</p>
        </div>

        <div class="login-link">
            <a href="${pageContext.request.contextPath}/member/login.do">로그인 페이지로 돌아가기</a>
        </div>
    </div>
</main>

<script>
	let timer;
	let timeLeft; // timeLeft를 전역 변수로 선언
	const VERIFICATION_TIME = 300; // 5분 (300초)
	
	// 타이머 시작 함수
	function startTimer() {
	    clearInterval(timer); // 기존 타이머가 있다면 제거
	    
	    timeLeft = VERIFICATION_TIME; // timeLeft 초기화
	    const timerElement = document.getElementById('timer');
	    const resendButton = document.getElementById('resendButton');
	    
	    // 타이머 초기화
	    updateTimerDisplay();
	    
	    // 재발송 버튼 숨기기
	    resendButton.style.display = 'none';
	    
	    timer = setInterval(() => {
	        timeLeft--;
	        
	        if (timeLeft <= 0) {
	            clearInterval(timer);
	            timerElement.textContent = '인증시간 만료';
	            resendButton.style.display = 'block'; // 재발송 버튼 표시
	            document.getElementById('verificationCode').disabled = true;
	            document.getElementById('verifyCodeButton').disabled = true;
	        } else {
	            updateTimerDisplay();
	        }
	    }, 1000);
	}
	
	// 타이머 업데이트 함수
	function updateTimerDisplay() {
	    const timerElement = document.getElementById('timer');
	    const minutes = Math.floor(timeLeft / 60);
	    const seconds = timeLeft % 60;
	    timerElement.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
	}
	
	// 오류 메시지 표시 함수
	function showError(message, type = 'error') {
	    const errorMessage = document.getElementById('errorMessage');
	    const errorText = document.getElementById('errorText');
	    
	    errorMessage.style.display = 'block';
	    errorText.textContent = message;
	    
	    if (type === 'success') {
	        errorMessage.style.backgroundColor = '#ecfdf5';
	        errorMessage.style.borderColor = '#6ee7b7';
	        errorMessage.style.color = '#047857';
	    } else {
	        errorMessage.style.backgroundColor = '#fef2f2';
	        errorMessage.style.borderColor = '#fee2e2';
	        errorMessage.style.color = '#dc2626';
	    }
	}
	
	// "인증번호 받기" 버튼 클릭 이벤트
	document.getElementById('sendVerificationButton').addEventListener('click', function() {
	    const name = document.getElementById('name').value;
	    const email = document.getElementById('email').value;
	
	    // 입력 검증
	    if (!name) {
	        showError('이름을 입력해주세요.');
	        return;
	    }
	
	    if (!email) {
	        showError('이메일을 입력해주세요.');
	        return;
	    }
	
	    if (!email.includes('@')) {
	        showError('올바른 이메일 형식이 아닙니다.');
	        return;
	    }
	
	    // 서버로 이름과 이메일 전송
	    fetch('/member/findId', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify({ name, email })
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.success) {
	            document.getElementById('step1').classList.remove('active');
	            document.getElementById('step2').classList.add('active');
	            document.getElementById('verificationCode').disabled = false;
	            document.getElementById('verifyCodeButton').disabled = false;
	            startTimer(); // 타이머 시작
	            alert('인증번호가 이메일로 발송되었습니다.');
	        } else {
	            showError(data.message);
	        }
	    })
	    .catch(error => {
	        showError('서버 오류가 발생했습니다.');
	    });
	});
	
	// "재발송" 버튼 클릭 이벤트
	document.getElementById('resendButton').addEventListener('click', function() {
	    const name = document.getElementById('name').value; // 이름 정보 추가
	    const email = document.getElementById('email').value;

	    // 서버에 재발송 요청
	    fetch('/member/findId', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify({ name, email }) // 이름과 이메일 포함
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.success) {
	            document.getElementById('verificationCode').disabled = false;
	            document.getElementById('verifyCodeButton').disabled = false;
	            document.getElementById('verificationCode').value = '';
	            startTimer(); // 타이머 시작
	            showError('인증번호가 재발송되었습니다.', 'success');
	        } else {
	            showError(data.message);
	        }
	    })
	    .catch(error => {
	        showError('서버 오류가 발생했습니다.');
	    });
	});

	
	// "인증번호 확인" 버튼 클릭 이벤트
	document.getElementById('verifyCodeButton').addEventListener('click', function() {
	    const code = document.getElementById('verificationCode').value;
	
	    if (!code) {
	        showError('인증번호를 입력해주세요.');
	        return;
	    }
	
	    if (code.length !== 6) {
	        showError('인증번호는 6자리여야 합니다.');
	        return;
	    }
	
	    // 서버에 인증번호 확인 요청
	    fetch('/member/checkNumber.do', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify({ 
	            email: document.getElementById('email').value,
	            code: code 
	        })
	    })
	    .then(response => response.json())
	    .then(data => {
	        if (data.success) {
	            clearInterval(timer);
	            document.getElementById('step2').classList.remove('active');
	            document.getElementById('errorMessage').style.display = 'none';
	            document.getElementById('successMessage').style.display = 'block';
	        } else {
	            showError(data.message);
	        }
	    })
	    .catch(error => {
	        showError('서버 오류가 발생했습니다.');
	    });
	});

</script>

</body>
</html>