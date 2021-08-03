<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
			<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
			<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">
          
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	.ml-10{
	margin-left: 11rem;
	}

</style>

	<div class="row ml-10">
		<c:forEach var="JobCategoryDto" items="${getPlusJobCategoryInfoList}">
			<div class="col-3 mt-3">
				<a href="${root}/board/boardList?type=jobCategoryBoard&jobCategoryNo=${JobCategoryDto.jobCategoryNo}">
					<button class="btn btn-success">${JobCategoryDto.jobCategoryName}</button>
				</a>
			</div>
		</c:forEach>
	</div>









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>