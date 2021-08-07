<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.title-text {
		font-size:23px;
		font-weight:bold;
		margin:15px;
	}
	
	.form-input {
		width:400px;
		padding:0.5rem;
		outline:none;
	}
	
	textarea.form-input {
		resize: vertical;
		min-height:150px;/*수치는 자유롭게 설정*/
		height:150px;/*수치는 자유롭게 설정*/
		max-height:500px;/*수치는 자유롭게 설정*/
	}
	
	.container {
		width:600px;
		text-align:center;
		margin: 0 auto;
	}
	
	.login-btn-box{
		background-color: var(--color-green);
		height: 40px;
	}
	
	.login-btn{
	  	position: relative;
	    margin: 5px;
	    border: none;
	    color: wheat;
	    background-color: var(--color-green);
	    font-size: 20px;
	    font-weight: var(--weight-6);
	    
	    cursor: pointer;
	    overflow: hidden;
	    text-transform: uppercase;
	    transition: 0.5s;
	}
	
	.text-center {
		text-align: center;
	}
	
	.table {
		width:100%;
	}
	
	.table > thead > tr > th, 
	.table > thead > tr > td,
	.table > tbody > tr > th,
	.table > tbody > tr > td,
	.table > tfoot > tr > th,
	.table > tfoot > tr > td {
		padding:0.5rem;
	}
</style>

<div class="container">
	<div class="title-text">
		<span>회사 리뷰 작성하기</span>
	</div>
	
	<div style="border:1px solid black;">
		<form action="reviewWrite" method="post">
			<table class="table">
				<tbody>
					<tr>
						<th>직종 분류</th>
						<td>
							<select name="jobCategoryNo" class="form-input">
								<c:forEach var="jobCategoryDto" items="${category}">
									<option value="${jobCategoryDto.jobCategoryNo}">
										${jobCategoryDto.jobCategoryName}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
						
					<tr>
						<th>별점</th>
						<td>
							<input type="number" name="reviewRate" value="1" step="1" min="1" max="5" class="form-input">
						</td>
					</tr>
						
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="reviewTitle" class="form-input">
						</td>
					</tr>
						
					<tr>
						<th>장점</th>
						<td>
							<textarea name="reviewMerit" rows="15" class="text-right form-input"></textarea>
						</td>
					</tr>
						
					<tr>
						<th>단점</th>
						<td>
							<textarea name="reviewDemerit" rows="15" class="text-right form-input"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
	
			<input type="hidden" name="companyNo" value="${map.companyNo}">
			<input type="hidden" name="memberNo" value="${map.memberNo}">
						
			<div class="login-btn-box">
				<input type="submit" value="작성 완료" class="login-btn">
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>