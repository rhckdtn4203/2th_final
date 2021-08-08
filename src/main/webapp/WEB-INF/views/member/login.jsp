<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css">

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
.login-btn{
position: relative;
  margin: 5px;
  border: none;
  color: wheat;
  background-color: var(--color-green);
  font-size: 20px;
  font-weight: var(--weight-6);
  
  cursor: pointer;
  overflow: hidden;
  text-transform: uppercase;
  transition: 0.5s;
}

.login-btn:hover{
	background: #fbfdfa;
  color: #050801;
  box-shadow: 0 0 5px #fbfdfa,
              0 0 25px #fbfdfa,
              0 0 50px #fbfdfa,
              0 0 200px #fbfdfa;
  -webkit-box-reflect:below 1px linear-gradient(transparent, #0005);
}

</style>

<section class="section-1">
	
	 <div class="input">
	 </div>
	
	<div class="login-box">
		<div id="loading">
		    <span>우리</span>
		    <span class="loading">밤</span>
		    <span class="loading">부</span>
		    <span>에서 같이 놀아요!</span>
		</div>
	
	<form action="${pageContext.request.contextPath}/member/login" method="post">
		<div class="login-group">
    		<div class="group">
      
	        <label>아이디</label>
		    <input type="text" class="form-control" onblur="checkId();" id="inputId" name="memberId" placeholder="ID">
		    </div>
		    
		    <div class="group">
		        <label>비밀번호</label>
		        <input type="password" class="form-control" onblur="checkId();" id="inputPw" name="memberPw" placeholder="Password">
		    </div>
    	</div>
    	
		 <div class="login-btn-box">
			<input type="submit" value="로그인" class="login-btn" onsubmit="return formCheck();">
		</div>
	</form>

	
	<!-- 오류인 상황에는 오류 메세지를 추가해준다 -->
	<c:if test="${param.error != null}">
		<div class="row">
			<h5 class="error">정보가 일치하지 않습니다</h5>
		</div>
	</c:if>
	
	<div class="input-side">
    <div class="inputside-1">
    <a href="${pageContext.request.contextPath}/member/signup" class="side-info">회원가입</a>
    </div>
    <div class="inputside-1" id="inputside-middle">
    <a href="${pageContext.request.contextPath}/member/find_id" class="side-info">아이디찾기</a>
    </div>
    <div class="inputside-1">
    <a href="${pageContext.request.contextPath}/member/find_pw" class="side-info">비밀번호찾기</a>
    </div>
    
      </div>
</div>

</section>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



<!-- 


<script type="text/javascript"> 

function loginchk(){
 var regx = /^[a-zA-Z0-9]{8,20}$/;
 var regxp =/^[a-zA-Z0-9#?!@$ %^&*-]{8,20}$/;
 var id = document.form.id.value;
 var pw = document.form.pw.value;
 
 if (id.length == 0 || id == null) {
  alert("아이디를 입력하세요");
  location.href="home.jsp";
  return;
 }
 
 if (!regx.test(id)){
  alert("아이디는 영어, 숫자만 입력가능합니다.");
  location.href="home.jsp";
  document.form.id.focus();
  return false;
 }
 if (pw.length < 8 || pw == null) {
	  alert("비밀번호는 8글자이상입니다^^");
	  document.form.pw.focus();
	  return;
	 }
	 if (!regxp.test(pw)){
	  alert("비밀번호는 영어, 숫자,#?!@$%^&*-만 입력가능합니다.");
	  document.form.pw.focus();
	  return false;
	 }
 document.form.submit();
}
</script> -->