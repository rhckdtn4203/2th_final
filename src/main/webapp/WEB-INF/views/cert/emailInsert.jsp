<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<h1>이메일 입력 페이지</h1>

<form action="emailInsert" method="post">
	<input type="text" name="email" placeholder="인증할 메일 입력" required>
	<input type="submit" value="인증 요청">
	
	<c:if test="${param.error != null}">
		<br><span style="color:red;">메일 정보가 없는 회사입니다.</span>
		<br><span style="color:red;">메일 주소를 확인해주시고, 등록이 안된 회사라면 다음 방식을 이용해주십시오.</span>
		<br>
		<br><a href="#">사원증으로 인증하기</a>
		<br><a href="${pageContext.request.contextPath}/company/registCompany">회사 등록 신청하기</a>
	</c:if>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>