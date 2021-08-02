<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<h1>인증번호 입력 페이지</h1>

<form action="certInsert" method="post">
	<input type="hidden" name="email" value="${param.email }">
	<input type="text" name="emailCertNo" placeholder="인증번호 입력" required>
	<input type="submit" value="인증 확인">
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>