<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<p>${boardDto.boardNo}</p>
<p>${boardDto.memberNo}</p>
<!-- memberNo가 아니라 닉네임 or 아이디를 띄어 줘야 함 --> 
<p>${boardMemberVO.memberNick}</p>
<p>${boardDto.boardTitle}</p>
<p>${boardDto.boardContent}</p>
<p>${boardDto.boardCount}</p>
<p>${boardDto.boardDate}</p>

<!-- 글쓰기 탭은 header에 있음 -->          <!-- 현재 글번호 전달하여, 현재글의 수정페이지 이동 -->
<a href="${root}/boardEdit?boardNo=${boardDto.boardNo}">수정</a>
<a href="${root}/boardDelete?boardNo=${boardDto.boardNo}">삭제</a> 
<a href="#">목록</a>   

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>