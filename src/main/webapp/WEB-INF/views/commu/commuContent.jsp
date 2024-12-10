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
        <h2 class="post-title">${postId.title}</h2>
        <div class="post-meta">
            <span class="author">작성자: ${postId.member_name} / </span>
            <!-- 날짜 포맷은 JavaScript로 처리 -->
            <span class="date" id="post-date" data-created-at="${postId.created_at}"></span>
            <span class="comments"> / 댓글: 15</span>
        </div>
    </div>
    <div class="post-content">
        <p>${postId.content}</p>
    </div>
    <div class="post-actions">
        <button class="post-action-btn" onclick="window.location.href='/commu/commuList.do'">글 목록</button>
        
        <sec:authorize access="isAuthenticated()">
		    <sec:authentication property="principal.username" var="currentUsername"/>
		</sec:authorize>

		<c:if test="${currentUsername == postId.member_name}">
		    <button class="post-action-btn" onclick="window.location.href='editCommu.do?post_id=${postId.post_id}'">글 수정</button>
		    <button class="post-action-btn delete-btn" onclick="confirmDelete(${postId.post_id})">글 삭제</button>
		</c:if>
    </div>
    <div class="comment-section">
        <h3>댓글</h3>
        <ul class="comment-list">

            <c:forEach var="comment" items="${comment}">
	           <li class="comment-item">
	                <span class="comment-author">${comment.member_name}</span>
	                <span class="comment-date">${comment.created_at}</span>
	                <p>${comment.content}</p>
	            </li>
            </c:forEach>
        </ul>
        <form id="comment-form">
		    <input type="hidden" id="referenceId" value="${postId.post_id}">
		    <input type="hidden" id="type" value="COMMUNITY"> 
			<c:if test="${not empty sessionScope['SPRING_SECURITY_CONTEXT']}">
			    <input type="hidden" id="memberName" value="<sec:authentication property='principal.username'/>">
			</c:if>
		    
		    <textarea class="comment-input" id="content" placeholder="댓글 내용을 입력하세요" rows="3"></textarea>
		    <button type="button" onclick="addComment()">댓글 작성</button>
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

    function confirmDelete(postId) {
        if (confirm("정말로 이 글을 삭제하시겠습니까?")) {
            fetch('/notice/commuDelete.do?post_id=' + postId, { method: 'POST' })
                .then(response => {
                    if (response.ok) {
                        alert("글이 삭제되었습니다.");
                        window.location.href = '${pageContext.request.contextPath}/commu/commuList.do';
                    } else {
                        alert("삭제에 실패하였습니다.");
                    }
                })
                .catch(error => console.error('Error:', error));
        }
    }
    
    function addComment() {
        const referenceId = document.getElementById('referenceId');
        const type = document.getElementById('type');
        const memberName = document.getElementById('memberName');
        const content = document.getElementById('content');

        // 요소가 존재하는지 확인
        if (!referenceId || !type || !memberName || !content) {
            console.log("referenceId:", referenceId?.value, "type:", type?.value, "memberName:", memberName?.value, "content:", content?.value);
            alert('필수 요소가 누락되었습니다.');
            return;
        }

        if (!memberName.value) {
            alert('로그인을 먼저 해주세요');
            return;
        }

        // AJAX 요청
        fetch('/comment/addCommu.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                referenceId: referenceId.value,
                type: type.value,
                memberName: memberName.value,
                content: content.value
            })
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                alert('댓글이 작성되었습니다.');
                location.reload(); // 페이지 리로드
            } else {
                alert('댓글 작성에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('서버와 통신 중 문제가 발생했습니다.');
        });
    }


</script>

</body>
</html>
