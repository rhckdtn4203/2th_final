<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600">

	<div class="row">
		<h2>비밀번호 변경</h2>
	</div>

	<form action="change_pw" method="post">
		<div class="row">
			<input type="password" name="curPw" placeholder="현재 비밀번호" required class="form-input form-input-underline">
		</div>
		<div class="row">
			<input type="password" name="newPw" placeholder="변경할 비밀번호" required class="form-input form-input-underline">
		</div>
		<div class="row">
			<input type="submit" value="변경하기" class="form-btn form-btn-positive">
		</div>

		<c:if test="${param.error != null}">
			<div class="row">
				<h5 class="error">정보가 일치하지 않습니다</h5>
			</div>
		</c:if>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>