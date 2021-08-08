<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
#wrap{
height: 1650px; 
}
#modiBox{
 height: 1200px;
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.13.1/validate.min.js"></script>
<script>

function validate() {
        //event.preventDefault();
        var objID = document.getElementById("memberId");
        var objPwd1 = document.getElementById("memberPw");
        var objPwd2 = document.getElementById("reMemberPw");
        var objEmail = document.getElementById("memberEmail");
        var objName = document.getElementById("memberName");
        var objNum1 = document.getElementById("my_num1");
        var objNum2 = document.getElementById("my_num2");
 
        var arrNum1 = new Array();
        var arrNum2 = new Array();
 
    
 
        //아이디와 패스워드 값 데이터 정규화 공식
        var regul0 = /^[a-zA-Z0-9#?!@$ %^&*-]{8,20}$/;
        var regul1 = /^[a-zA-Z0-9]{8,20}$/;
        //이메일 값 데이터 유효성 체크
        //[]안에 있는 값만 쓰겠다
 
        //이메일 정규화 공식
        var regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
        //이름 정규화 공식
        var regul3 = /^[가-힝a-zA-Z]{2,}$/;
        //var email = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
 
        //아이디 입력 하지 않았을 경우
        if ((objID.value) == ""){
            alert("아이디를 입력하지 않았습니다.");
            objID.focus();
            return false;
        }
        //아이디 유효성 검사
        //내가 입력한 데이터를 검사하는 check()
        //만약 내가 아이디에 정규화 방식을 하나라도 지키지 않으면 if문 안으로 들어가서 alert message를 띄움
        if (!check(regul1,objID,"8~20자 영문, 숫자")) {
            return false;//반환 할 곳 없이 if문 탈출
        }
        //비밀번호 입력 하지 않았을 경우
        if ((objPwd1.value) == ""){
            alert("비밀번호를 입력해 주세요");
            objPwd1.focus();
            return false;
        }
        if ((objPwd2.value=="")){
            alert("비밀번호를 입력해 주세요");
            objPwd2.focus();
            return false;
        }
 
        //비밀번호 유효성 검사
        //만약 내가 비밀번호에 정규화 방식을 하나라도 지키지 않으면 if문 안으로 들어가서 alert message를 띄움
        if (!check(regul0,objPwd1,"8~20자의 영문, 숫자, #?!@$ %^&*-")) {
            return false;
        }
        
        //비밀번호와 비밀번호 확인이 일치 하지 않을 경우
        if ((objPwd1.value)!=(objPwd2.value)) {
            alert("비밀번호가 일치 하지 않습니다.");
            objPwd1.focus();
            objPwd2.focus();
            return false;
        }
        //이메일 입력 안했을 경우
        if ((objEmail.value)=="") {
            alert("이메일을 입력해 주세요");
            objEmail.focus();
            return false;
        }
        //이메일이 잘못된 경우
        if (!check(regul2,objEmail,"이메일을 잘못 입력 했습니다.")) {
            return false;
        }
        //이름 입력 안 한 경우
        if ((objName.value)=="") {
            alert("이름을 입력해 주세요");
            objName.focus();
            return false;
        }
        //이름에 특수 문자가 들어간 경우
        if (!check(regul3,objName,"이름이 잘못 되었습니다.")) {
        	return false;
        }
	}
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>