<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
 
 
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">
<style>
.img{
width:400px;
heigh:400px;
text-align:center;
}
.imgArea{
text-align:center;
}
.errorMessage{
text-align:center;
color:red
}
 .mainMove{
 text-align: center;
 
 }
</style>
    
   
    <div class="imgArea">
    <img class="img" src="${root}/img/error.jpg">
    </div>
   <br>
    <h1 class="errorMessage">허용하지않는 접근입니다</h1>
   <br>
   <div class="mainMove">
    <a class="btn btn-danger"href="${root}">메인으로 이동</a>
    </div>
    
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>