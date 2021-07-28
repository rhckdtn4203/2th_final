<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css">

<section class="section-2">
  <div class="sign-title">
		<h2>회원가입</h2>
	</div>
	
  <div class="signup-box">
    <form action="signup" method="post">
      <div class="sign-group">
        <div class="group">
          <label>이름</label><span>&nbsp</span>
          <input type="text" name="memberName" required class="sb">
        </div>
        
        <div class="group">
          <label>아이디</label><span>&nbsp</span>
          <input type="text" name="memberId" required class="sb"
                placeholder="8~20자 이내의 영문 대·소문자, 숫자">
        </div>
        <div class="group">
          <label>비밀번호</label><span>&nbsp</span>
          <input type="password" name="memberPw" required class="sb"
                placeholder="8~20자 이내의 영문대·소문자, 숫자, #?!@$ %^&*-">
        </div>
        <div class="group">
          <label>비밀번호 재확인</label><span>&nbsp</span>
          <input type="password" class="sb"
                placeholder="비밀번호 재확인">
        </div>
      
        <div class="group">
          <label>전화번호</label><span>&nbsp</span>
          <input type="text" name="memberPhone" required class="sb"
                placeholder="-를 포함하여 입력 (예 : 010-XXXX-XXXX)">
        </div>
        <div class="group">
          <label>이메일</label><span>&nbsp</span>
          <input type="text" name="memberEmail" class="sb">
        </div>
        <div class="group">
          <label>닉네임</label><span>&nbsp</span>
          <input type="text" name="memberNick" required class="sb"
                placeholder="2~10자 이내의 한글,영문 대·소문자,숫자 ">
        </div>
        </div>
      

      <div class="login-btn-box">
        <input type="submit" value="가입하기" class="login-btn">
      </div>
    </form>
</div>
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>