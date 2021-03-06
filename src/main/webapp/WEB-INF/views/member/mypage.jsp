<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style3.css">

<section id="pageBox">
	<div class="bookMark">
		<a href="${pageContext.request.contextPath}/board/mybookmark"><i class="far fa-bookmark"></i><span>BOOK<br>MARK
		</span></a>
	</div>

	<div class="page-wrap">

		<div class="pageLeft">

			<div class="container">
				<div class="stage" id="stage1">
					<div class="pageimg">
						<img id="stimg" src="http://localhost:8080/khblind/img/star.PNG">
					</div>

					<div class="pageimg-description">
						<h3>
							"${dtoss.memberName}"님은<br> 현재 "${companyName}"의 스타<i class="fas fa-star"></i>입니다 ;)
						</h3>
					</div>
				</div>
			</div>
		<!-- pageLeft end-->
		</div>

		<div class="pageRight">
			<div class="info-box">
				<div class="ib1">
					<div class="infoItem">
						<a href="${pageContext.request.contextPath}/member/changeinfo">개인정보변경</a>
					</div>
					<div class="infoItem">
						<a href="${pageContext.request.contextPath}/member/change_pw">비밀번호변경</a>
					</div>
				</div>
				<div class="ib1">
					<div class="infoItem">
						<a href="${pageContext.request.contextPath}/cert/emailInsert">정회원인증</a>
					</div>
					<div class="infoItem">
						<a href="${pageContext.request.contextPath}/cert/imageInsert">사원증인증</a>
					</div>
					
					
				</div>
			</div>

			<section id="wrapper">
				<div class="b-container">
					<div class="container">
						<ul class="accordion">
							<li class="item">
								<h2 class="accordionTitle">
									   내가 작성한 게시글 <span class="accIcon"></span>
                        </h2>
                        <div class="text">
                           <c:forEach var="BoardCategoryVO" items="${myWriteList}">
                           <ul>
                              <li><a href="${pageContext.request.contextPath}/board/boardDetail?boardNo=${BoardCategoryVO.boardNo}">[${BoardCategoryVO.boardCategoryName}]|${BoardCategoryVO.boardTitle}</a></li>
                           </ul>
                           </c:forEach>
                        </div>
					</div>
				</div>
			</section>
			<!-- pageRight end -->	
			</div>
	<!-- .page-wrap end -->	
	</div>
<!-- pageBox end -->	
</section>



<!-- 별 효과 주기 -->    
<script src="${pageContext.request.contextPath}/js/st.js"></script>    

<!--내가 쓴 게시글 아코디언 -->    
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/st2.js"></script>	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>