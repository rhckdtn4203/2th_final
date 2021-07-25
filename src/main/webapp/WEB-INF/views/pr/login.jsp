<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<section class="section-1">

  <div id="loading">
    <span>우리</span>
    <span class="loading">밤</span>
    <span class="loading">부</span>
    <span>에서 같이 놀아요!</span>
  </div>

  <div class="input">
  </div>

<div class="login-box">
  <form action="${pageContext.request.contextPath}/pr/login" method="POST">
    
    <div class="login-group">
    <div class="group">
      
        <label>아이디</label>
          <input type="text" class="form-control" id="inputId" name="memberId" placeholder="ID">
    </div>
    
    <div class="group">
        <label>비밀번호</label>
        <input type="password" class="form-control" id="inputPw" name="memberPw" placeholder="Password">
    </div>
    </div>
    
    <%-- <div class="remember-id">
      <label class="font-weight-bold text-white"> 
      <input type="checkbox" id="remember_us" name="remember_userId" ${checked}> 아이디 기억하기
      </label>
    </div> --%>
    
   <!--  <div class="login-btn-box">
    <button class="login-btn"><span>로그인</span></button>
    </div> -->
    <div class="login-btn-box">
			<input type="submit" value="로그인" class="login-btn">
	</div>
  
  </form>
  
 
  <div class="input-side">
    <div class="inputside-1">
    <a href="${pageContext.request.contextPath}/pr/signup" class="side-info">회원가입</a>
    </div>
    <div class="inputside-1" id="inputside-middle">
    <a href="${pageContext.request.contextPath}/pr/find_id" class="side-info">아이디찾기</a>
    </div>
    <div class="inputside-1">
    <a href="${pageContext.request.contextPath}/pr/fidn_pw" class="side-info">비밀번호찾기</a>
    </div>
  </div>



</div>

</section>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>