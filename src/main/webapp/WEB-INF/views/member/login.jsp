<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h2>로그인</h2>
	</div>
	
	
	<form action="${pageContext.request.contextPath}/member/login" method="post">
		<div class="row text-left">
			<label>아이디</label>
			<input type="text" name="memberId" required class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>비밀번호</label>
			<input type="password" name="memberPw" required class="form-input form-input-underline">
		</div>
		<div class="row">
			<input type="submit" value="로그인" class="form-btn form-btn-positive">
		</div>
	</form>

	
	<!-- 오류인 상황에는 오류 메세지를 추가해준다 -->
	<c:if test="${param.error != null}">
		<div class="row">
			<h5 class="error">정보가 일치하지 않습니다</h5>
		</div>
	</c:if>
	
	<div class="row">
		<h4><a href="${pageContext.request.contextPath}/member/find_id">아이디가 기억나지 않습니다.</a></h4>
	</div>
	<div class="row">
		<h4><a href="${pageContext.request.contextPath}/member/find_pw">비밀번호가 기억나지 않습니다.</a></h4>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>