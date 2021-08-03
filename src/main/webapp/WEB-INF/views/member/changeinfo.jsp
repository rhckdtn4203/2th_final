<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>

#modiBack{
height: 650px;
padding-bottom: 5px;
}
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">

<section id="modiBox">
  <div class="modiBack" id="modiBack">
    <div id="modititle">
      <h3>CAHNGE YOUR PERSONAL INFOMATION</h3>
    </div>
    <figure class="snip1200">
      <div id="a">
      <img src="http://localhost:8080/khblind/img/img2.png" alt="backgroung-img"/>
      <figcaption>
        <p>강미진님, 개인정보가 바뀌셨나요?<br>
        이름은 수정이 불가하며 Email은 <span><button id="veri-btn">이메일인증</button></span>에서 새로 인증받으셔야 합니다.  </p>
        <div class="heading">
          <h3>개인정보변경</h3>
        </div>
      </figcaption>
      
      </div>
      </figure>


      <div class="input-modiBox">
        <form action="changeinfo" method="post">
          <div id="group-back"> 
            <div class="group">
              <label>닉네임<span>&nbsp</span></label>
              <input type="text" name="memberNick" required class="sb"
                    placeholder="&nbsp 2~10자 이내의 한글,영문 대·소문자,숫자 ">
            </div>
      
            <div class="group">
              <label>전화번호<span>&nbsp</span></label>
              <input type="text" name="memberPhone" required class="sb"
                    placeholder="&nbsp-를 포함하여 입력 (예 : 010-XXXX-XXXX)">
            </div>
          </div>   
            <div class="login-btn-box">
              <input type="submit" value="수정하기" class="login-btn">
            </div>
  
        </form>
        </div>
   		 <div class="delete">
			<h5><i class="far fa-frown"></i>&nbsp밤부를 그만하신다구요?</h5>
			<a href="${pageContext.request.contextPath}/member/exit" id="delete-a">
			<span>탈퇴하기</span></a>
		</div>
  </div> 

</section>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>