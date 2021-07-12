  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>이메일 입력 페이지</h1>

<form action="emailInsert" method="post">
	<input type="text" name="email" placeholder="인증할 메일 입력" required>
	<input type="submit" value="인증 요청">
</form>