<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스 - 게시글 상세</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/commu/commuContent.css">
 
</head>

<jsp:include page="../header.jsp" />

<div class="post-detail-container">
    <div class="post-header">
        <h2 class="post-title">${noticeId.title}</h2>
        <div class="post-meta">
            <span class="author">작성자: ${noticeId.member_name} / </span>
            <!-- 날짜 포맷은 JavaScript로 처리 -->
            <span class="date" id="post-date" data-created-at="${noticeId.created_at}"></span>
            <span class="comments"> / 댓글: 15</span>
        </div>
    </div>
    <div class="post-content">
        <p>${noticeId.content}</p>
    </div>
    <div class="post-actions">
        <button class="post-action-btn" onclick="window.location.href='/notice/noticeList.do'">글 목록</button>
        
		<sec:authorize access="isAuthenticated() and hasRole('ROLE_2')">
		    <button class="post-action-btn" onclick="window.location.href='editNotice.do?notice_id=${noticeId.notice_id}'">글 수정</button>
		    <button class="post-action-btn delete-btn" onclick="confirmDelete(${noticeId.notice_id})">글 삭제</button>
		</sec:authorize>
		
    </div>
    <div class="comment-section">
        <h3>댓글</h3>
        <ul class="comment-list">
            <li class="comment-item">
                <span class="comment-author">음악애호가</span>
                <span class="comment-date">2024-09-23 15:30</span>
                <p>와우, 정말 좋은 선곡이네요! 특히 BTS의 Dynamite는 제 최애곡이에요.</p>
            </li>
            <li class="comment-item">
                <span class="comment-author">팝뮤직팬</span>
                <span class="comment-date">2024-09-23 16:45</span>
                <p>The Weeknd의 노래들이 두 곡이나 있네요. 역시 인기가 많아요!</p>
            </li>
        </ul>
        <form action="${pageContext.request.contextPath}/comment/addComment.do" method="post">
         	<input type="hidden" name="redirectUrl" value="${request.getRequestURI()}">
            <input type="hidden" name="userId" value="<sec:authentication property='principal.username'/>">
            <textarea name="comment" placeholder="댓글을 입력하세요"></textarea>
            <button type="submit">댓글 작성</button>
        </form>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        // 게시글 작성 날짜 포맷
        const postDateElement = document.getElementById('post-date');
        const createdAt = postDateElement.getAttribute('data-created-at');
        const date = new Date(createdAt);

        // 날짜 포맷 (YYYY-MM-DD)
        const formattedDate = date.toLocaleDateString('ko-KR', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit'
        });

        // 포맷된 날짜 출력
        postDateElement.innerText = formattedDate;
    });

    function confirmDelete(noticeId) {
        if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
            fetch('/notice/noticeDelete.do?notice_id=' + noticeId, { method: 'POST' })
                .then(response => {
                    if (response.ok) {
                        alert("글이 삭제되었습니다.");
                        window.location.href = '${pageContext.request.contextPath}/notice/noticeList.do';
                    } else {
                        alert("삭제에 실패하였습니다.");
                    }
                })
                .catch(error => console.error('Error:', error));
        }
    }

</script>

</body>
</html>
