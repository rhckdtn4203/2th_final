<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
#wrap{
height: 1450px; 
}

#modiBox{
 height: 1000px;
  }
  
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">

<section id="modiBox">
  <div class="signBack">
    <div id="modititle">
      <h3>SIGN UP</h3>
    </div>
    <figure class="snip1200">
      <div id="a">
      <img src="http://localhost:8080/khblind/img/img1.png" alt="backgroung-img"/>
      <figcaption>
        <p>회원가입 후 당신의 WORK LIFE를 공유해보세요!<br>
        밤부는 당신의 스트레스를 해소하면서도 즐거운 소통창구입니다. </p>
        <div class="heading">
          <h3>회원가입</h3>
        </div>
      </figcaption>
      
      </figure>


      <div class="input-signBox">
        <form action="signup" method="post">

          <div id="groups"> 
            <div class="group">
              <label>이름</label><span>&nbsp</span>
              <input type="text" name="memberName" required class="sb" check_result="fail" id="memberName">
            <!-- <button type="button" class="id_overlap_button" onclick="id_overlap_check()">중복검사</button> -->
           <!-- <i id="id_check_success" style="display: none;" class="fas fa-check-square"></i> -->
            </div>
            
            <div class="group">
              <label>아이디</label><span>&nbsp</span>
              <input type="text" name="memberId" required class="sb" id="memberId" maxlength="20"
                    placeholder="&nbsp 8~20자 이내 영문 대·소문자, 숫자">
            </div>
            <div class="group">
              <label>비밀번호</label><span>&nbsp</span>
              <input type="password" name="memberPw" required class="sb" id="memberPw"
                    placeholder="&nbsp 8~20자 이내 영문대·소문자, 숫자, #?!@$ %^&*-">
            </div>
            <div class="group">
              <input type="password" class="sb" id="reMemberPw" name="reMemberPw"
                    placeholder="&nbsp 비밀번호 재확인">
            </div>
          
            <div class="group">
              <label>전화번호</label><span>&nbsp</span>
              <input type="text" name="memberPhone" required class="sb" id="memberPhone"
                    placeholder="&nbsp -를 포함하여 입력 (예 : 010-XXXX-XXXX)">
            </div>
            
            <div class="group">
              <label>이메일</label><span>&nbsp</span>
              <input type="text" name="memberEmail" class="sb" id="memberEmail">
            </div>
            <div class="group">
              <label>닉네임</label><span>&nbsp</span>
              <input type="text" name="memberNick" required class="sb" id="memberNick"
                    placeholder="&nbsp 2~10자 이내 한글,영문 대·소문자,숫자 ">
            </div>
            </div>
          
    
          <div class="sign-btn-box">
            <input type="submit" value="가입하기" class="login-btn">
          </div>
        </form>
    </div>
        <!-- 클래스 signBack -->
        </div>   

</section>

<script src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.13.1/validate.min.js"></script>
<script src="${pageContext.request.contextPath}/js/signup.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>