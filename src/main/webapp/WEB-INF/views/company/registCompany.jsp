<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>회사 신청하기</h1>
<h5>
	회사 정보가 등록되지 않은 경우 회사 등록을 신청할 수 있습니다.
	신청하신 회사는 검증 절차를 거친 후 등록됩니다.
</h5>

<form action="registCompany" method="post">
	<input type="text" name="companyRegistName" placeholder="회사 이름">
	<input type="text" name="companyRegistDomain" placeholder="회사 이메일 주소">
	<input type="submit" value="신청하기">
</form>