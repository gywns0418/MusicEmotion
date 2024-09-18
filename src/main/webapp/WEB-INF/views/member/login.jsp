<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="login-container">
    <h2>로그인</h2>
    <form id="login-form">
        <div class="form-group">
            <label for="username">사용자 이름</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="login-button">로그인</button>
    </form>
    <div class="login-links">
        <a href="#">비밀번호를 잊으셨나요?</a> | <a href="#">회원가입</a>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#login-form').submit(function(e) {
            e.preventDefault();
            // 여기에 로그인 처리 로직을 추가하세요
            alert('로그인 기능은 아직 구현되지 않았습니다.');
        });
    });
</script>