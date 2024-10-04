<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>editCommu</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/commu/addCommu.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>

	<jsp:include page="../header.jsp" />
	
	    <div class="new-post-container">
	        <h2>글 수정</h2>
	        <form class="new-post-form" action="/commu/editCommu.do" method="POST">
	        	<input type="hidden" name="post_id" value="${editCommu.post_id}">
	        	<input type="hidden" name="member_name" value="<sec:authentication property='principal.username'/>">
	            <div class="form-group">
	                <label for="post-title">제목</label>
	                <input type="text" id="post-title" name="title" required maxlength="100" value="${editCommu.title}"> 
	                <span class="character-count">0 / 100</span>
	            </div>
	            <div class="form-group">
	                <label for="post-content">내용</label>
	                <textarea id="post-content" name="content" required maxlength="1000">${editCommu.content}</textarea>
	                <span class="character-count">0 / 1000</span>
	            </div>
	            <div class="button-group">
	                <button type="button" class="preview-button" onclick="previewPost()">미리보기</button>
	                <button type="submit" class="submit-button">글 수정</button>
	            </div>
	        </form>
	    </div>
	
	    <div id="previewModal" class="preview-modal">
	        <div class="preview-content">
	            <span class="close">&times;</span>
	            <div class="preview-header">
	                <h2 id="previewTitle" class="preview-title"></h2>
	                <div class="preview-meta">
	                    <span class="author">작성자: <span id="previewAuthor"></span></span>
	                    <span class="date" id="previewDate"></span>
	                </div>
	            </div>
	            <div id="previewContent" class="preview-body"></div>
	        </div>
	    </div>
	
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <script>
	        $(document).ready(function() {
	            // 글자 수 카운트 기능
	            $('input[type="text"], textarea').on('input', function() {
	                var charCount = $(this).val().length;
	                var maxLength = $(this).attr('maxlength');
	                $(this).siblings('.character-count').text(charCount + ' / ' + maxLength);
	            });
	
	            // 모달 닫기 기능
	            $('.close').click(function() {
	                $('#previewModal').hide();
	            });
	
	            $(window).click(function(event) {
	                if (event.target == document.getElementById('previewModal')) {
	                    $('#previewModal').hide();
	                }
	            });
	        });
	
	        // 미리보기 기능
	        function previewPost() {
	            var title = $('#post-title').val();
	            var content = $('#post-content').val();
	            var author = $('input[name="member_name"]').val();
	            var currentDate = new Date().toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' });
	            
	            $('#previewTitle').text(title);
	            $('#previewAuthor').text(author);
	            $('#previewDate').text(currentDate);
	            $('#previewContent').html(content.replace(/\n/g, '<br>'));
	            $('#previewModal').show();
	        }
	    </script>
	    
    </main>
</body>
</html>