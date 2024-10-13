<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 음악 추천 서비스 - 공지</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/commu/commuList.css">

</head>

	<jsp:include page="../header.jsp"/>
	
	
    <div class="community-container">
        <div class="community-header">
            <h2>공지 게시판</h2>
            <sec:authorize access="isAuthenticated() and hasRole('ROLE_2')">
            	<a class="new-post-button" href="addNotice.do">새 글 작성</a>
            </sec:authorize>
        </div>

        <!-- 검색 폼 -->
  		<div class="search-form-container">
			<div class="search-form">
				<select id="searchType">
					<option value="all"
						<c:if test="${searchType == 'all'}">selected</c:if>>전체</option>
					<option value="subject"
						<c:if test="${searchType == 'subject'}">selected</c:if>>제목</option>
					<option value="author"
						<c:if test="${searchType == 'author'}">selected</c:if>>작성자</option>
				</select> <input type="text" placeholder="검색어를 입력하세요" id="search"
					value="${search}">
				<button onclick="performSearch()">검색</button>
			</div>
        </div>
        
        <ul class="post-list">
            <li class="post-item">
                <a href="noticeContent.do?notice_id=1" class="post-title">이번 주 최고의 플레이리스트를 공유합니다!</a>
                <div class="post-meta">
                    <span class="author">작성자: 음악매니아</span>
                    <span class="date">2024-09-23</span>
                    <span class="comments">댓글: 15</span>
                </div>
            </li>
            <li class="post-item">
                <a href="#" class="post-title">AI 추천 시스템에 대한 의견을 들려주세요</a>
                <div class="post-meta">
                    <span class="author">작성자: AI연구원</span>
                    <span class="date">2024-09-22</span>
                    <span class="comments">댓글: 32</span>
                </div>
            </li>
            <c:forEach var="noticeList" items="${noticeList}">
                <li class="post-item">
                    <a href="noticeContent.do?notice_id=${noticeList.notice_id}" class="post-title">${noticeList.title}</a>
                    <div class="post-meta">
                        <span class="author">작성자: ${noticeList.member_name} </span>
                        <span class="date">2024-09-22 /${noticeList.created_at}</span>
                        <span class="comments">댓글: 32</span>
                    </div>
                </li>
            </c:forEach>
        </ul>
			<c:if test="${not empty noticeList}">
				<div class="pagination">

					<%
					int pageSize = 10;
					int currentPage = (request.getParameter("pageNum") != null) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
					int count = (Integer) request.getAttribute("count");
					int pageBlock = 10;
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount)
						endPage = pageCount;
					%>

					<%
					if (startPage > pageBlock) {
					%>
					<a href="/notice/noticeList.do?pageNum=<%=startPage - pageBlock%>">&laquo;
						이전</a>
					<%
					}
					%>


					<%
					for (int i = startPage; i <= endPage; ++i) {
					%>
					<a href="/notice/noticeList.do?pageNum=<%=i%>"
						class="<%=(i == currentPage) ? "active" : ""%>"><%=i%></a>
					<%
					}
					%>


					<%
					if (endPage < pageCount) {
					%>
					<a href="/notice/noticeList.do?pageNum=<%=startPage + pageBlock%>">다음
						&raquo;</a>
					<%
					}
					%>
					<br>
				</div>
			</c:if>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
	    function performSearch() {
	        var searchType = document.getElementById("searchType").value;
	        var searchTerm = document.getElementById("search").value.trim();
	
	        if (searchTerm !== "") {
	            var currentURL = window.location.href.split('?')[0];
	            var queryString = "?searchType=" + searchType + "&search=" + encodeURIComponent(searchTerm);
	            window.location.href = currentURL + queryString;
	        }else if(searchTerm === ""){
	            var currentURL = window.location.href.split('?')[0];
	            window.location.href =currentURL;
	        }
	    }
    </script>
    
</main>
</body>
</html>