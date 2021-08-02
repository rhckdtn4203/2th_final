<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
 
 
  <!-- 부트스트랩을 가져온다 -->
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
       <!-- 제이쿼리를 가져온다 -->
       <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
       <!-- UI제이쿼리를  가져온다 -->
       <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
       <!-- Popper를 가져온다 -->
       <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
       <!-- 폰트어썸 아이콘을 가져온다-->
       <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
       <!-- 부트와치를 가져온다.-->
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<style>
.img{
margin-top: 50px;
width:400px;
heigh:400px;
text-align:center;
}
.imgArea{
text-align:center;
}
.errorMessage{
text-align:center;
color:blue;
}
.mainMove{ 
text-align:center; 
color:blue; 
}
.btn{
margin-right: 2px;
}
</style>
    
     <div class="imgArea">
    <img class="img" src="${root}/img/pay.jpg">
    </div>
   <br>
    <h1 class="errorMessage">결제가 필요한 서비스입니다</h1>
   <br>
   <div class="mainMove">
    <a class="btn btn-primary" href="${root}/pay/upgrade">결제페이지로 이동</a><a class="btn btn-primary" href="${root}/board/boardList?type=jobCategoryBoard">내 업종 보러가기</a>
    </div>


    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>