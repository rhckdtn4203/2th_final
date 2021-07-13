<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h2>가입이 완료되었습니다</h2>
	</div>
	
	<div class="row">
		<img src="<%=request.getContextPath()%>/image/background.jpg" width="100%">
	</div>
	
	<div class="row">
		<h3><a href="${pageContext.request.contextPath}/member/login">로그인 하시겠습니까?</a></h3>
	</div>
	<div class="row">
		<h3><a href="${pageContext.request.contextPath}">메인 페이지</a></h3>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>