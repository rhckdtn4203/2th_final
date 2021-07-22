<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>회사 신청 목록보기</h1>

<ul class="companyRegistList">
	<c:forEach var="companyRegistDto" items="${list }">
		<li>
			<p>${companyRegistDto.companyRegistNo }</p>
			<p>${companyRegistDto.companyRegistName }</p>
			<p>${companyRegistDto.companyRegistDomain }</p>
		</li>
	</c:forEach>
</ul>