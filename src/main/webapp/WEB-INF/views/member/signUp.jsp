<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUp.css">

<div class="login-container">
    <h2>회원가입</h2>
    <form id="signup-form">
        <div class="form-group">
            <label for="username">사용자 이름</label>
            <input type="text" id="user_name" name="user_name" required>
        </div>
        <div class="form-group">
            <label for="username">아이디</label>
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
            <input type="password" id="confirm-password" name="confirm-password" required>
        </div>
        <div class="form-group">
            <label for="birthdate">생년월일</label>
            <input type="date" id="birthdate" name="birthdate" required>
        </div>
        <div class="form-group">
            <label>즐겨 듣는 음악 장르 (여러 개 선택 가능)</label>
            <div class="genre-options">
                <label><input type="checkbox" name="genres" value="pop"> 팝</label>
                <label><input type="checkbox" name="genres" value="rock"> 록</label>
                <label><input type="checkbox" name="genres" value="hiphop"> 힙합</label>
                <label><input type="checkbox" name="genres" value="jazz"> 재즈</label>
                <label><input type="checkbox" name="genres" value="classical"> 클래식</label>
                <label><input type="checkbox" name="genres" value="electronic"> 일렉트로닉</label>
                <label><input type="checkbox" name="genres" value="rnb"> R&B</label>
                <label><input type="checkbox" name="genres" value="country"> 컨트리</label>
            </div>
        </div>
        <button type="submit" class="login-button">가입하기</button>
    </form>
    <div class="login-links">
        <a href="#" id="login-link">이미 계정이 있으신가요? 로그인</a>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#signup-form').submit(function(e) {
            e.preventDefault();
            
            // 비밀번호 일치 여부 확인
            var password = $('#password').val();
            var confirmPassword = $('#confirm-password').val();
            
            if (password !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }
            
            // 이메일 형식 검증
            var email = $('#email').val();
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('유효한 이메일 주소를 입력해주세요.');
                return;
            }
            
            // 선택된 음악 장르 가져오기
            var selectedGenres = [];
            $('input[name="genres"]:checked').each(function() {
                selectedGenres.push($(this).val());
            });
            
            if (selectedGenres.length === 0) {
                alert('적어도 하나의 음악 장르를 선택해주세요.');
                return;
            }
            
            // 여기에 회원가입 처리 로직을 추가하세요
            console.log('선택된 음악 장르:', selectedGenres);
            alert('회원가입 기능은 아직 구현되지 않았습니다.');
        });

        $('#login-link').click(function(e) {
            e.preventDefault();
            // 로그인 페이지로 이동
            $.get('member/login.do', function(data) {
                $('#content-area').html(data);
            });
        });
    });
</script>