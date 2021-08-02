<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	 th{
            display:table-cell;
            vertical-align:inherit;
            font-weight:bold;
            text-align:center;
            border:1px solid black;
        }
        table,td{
            border:1px solid black;
        }
        table{
        	width: 50%;
        	height: 100px;
        	margin: auto;
        	text-align: center;
        } 

</style>
<h1>지난 결제 내역 조회</h1>
<table class="table table-border">
	<tr>
		<th>결제 번호</th>
		<th>결제 상태 </th>
		<th>등급 만료</th>
	</tr>
<c:forEach var="payDto" items="${list}">
		<tr>
			<td>
				<a href="historyDetail?payNo=${payDto.payNo}">${payDto.payNo}</a> 
			</td>
			<td> ${payDto.payStatus} </td>
			<td> ${payDto.payExpire} </td>
		</tr>		
</c:forEach>
</table>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>