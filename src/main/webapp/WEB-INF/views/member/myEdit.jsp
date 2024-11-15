<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

	<div class="login-container">
	    <h2>내 정보 수정</h2>
	    <form id="password-check-form" method="post">
		    <input type="hidden" name="userId" value="${member.user_id}">
		    <div class="form-group">
		        <label for="inputPassword">비밀번호 확인</label>
		        <input type="password" id="inputPassword" name="inputPassword" required placeholder="비밀번호를 입력해주세요">
		        <button type="button" id="checkPasswordBtn">확인</button>
		    </div>
		    <p id="password-check-result" style="color:red;"></p>
		</form>
		
		<form id="update-form" action="<c:url value='/member/updateInfo' />" method="post" style="display:none;">
		    <input type="hidden" name="userId" value="${member.user_id}">
		    <div class="form-group">
		        <label for="user_name">사용자 이름</label>
		        <input type="text" id="user_name" name="user_name" value="${member.user_name}" required>
		    </div>
		    <div class="form-group">
		        <label for="email">이메일</label>
		        <input type="email" id="email" name="email" value="${member.email}" required>
		    </div>
		    <div class="form-group">
		        <label for="birthdate">생년월일</label>
		        <fmt:parseDate var="parsedDate" value="${member.birthdate}" pattern="yyyy-MM-dd HH:mm:ss" />
		        <input type="date" id="birthdate" name="birthdate" value="<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />" required>
		    </div>
		    <div class="form-group">
		        <label>즐겨 듣는 음악 장르 (여러 개 선택 가능)</label>
		        <div class="genre-options">
	                <label><input type="checkbox" name="genre" value="pop" <c:if test="${fn:contains(member.genre, 'pop')}">checked</c:if> > 팝</label>
	                <label><input type="checkbox" name="genre" value="rock" <c:if test="${fn:contains(member.genre, 'rock')}">checked</c:if> > 록</label>
	                <label><input type="checkbox" name="genre" value="hiphop" <c:if test="${fn:contains(member.genre, 'hiphop')}">checked</c:if> > 힙합</label>
	                <label><input type="checkbox" name="genre" value="jazz" <c:if test="${fn:contains(member.genre, 'jazz')}">checked</c:if> > 재즈</label>
	                <label><input type="checkbox" name="genre" value="classical" <c:if test="${fn:contains(member.genre, 'classical')}">checked</c:if> > 클래식</label>
	                <label><input type="checkbox" name="genre" value="blues" <c:if test="${fn:contains(member.genre, ' blues')}">checked</c:if> > 브루스</label>
	                <label><input type="checkbox" name="genre" value="rnb" <c:if test="${fn:contains(member.genre, 'rnb')}">checked</c:if> > R&B</label>
	                <label><input type="checkbox" name="genre" value="acoustic" <c:if test="${fn:contains(member.genre, 'acoustic')}">checked</c:if> > 어쿠스틱</label>
	            </div>
	        </div>
		    <button type="submit" class="login-button">정보 수정</button>
		</form>


    </div>

<script>
    $(document).ready(function() {
        $("#checkPasswordBtn").click(function() {
            var userId = $("input[name='userId']").val();
            var inputPassword = $("#inputPassword").val();

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/member/checkPassword",
                data: {
                    userId: userId,
                    inputPassword: inputPassword
                },
                success: function(response) {
                    if (response === true) {
                        $("#password-check-result").text("비밀번호가 확인되었습니다.");
                        $("#update-form").show(); // 비밀번호가 맞으면 수정 폼을 보여줌
                        $("#password-check-form").hide(); // 비밀번호 확인 폼은 숨김
                    } else {
                        $("#password-check-result").text("비밀번호가 일치하지 않습니다.");
                    }
                },
                error: function() {
                    alert("비밀번호 확인 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>

</main>
</body>
</html>
