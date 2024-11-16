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
</head>

<jsp:include page="../header.jsp" />

	<main>
		<div class="login-container">
		    <h2>로그인</h2>
			<form action="<c:url value='/login'/>" method="POST">
			    <div class="form-group">
			        <label for="user_id">아이디</label>
			        <input type="text" id="user_id" name="user_id" required>
			    </div>
			    <div class="form-group">
			        <label for="password">비밀번호</label>
			        <input type="password" id="password" name="password" required>
			    </div>
			    <button type="submit" class="login-button">로그인</button>
			</form>
		    <div class="login-links">
		    	<a href="${pageContext.request.contextPath}/member/findId.do">아이디 찾기</a> |
		        <a href="${pageContext.request.contextPath}/member/updatePw.do">비밀번호 변경</a> | 
		        <a href="${pageContext.request.contextPath}/member/signUp.do">회원가입</a>
		    </div>
		</div>
	
	</main>
</body>
</html>
