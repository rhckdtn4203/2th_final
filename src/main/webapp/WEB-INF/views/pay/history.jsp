<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>지난 결제 내역 조회</h1>

<c:forEach var="payDto" items="${list}">
	<h1>
		[ 
		<a href="historyDetail?payNo=${payDto.payNo}">${payDto.payNo}</a> 
		]
		상태 : ${payDto.payStatus}		
	</h1>
</c:forEach>