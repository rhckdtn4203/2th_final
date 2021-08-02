<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<h1>회사 리뷰 작성하기</h1>
<h5>${map.companyNo}, ${map.memberNo}</h5>

<hr>

<form action="reviewWrite" method="post">

	<select name="jobCategoryNo">
		<c:forEach var="jobCategoryDto" items="${category}">
			<option value="${jobCategoryDto.jobCategoryNo}">
				${jobCategoryDto.jobCategoryName}
			</option>
		</c:forEach>
	</select>
	
	<input type="number" name="reviewRate" value="1" step="1" min="1" max="5">
	<input type="text" name="reviewTitle">
	<input type="text" name="reviewMerit">
	<input type="text" name="reviewDemerit">
	
	<input type="hidden" name="companyNo" value="${map.companyNo}">
	<input type="hidden" name="memberNo" value="${map.memberNo}">
	
	<input type="submit" value="작성 완료">
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>