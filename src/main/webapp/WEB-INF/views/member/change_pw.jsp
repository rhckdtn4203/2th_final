<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
#modiBox{
 height: 900px;
  }
#aa{
padding-right: 5px;

}
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">

<section id="modiBox">
  <div class="modiBack">
    <div id="modititle">
      <h3>CAHNGE YOUR PASSWORD</h3>
    </div>
    <figure class="snip1200">
      <div id="a">
      <img src="http://localhost:8080/khblind/img/img2.png" alt="backgroung-img"/>
      <figcaption>
        <p>비밀번호 변경 후 다시 로그인을 해주세요!</p>
        <div class="heading">
          <h3>비밀번호변경</h3>
        </div>
      </figcaption>
      
      <a href="#"></a>
      </div>
      </figure>


      <div class="input-modiBox">
        <form action="change_pw" method="post">
          <div id="group-back"> 
            <div class="group" id="aa">
            <label>현재 비밀번호</label>
              <input type="text" name="curPw" required class="sb">
            </div>
      
            <div class="group" id="aa">
              <label>새 비밀번호</label>
              <input type="text" name="newPw" required class="sb"
                   placeholder="&nbsp 8~20자 이내 영문대·소문자, 숫자, #?!@$ %^&*-">
            </div>
          </div>   
            <div class="login-btn-box">
              <input type="submit" value="변경하기" class="login-btn">
            </div>
  
        </form>
        </div>
    
  </div> 

</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>