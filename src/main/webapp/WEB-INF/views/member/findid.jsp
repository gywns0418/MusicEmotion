<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/findid.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h2 style="text-align: center;">아이디찾기</h2>
<div class="content_header">
</div> 
<div class="login-form">
	
	<form action="findid.do" method="post" name="frm">
		<input type="text" name="name" placeholder="이름을 입력해주세요" id="name">
		<input type="text" name="phone" id="phone" placeholder="전화번호를 입력해주세요" style="width: 60%;">
		<button type="button" onclick="subCertifi()" style="width: 30%; margin-left: 10px; padding: 7px;" disabled>인증번호발송</button>
		<input type="text" name="certi" id="certi" placeholder="인증번호를 입력해주세요" style="width: 60%;">
		<button type="button" onclick="check()" style="width: 30%; margin-left: 10px; padding: 7px;">인증번호확인</button>
		<button type="button" onclick="sub()">찾기</button>
	</form>
</div>
<script type="text/javascript">
	let ck = true;
	let serverCheck = '';
	function subCertifi(){
		var csrfToken = $("meta[name='_csrf']").attr("content");
		var csrfHeader = $("meta[name='_csrf_header']").attr("content");
		const phone = document.getElementById("phone").value;
		const name = document.getElementById("name").value;
		if(name == ""){
			alert("이름을 먼저 입력해주세요");
		} else{
			$.ajax({
				url : 'subCrtifi.ajax', 
				type : 'POST',
				contentType: 'application/x-www-form-urlencoded',
		        data: { "phone": phone },
				/* beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeader, csrfToken);
				}, */
				success : function(response) {
					console.log(response);
					serverCheck = response.check;
					alert("인증번호가 전송되었습니다. 문자를 확인해주세요");
				},
				error : function(xhr, status, error) {
					console.error('주문 데이터 전송 실패:', error);
					console.error('상태 코드:', xhr.status);
					console.error('응답 텍스트:', xhr.responseText);
					// 오류 시 추가 작업 (예: 사용자에게 오류 메시지 표시 등)
				}
			}
			)
		}
	}
	function check(){
		if(serverCheck==document.getElementById("certi").value && serverCheck != ''){
			ck = true;
			alert("인증완료!");
		}else{
			alert("인증번호가 다릅니다!!");
		}
	}
	function sub(){
		if(ck == true){
			document.frm.submit();
		}else{
			alert("문자 인증을 마쳐주세요!");
		}
	}
	
</script>
<p style="text-align: center;">아이디 찾기에 어려움이 있으신가요? 도움말 펼치기</p>
<p style="text-align: center;">아이디 찾기 시 문제가 있나요?         바로가기</p>

<jsp:include page="../footer.jsp" />