<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    const pageContextPath ="${pageContext.request.contextPath}";
</script>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>

        .reset-container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 40px auto;
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 32px;
        }

        .step {
            display: flex;
            align-items: center;
            margin: 0 15px;
        }

        .step-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #e5e7eb;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 8px;
            font-weight: bold;
        }

        .step.active .step-number {
            background-color: #1db954;
            color: white;
        }

        .step-text {
            font-size: 14px;
            color: #666;
        }

        .step.active .step-text {
            color: #1db954;
            font-weight: bold;
        }

        h2 {
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

        .verification-group {
            display: flex;
            gap: 10px;
        }

        .verification-input {
            flex: 1;
        }

        .verify-button {
            background-color: #4F46E5;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            white-space: nowrap;
            transition: all 0.3s;
        }

        .verify-button:hover {
            background-color: #4338CA;
            transform: scale(1.02);
        }

        .timer {
            color: #dc2626;
            font-size: 14px;
            margin-top: 8px;
            text-align: right;
        }

        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 8px;
            padding-left: 16px;
        }

        .requirement {
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .requirement.valid {
            color: #1db954;
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

        #verificationStep, #passwordStep {
            display: none;
        }
    </style>
</head>
<body>

<jsp:include page="../header.jsp" />

<main>
    <div class="reset-container">
        <div class="step-indicator">
            <div class="step active" id="emailStep-indicator">
                <div class="step-number">1</div>
                <div class="step-text">이메일 인증</div>
            </div>
            <div class="step" id="verificationStep-indicator">
                <div class="step-number">2</div>
                <div class="step-text">인증번호 확인</div>
            </div>
            <div class="step" id="passwordStep-indicator">
                <div class="step-number">3</div>
                <div class="step-text">비밀번호 재설정</div>
            </div>
        </div>

        <!-- 이메일 입력 단계 -->
        <div id="emailStep">
            <h2>비밀번호 재설정</h2>
            <p class="description">가입하신 이메일로 인증번호를 보내드립니다.</p>

            <form id="emailForm">
                <div class="form-group">
                    <label for="email" class="form-label">아이디</label>
                    <div class="input-wrapper">
                        <input type="text" id="id" name="id" class="form-input" placeholder="가입하신 아이디를 입력하세요" required>
                    </div>
                    <br>
                    <label for="email" class="form-label">이메일</label>
                    <div class="input-wrapper">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                        <input type="email" id="email" name="email" class="form-input" placeholder="가입하신 이메일을 입력하세요" required>
                    </div>
                </div>

                <button type="submit" class="submit-button">인증번호 받기</button>
            </form>
        </div>

        <!-- 인증번호 확인 단계 -->
        <div id="verificationStep">
            <h2>인증번호 확인</h2>
            <p class="description">이메일로 받으신 6자리 인증번호를 입력해주세요.</p>

            <form id="verificationForm">
                <div class="form-group">
                    <label for="verificationCode" class="form-label">인증번호</label>
                    <div class="verification-group">
                        <div class="input-wrapper verification-input">
                            <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path>
                            </svg>
                            <input type="text" id="verificationCode" name="verificationCode" class="form-input" placeholder="인증번호 6자리" maxlength="6" required>
                        </div>
                        <button type="button" class="verify-button" onclick="resendCode()">재발송</button>
                    </div>
                    <div class="timer" id="verificationTimer">05:00</div>
                </div>

                <button type="submit" class="submit-button">인증번호 확인</button>
            </form>
        </div>

        <!-- 비밀번호 재설정 단계 -->
        <div id="passwordStep">
            <h2>새 비밀번호 설정</h2>
            <p class="description">새로운 비밀번호를 입력해주세요.</p>

            <form id="passwordForm">
                <div class="form-group">
                    <label for="newPassword" class="form-label">새 비밀번호</label>
                    <div class="input-wrapper">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                        <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="새 비밀번호" required>
                    </div>
                    <div class="password-requirements">
                        <div class="requirement" id="lengthReq">8자 이상</div>
                        <div class="requirement" id="upperReq">대문자 포함</div>
                        <div class="requirement" id="numberReq">숫자 포함</div>
                        <div class="requirement" id="specialReq">특수문자 포함</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="form-label">비밀번호 확인</label>
                    <div class="input-wrapper">
                        <svg class="input-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="비밀번호 확인" required>
                    </div>
                </div>

                <button type="submit" class="submit-button">비밀번호 변경</button>
            </form>
        </div>

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
            <h3>비밀번호가 변경되었습니다!</h3>
            <p>새로운 비밀번호로 로그인해주세요.</p>
        </div>

        <div class="login-link">
            <a href="${pageContext.request.contextPath}/member/login.do">로그인 페이지로 돌아가기</a>
        </div>
    </div>
</main>

<script>
//Step 표시 관련 상수
const STEPS = {
    EMAIL: 'emailStep',
    VERIFICATION: 'verificationStep',
    PASSWORD: 'passwordStep'
};

const STEP_ORDER = {
    [STEPS.EMAIL]: 1,
    [STEPS.VERIFICATION]: 2,
    [STEPS.PASSWORD]: 3
};

function showStep(stepId) {
    // 모든 단계 숨기기
    Object.values(STEPS).forEach(step => {
        document.getElementById(step).style.display = 'none';
    });

    // 모든 인디케이터 초기화
    document.querySelectorAll('.step').forEach(step => {
        step.classList.remove('active');
    });

    // 현재 단계까지의 인디케이터 활성화
    const currentStepNumber = STEP_ORDER[stepId];
    document.querySelectorAll('.step').forEach((step, index) => {
        if (index < currentStepNumber) {
            step.classList.add('active');
        }
    });

    // 선택된 단계 표시
    document.getElementById(stepId).style.display = 'block';
}

let timer;
let timeLeft;

function showStep(step) {
    // 모든 단계 숨기기
    document.getElementById('emailStep').style.display = 'none';
    document.getElementById('verificationStep').style.display = 'none';
    document.getElementById('passwordStep').style.display = 'none';

    // 모든 인디케이터 비활성화
    document.querySelectorAll('.step').forEach(s => s.classList.remove('active'));

    // 해당 단계와 그 이전 단계의 인디케이터 활성화
    for (let i = 1; i <= parseInt(step.charAt(0)); i++) {
        document.getElementById(`step${i}-indicator`).classList.add('active');
    }

    // 선택된 단계 표시
    document.getElementById(step).style.display = 'block';
}

function startTimer() {
    clearInterval(timer);
    timeLeft = 300; // 5분 (300초)
    updateTimer();
    timer = setInterval(updateTimer, 1000);
}

function updateTimer() {
    if (timeLeft <= 0) {
        clearInterval(timer);
        document.getElementById('verificationTimer').textContent = '시간 만료';
        showError('인증 시간이 만료되었습니다. 인증번호를 다시 요청해주세요.');
        return;
    }

    const minutes = Math.floor(timeLeft / 60);
    const seconds = timeLeft % 60;
        `${(minutes < 10 ? '0' : '') + minutes}:${(seconds < 10 ? '0' : '') + seconds}`;
        `${(minutes < 10 ? '0' : '') + minutes}:${(seconds < 10 ? '0' : '') + seconds}`;
    timeLeft--;
}

function showError(message) {
    const errorDiv = document.getElementById('errorMessage');
    document.getElementById('errorText').textContent = message;
    errorDiv.style.display = 'flex';
    setTimeout(() => {
        errorDiv.style.display = 'none';
    }, 5000);
}

function validatePassword(password) {
    const requirements = {
        length: password.length >= 8,
        upper: /[A-Z]/.test(password),
        number: /[0-9]/.test(password),
        special: /[!@#$%^&*(),.?":{}|<>]/.test(password)
    };

    // 요구사항 표시 업데이트
    document.getElementById('lengthReq').classList.toggle('valid', requirements.length);
    document.getElementById('upperReq').classList.toggle('valid', requirements.upper);
    document.getElementById('numberReq').classList.toggle('valid', requirements.number);
    document.getElementById('specialReq').classList.toggle('valid', requirements.special);

    return Object.values(requirements).every(req => req);
}

function resendCode() {
    const email = document.getElementById('email').value;
    // AJAX 요청으로 인증번호 재발송
    fetch('' + pageContextPath + '/member/resendVerificationCode.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email: email })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            startTimer();
            showError('인증번호가 재발송되었습니다.');
        } else {
            showError(data.message || '인증번호 재발송에 실패했습니다.');
        }
    })
    .catch(error => {
        showError('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    });
}

// 이메일 폼 제출
document.getElementById('emailForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;

    fetch('' + pageContextPath + '/member/sendVerificationCode.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email: email })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showStep('verificationStep');
            startTimer();
        } else {
            showError(data.message || '인증번호 발송에 실패했습니다.');
        }
    })
    .catch(error => {
        showError('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    });
});

// 인증번호 확인 폼 제출
document.getElementById('verificationForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const code = document.getElementById('verificationCode').value;

    fetch('' + pageContextPath + '/member/verifyCode.do', {
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
            showStep('passwordStep');
            clearInterval(timer);
        } else {
            showError(data.message || '인증번호가 일치하지 않습니다.');
        }
    })
    .catch(error => {
        showError('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    });
});

// 비밀번호 변경 폼 제출
document.getElementById('passwordForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (!validatePassword(newPassword)) {
        showError('비밀번호가 요구사항을 충족하지 않습니다.');
        return;
    }

    if (newPassword !== confirmPassword) {
        showError('비밀번호가 일치하지 않습니다.');
        return;
    }

    fetch('' + pageContextPath + '/member/resetPassword.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            email: document.getElementById('email').value,
            password: newPassword
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            document.getElementById('passwordStep').style.display = 'none';
            document.getElementById('successMessage').style.display = 'block';
            setTimeout(() => {
                window.location.href = '' + pageContextPath + '/member/login.do';
            }, 3000);
        } else {
            showError(data.message || '비밀번호 변경에 실패했습니다.');
        }
    })
    .catch(error => {
        showError('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    });
});

// 비밀번호 입력 필드 실시간 유효성 검사
document.getElementById('newPassword').addEventListener('input', function(e) {
    validatePassword(e.target.value);
});

// 초기 단계 표시
showStep('emailStep');
</script>
</body>
</html>