<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function() {
		$(".companyRegistDelete").click(function() {
			var chk = confirm("정말 삭제하시겠습니까?");
			if (chk) {
				var companyRegistNo = $(this).parents("tr").children().eq(0).text();
				location.href='companyRegistList/delete?companyRegistNo='+companyRegistNo;
			}
		});
	});

	$(function() {
		$(".companyRegist").click(function(){
			var companyRegistNo = $(this).parents("tr").children().eq(0).text();
			var companyRegistName = $(this).parents("tr").children().eq(1).text();
			var companyRegistDomain = $(this).parents("tr").children().eq(2).text();

			$.ajax({
				url:"${pageContext.request.contextPath}/admin/companyRegistList",
				data:{
					companyRegistName : companyRegistName
				},
				type:"post",
				success:function(resp) { //"Y"는 없는 도메인, "N"은 이미 존재하는 도메인으로 처리
					if(resp === "Y") {
						location.href='insertCompany?companyRegistNo='+companyRegistNo+
						'&companyName='+companyRegistName+
						'&companyDomain='+companyRegistDomain;
					}
					else if(resp === "N"){
						alert("이미 존재하는 회사입니다");
					}
				}
			});
		});
	});
</script>

<h1>회사 신청 목록보기</h1>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>회사 이름</th>
			<th>회사 주소</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="companyRegistDto" items="${list}">
			<tr>
				<td>${companyRegistDto.companyRegistNo}</td>
				<td>${companyRegistDto.companyRegistName}</td>
				<td>${companyRegistDto.companyRegistDomain}</td>
				<td>
					<input type="button" class="companyRegist" name="companyRegist" value="등록">
					<input type="button" class="companyRegistDelete" name="companyRegistDelete" value="삭제">
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>