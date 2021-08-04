<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="${pageContext.request.contextPath}/company/" method="post">
	<input type="text" name="keyword" required>
	<input type="submit" value="검색">
</form>

<c:choose>
	<c:when test="${param.keyword == null}">
		<!-- 회사 별점순 3*2로 보여주기 -->
		<span>인기 회사</span><br><br>
		
		<c:forEach var="company" items="${topSixList}">
			<span>
				<c:forEach var="v" items="${company}">
					<c:if test="${v.key != 'RN'}">
						${v.value} 
					</c:if>
				</c:forEach>
			</span><br>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${size == 0}">
				<span>'${param.keyword}'가 들어간 회사가 없습니다.</span><br><br>
				
				<span>인기 회사</span><br>
				
				<c:forEach var="company" items="${topSixList}">
					<span>
						<c:forEach var="v" items="${company}">
							<c:if test="${v.key != 'RN'}">
								${v.value} 
							</c:if>
						</c:forEach>
					</span><br>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<!-- 3*2로 보여주기 -->
				<span>'${param.keyword}'가 들어간 회사 목록</span><br><br>
				
				<c:forEach var="company" items="${searchList}">
					<span>
						<c:forEach var="v" items="${company}">
							${v.value} 
						</c:forEach>
					</span><br>
				</c:forEach>	
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>