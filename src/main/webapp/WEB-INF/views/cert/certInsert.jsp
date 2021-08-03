<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	#modiBack {
		height: 700px;
		padding-top: 30px;
		padding-bottom: 10px;
	}
	
	#aa {
		padding-bottom: 30px;
		margin-bottom: 0 0 60px 0;
	}
	
	#group-back {
		height: 240px;
	}
	
	#box-padding {
		padding:10px;
	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
    
<section id="modiBox">
	<div class="modiBack" id="modiBack">
		<div id="modititle">
			<h3>인증번호 입력</h3>
		</div>
		
		<div>
			<form action="certInsert" method="post">
				<input type="hidden" name="email" value="${param.email }">
				<div id="aa">
					<input type="text" name="emailCertNo" id="box-padding" class="sb" placeholder="인증번호 입력" required>
				</div>
				<div class="login-btn-box">
					<input type="submit" value="인증 확인" class="login-btn">
				</div>
				
				<c:if test="${param.error != null}">
					<br>
					<span style="color: red;">인증번호가 일치하지 않습니다</span>
				</c:if>
			</form>
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>