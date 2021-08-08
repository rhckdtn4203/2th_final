<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	#review-title {
		font-size:30px;
		font-weight:700;
	}
	
	#popular-title {
		font-size:23px;
		font-weight:700;
	}
	
	.popular-box {
		text-align:left;
		padding:10px 100px 100px 100px;
	}
	
	.company-box {
		border:1px solid black;
		padding:20px 0px;
		margin:5px 5px;
	}
	
	.company-title {
		margin:0 auto;
	}
	
	.one-star {
	  	color: #fff58c;
	 	padding: 0;
	 	z-index: 1;
	 	display: flex;
	  	left: 0;
	  	overflow: hidden;
	  	-webkit-text-fill-color: gold;
	  	float:left;
	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

<div>
	<div>
		<h1 id="review-title">진짜 현직자들의 회사 리뷰</h1>
	</div>

	<form action="${pageContext.request.contextPath}/company/" method="post" class="form-inline">
		<div class="col-sm-4" style="float:none; margin:0 auto;">
			<input type="text" name="keyword" class="form-control" style="width:70%;" placeholder="회사 이름으로 검색" required>
			<input type="submit" value="검색" class="btn btn-outline-dark">
		</div>
	</form>
	
	<div style="font-size:13px">
		<br>
		<span>찾으시는 회사가 없으신가요?</span>
		<a href="${pageContext.request.contextPath}/company/registCompany" style="text-decoration:underline">
			궁금하신 회사를 직접 신청해주세요!
		</a>
	</div>
	
	<div class="popular-box">
		<c:choose>
			<c:when test="${param.keyword == null}">
				<!-- 회사 별점순 3*2로 보여주기 -->
				<h3 id="popular-title">인기 회사</h3>
				
				<div class="container-fluid">
					<div class="row">
						<c:forEach var="company" items="${topSixList}">
							<div class="col-3 company-box">
								<c:forEach var="v" items="${company}">
									<c:choose>
										<c:when test="${v.key == 'COMPANY_NAME'}">
											<span style="font-size:18px; font-weight:bold">${v.value}</span>
										</c:when>
										<c:when test="${v.key == 'RATE_AVG'}">
											<div style="margin:0 auto;">
												<div class="one-star">
													<span>★</span>
													<span style="font-size:18px; font-weight:bold">${v.value}</span>
												</div>
											</div>
										</c:when>
										<c:when test="${v.key == 'COMPANY_NO'}">
											<a href="${pageContext.request.contextPath}/company/companyDetail?companyNo=${v.value}" style="text-decoration:underline">회사 정보</a>
											<a href="${pageContext.request.contextPath}/company/companyReview?companyNo=${v.value}" style="text-decoration:underline">리뷰</a>
											<a href="${pageContext.request.contextPath}/company/companyBoard?companyNo=${v.value}" style="text-decoration:underline">게시물</a>
											<br>
										</c:when>
									</c:choose>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${size == 0}">
						<p style="text-align:center;">'${param.keyword}'가 들어간 회사가 없습니다.</p><br><br>
						
						<h3 id="popular-title">인기 회사</h3>
						
						<div class="container-fluid">
							<div class="row">
								<c:forEach var="company" items="${topSixList}">
									<div class="col-3 company-box">
										<c:forEach var="v" items="${company}">
											<c:choose>
												<c:when test="${v.key == 'COMPANY_NAME'}">
													<span style="font-size:18px; font-weight:bold">${v.value}</span>
												</c:when>
												<c:when test="${v.key == 'RATE_AVG'}">
													<div style="margin:0 auto;">
														<div class="one-star">
															<span>★</span>
															<span style="font-size:18px; font-weight:bold">${v.value}</span>
														</div>
													</div>
												</c:when>
												<c:when test="${v.key == 'COMPANY_NO'}">
													<a href="${pageContext.request.contextPath}/company/companyDetail?companyNo=${v.value}" style="text-decoration:underline">회사 정보</a>
													<a href="${pageContext.request.contextPath}/company/companyReview?companyNo=${v.value}" style="text-decoration:underline">리뷰</a>
													<a href="${pageContext.request.contextPath}/company/companyBoard?companyNo=${v.value}" style="text-decoration:underline">게시물</a>
													<br>
												</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<!-- 3*2로 보여주기 -->
						<h3 id="popular-title">'${param.keyword}'가 들어간 회사 목록</h3><br><br>
						
						<div class="container-fluid">
							<div class="row">
								<c:forEach var="company" items="${searchList}">
									<div class="col-3 company-box">
										<c:forEach var="v" items="${company}">
											<c:choose>
												<c:when test="${v.key == 'COMPANY_NAME'}">
													<span style="font-size:18px; font-weight:bold">${v.value}</span>
												</c:when>
												<c:when test="${v.key == 'RATE_AVG'}">
													<div style="margin:0 auto;">
														<div class="one-star">
															<span>★</span>
															<span style="font-size:18px; font-weight:bold">${v.value}</span>
														</div>
													</div>
												</c:when>
												<c:when test="${v.key == 'COMPANY_NO'}">
													<a href="${pageContext.request.contextPath}/company/companyDetail?companyNo=${v.value}" style="text-decoration:underline">회사 정보</a>
													<a href="${pageContext.request.contextPath}/company/companyReview?companyNo=${v.value}" style="text-decoration:underline">리뷰</a>
													<a href="${pageContext.request.contextPath}/company/companyBoard?companyNo=${v.value}" style="text-decoration:underline">게시물</a>
													<br>
												</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
