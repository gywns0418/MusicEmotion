<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/member/signUp.css">
</head>

<jsp:include page="../header.jsp" />

<main>

    <div class="login-container">
        <h2>회원가입</h2>
        <form id="signup-form" action="<c:url value='/member/signUpPro.do' />" method="post">
            <div class="form-group">
                <label for="user_name">사용자 이름</label>
                <input type="text" id="user_name" name="user_name" required>
            </div>
            <div class="form-group">
                <label for="user_id">아이디</label>
                <input type="text" id="user_id" name="user_id" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required placeholder="example@email.com">
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" required>
            </div>
            <div class="form-group">
                <label for="birthdate">생년월일</label>
                <input type="date" id="birthdate" name="birthdate" required>
            </div>
            <div class="form-group">
                <label>즐겨 듣는 음악 장르 (여러 개 선택 가능)</label>
                <div class="genre-options">
                    <label><input type="checkbox" name="genre" value="pop"> 팝</label>
                    <label><input type="checkbox" name="genre" value="rock"> 록</label>
                    <label><input type="checkbox" name="genre" value="hiphop"> 힙합</label>
                    <label><input type="checkbox" name="genre" value="jazz"> 재즈</label>
                    <label><input type="checkbox" name="genre" value="classical"> 클래식</label>
                    <label><input type="checkbox" name="genre" value="blues"> 브루스</label>
                    <label><input type="checkbox" name="genre" value="rnb"> R&B</label>
                    <label><input type="checkbox" name="genre" value="acoustic"> 어쿠스틱</label>
                </div>
            </div>
            <button type="submit" class="login-button">가입하기</button>
        </form>
        <div class="login-links">
            <a href="<c:url value='${pageContext.request.contextPath}/member/login.do' />" id="login-link">이미 계정이 있으신가요? 로그인</a>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#signup-form').submit(function(e) {
                // 비밀번호 일치 여부 확인
                var password = $('#password').val();
                var confirmPassword = $('#confirm-password').val();

                if (password !== confirmPassword) {
                    alert('비밀번호가 일치하지 않습니다.');
                    e.preventDefault();
                    return;
                }

                // 이메일 형식 검증
                var email = $('#email').val();
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('유효한 이메일 주소를 입력해주세요.');
                    e.preventDefault();
                    return;
                }

                // 선택된 음악 장르 가져오기
                var selectedGenres = [];
                $('input[name="genre"]:checked').each(function() {
                    selectedGenres.push($(this).val());
                });

                if (selectedGenres.length === 0) {
                    alert('적어도 하나의 음악 장르를 선택해주세요.');
                    e.preventDefault();
                    return;
                }

                alert('회원가입이 완료되었습니다');
                // 서버로 폼 전송 허용
            });
        });
    </script>
</main>
</body>
</html>
