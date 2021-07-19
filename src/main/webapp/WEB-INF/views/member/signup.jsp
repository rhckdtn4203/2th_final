<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h2>회원가입 하기</h2>
	</div>
	
	<form action="signup" method="post">
		<div class="row text-left">
			<label>이름</label>
			<input type="text" name="memberName" required class="form-input form-input-underline">
		</div>
		
		<div class="row text-left">
			<label>아이디</label>
			<input type="text" name="memberId" required class="form-input form-input-underline"
						placeholder="8~20자 이내의 영문 대·소문자, 숫자">
		</div>
		<div class="row text-left">
			<label>비밀번호</label>
			<input type="password" name="memberPw" required class="form-input form-input-underline"
						placeholder="8~20자 이내의 영문대·소문자, 숫자, #?!@$ %^&*-">
		</div>
		<div class="row text-left">
			<label>비밀번호 재확인</label>
			<input type="password" class="form-input form-input-underline"
						placeholder="비밀번호 재확인">
		</div>
	
		<div class="row text-left">
			<label>전화번호</label>
			<input type="text" name="memberPhone" required class="form-input form-input-underline"
						placeholder="-를 포함하여 입력 (예 : 010-XXXX-XXXX)">
		</div>
		<div class="row text-left">
			<label>이메일</label>
			<input type="text" name="memberEmail" class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>닉네임</label>
			<input type="text" name="memberNick" required class="form-input form-input-underline"
						placeholder="2~10자 이내의 한글,영문 대·소문자,숫자 ">
		</div>
		<div class="row">
			<input type="submit" value="회원가입" class="form-btn form-btn-positive">
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
