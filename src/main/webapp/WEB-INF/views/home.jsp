<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="rt" value="${pageContext.request.contextPath}"></c:set>
	 
	
    	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style6.css">
   
<!-- 리모컨 html 추가 -->          
 	<c:if test="${dtoss != null}">

	<div id="floatMenu">
   
	  <div id="fTitle">
	  <p style="font-size: 25px; margin:0;">Quick!</p>
	  <p id="fTitle-p">menu</p>
	  </div>
   
   	<div id="fItems">
      <div class="fItem"><a href="${pageContext.request.contextPath}/board/boardList?type=companyBoard"><span>'내 회사'</span><br>이야기</a></div>
      <div class="fItem" id="fItem"><a href="${pageContext.request.contextPath}/board/boardList?type=jobCategoryBoard"><span>'내 업종'</span><br>이야기</a></div>
      <div class="fItem" id="fItem"><a href="${pageContext.request.contextPath}/plus/plusPage"><span>모든 업종</span></a></div>
  	</div>
   
   <div>
   <button id="arrow"><i class="far fa-arrow-alt-circle-up"></i>top</button>
   </div>

	</div>
    	</c:if>
    
 <!-- 검색창 -->   
    <section id="searchBar">
        <div id="inputBar">
          <form id="bar" action="${rt}/board/boardList" method="get" class="search">
            <span id="input-icon"><i class="fas fa-search"></i></span> 
            <input type="hidden" name="type" value="boardCategoryBoard">  
            <input id="search-input" type="text" name="keyword" required
         	autocomplete="on" placeholder="관심있는 내용을 검색해보세요!">
         	<!-- <input type="submit" value="검색"> -->
          </form>
          
        </div>    
        <div class="welcome-box">	
			<c:if test="${dtoss != null }">
				<p id="p-search"><span id="p-span">${dtoss.memberNick}</span>님  환영합니다!</p>
			</c:if>
		</div>
     </section>


      <section id="section1">
        <div class="s1Box" id="sb1">
          <div class="topic-best">
            <div class="topic-best-titme">
              <h2 id="jj"><i class="fas fa-crown"></i> 토픽베스트</h2>
              <a href="#">>더보기</a>
            </div>
            
           <c:forEach var="BestTopicDto" items="${BoardCategoryListByLikeCount}"> 
            <div class="article-best">
             
              <div class="b1">
                <span class="topic">
                  <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${BestTopicDto.boardCategoryNo}" class="tit-title">${BestTopicDto.boardCategoryName}</a>
                </span>
                <a href="${rt}/board/boardDetail?boardNo=${BestTopicDto.boardNo}" class="tit"><span>${BestTopicDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${BestTopicDto.likeCount}</span>     
                <i class="far fa-comment-alt"><span>${BestTopicDto.commentsCount}</span></i>
              </div>
              
            </div>
            </c:forEach>
 
    
       
          </div> 
        </div>

            

        <div class="s1Box" id="sb2">
           	<div id="aside">
					<div class="row text-left"><h3 style="font-weight:bold;"> 실시간 검색 순위</h3></div>
					<div id="ranking" class="row"></div>
			</div>
        </div>

      </section>

      <section id="section2">
        <section id="section2s">
        <div class="m1Box" id="mb1">
        
          <div class="article" id="a1">
            <!-- title -->
            <div class="articleTitle"> 
              <h3 id="qq">
                <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryList1[0].boardCategoryNo}">
              ${mainBoardCategoryList1[0].boardCategoryIcon}
              ${mainBoardCategoryList1[0].boardCategoryName}</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList1}">
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="${rt}/board/boardDetail?boardNo=${mainBoardCategoryDto.boardNo}">${mainBoardCategoryDto.boardTitle}</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>${mainBoardCategoryDto.boardCount}</span>     
              </div> 
            </div>  
         	</c:forEach>
          </div>
          
  
  
  		
          <div class="article" id="a2">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryList2[0].boardCategoryNo}">
               ${mainBoardCategoryList2[0].boardCategoryIcon}
               ${mainBoardCategoryList2[0].boardCategoryName}</a>
              </h3> 
              
              <hr>
            </div>
            <!-- content -->
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList2}">
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="${rt}/board/boardDetail?boardNo=${mainBoardCategoryDto.boardNo}">${mainBoardCategoryDto.boardTitle}</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>${mainBoardCategoryDto.boardCount}</span>     
              </div> 
            </div>  
  			</c:forEach>
          </div>
          
  
          <div class="article" id="a3">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryList3[0].boardCategoryNo}">
              ${mainBoardCategoryList3[0].boardCategoryIcon}
              ${mainBoardCategoryList3[0].boardCategoryName}</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
				<c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList3}">
					<div class="arti1">
						<div class="m1">
							<span class="article-description"> 
							<a href="${rt}/board/boardDetail?boardNo=${mainBoardCategoryDto.boardNo}">${mainBoardCategoryDto.boardTitle}</a>
							</span>
						</div>
						<div class="m2">
							<i class="fas fa-mouse"></i><span>${mainBoardCategoryDto.boardCount}</span>
						</div>
					</div>
				</c:forEach>
			</div>
      </div>
  
  
          <div class="m1Box" id="mb2">
         
          <div class="article" id="bb1">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryList4[0].boardCategoryNo}">
              ${mainBoardCategoryList4[0].boardCategoryIcon}
              ${mainBoardCategoryList4[0].boardCategoryName}</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
             <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList4}">
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="${rt}/board/boardDetail?boardNo=${mainBoardCategoryDto.boardNo}">${mainBoardCategoryDto.boardTitle}</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>${mainBoardCategoryDto.boardCount}</span>     
              </div> 
            </div>  
  
          </c:forEach>
          </div>
          
  
  
          <div class="article" id="bb2">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryList5[0].boardCategoryNo}">
                ${mainBoardCategoryList5[0].boardCategoryIcon}
              	${mainBoardCategoryList5[0].boardCategoryName}</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList5}">
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="${rt}/board/boardDetail?boardNo=${mainBoardCategoryDto.boardNo}">${mainBoardCategoryDto.boardTitle}</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>${mainBoardCategoryDto.boardCount}</span>     
              </div> 
            </div>  
  
          </c:forEach>
          </div>       
  
  
          <div class="article" id="bb3">
            <!-- title -->
            <div class="articleTitle"> 
              <h3 id="qq">
                <a href="${rt}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryList6[0].boardCategoryNo}">
             	${mainBoardCategoryList6[0].boardCategoryIcon}
              	${mainBoardCategoryList6[0].boardCategoryName}</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList6}">
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="${rt}/board/boardDetail?boardNo=${mainBoardCategoryDto.boardNo}">${mainBoardCategoryDto.boardTitle}</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>${mainBoardCategoryDto.boardCount}</span>     
              </div> 
            </div>  
  
          </c:forEach> 
          </div>
        </div>
  
        </section>
      </section>

 <!-- 리모컨 script 추가 -->     
<script>
$(document).ready(function() {
   var floatPosition = parseInt($("#floatMenu").css('top'));

   $(window).scroll(function() {
      // 현재 스크롤 위치를 가져온다.
      var scrollTop = $(window).scrollTop();
      var newPosition = scrollTop + floatPosition + "px";


      $("#floatMenu").stop().animate({
         "top" : newPosition
      }, 500);

   }).scroll();

});
</script>
 
 <script>
const arrow = document.querySelector('#arrow');

function scroll(selector){
   const scrollTo = document.querySelector(selector);
   scrollTo.scrollIntoView({ behavior: 'smooth' });
}

arrow.addEventListener('click', () => {
   scroll('#header');
});
</script>     
      
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

