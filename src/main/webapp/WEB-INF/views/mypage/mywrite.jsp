<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
 
  .wrap-myWrite{  
      width: 1200px;  
      height:1100px; 	
  }  
  .mainArea{  
      float:right;  
      margin-top: 300px;  
      margin-left: 50px;  
        border-bottom: 2px solid lightgray;    
      width: 1000px;  
  }  
  .boardTitle{  
  font-size: 30px;  
  color: black;  
  text-decoration:none;  
  }  
  .boardContent{  
  font-size: 20px;  
  color: lightgray;  
  }  
 .boardDate{  
 font-size: 5px;  
 color: black;  
 text-align: right;  
 border-bottom: 2px solid lightgray;  
 }  


         </style> 
         <script src="https://code.jquery.com/jquery-3.6.0.js"></script> 

 <div class="wrap-myWrite">
    
     
     <div class="mainArea">
         <div>
         <c:forEach var="BoardCategoryVO" items="${mywriteList}">
	<p> [${BoardCategoryVO.boardCategoryName}]</p>
 	<a class="boardTitle" href="${pageContext.request.contextPath}/board/boardDetail?boardNo=${BoardCategoryVO.boardNo}">${BoardCategoryVO.boardTitle}</a>
 	<p class="boardDate">${BoardCategoryVO.boardDate}</p>
 	</c:forEach>
        
    	</div>
 	</div>
	




 </div>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
