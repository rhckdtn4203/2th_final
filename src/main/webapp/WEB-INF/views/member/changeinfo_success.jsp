<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">

<section class="section-3">
  
  <div class="successTitle-box">
    <h2>내 정보가 수정되었습니다!</h2>
  </div>

  <div class="success-box">
    
    <div class="row">
      <h3><a href="${pageContext.request.contextPath}"><i class="fas fa-laptop-house"></i>홈</a></h3>
    </div>
  
	
    <div class="row">
      <h3><a href="${pageContext.request.contextPath}/member/mypage" id="delete-a"><span>내 정보</span></a></h3>
    </div>
  </div>

</section>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>