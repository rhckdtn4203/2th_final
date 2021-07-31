<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="rt" value="${pageContext.request.contextPath}"></c:set>
	
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
   
    
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
            
            <div class="article-best">
              <div class="b1">
                <span class="topic">
                  <a href="#" class="tit-title">반려동물</a>
                </span>
                <a href="#" class="tit"><span> 우리집 강아지는 복슬강아지</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>1</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
            </div>
    
            <div class="article-best">
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList-1}">
              <div class="b1">
                <span class="topic">
                  <a href="/board/boardList?type=boardCategoryBoard&boardCategoryNo=${mainBoardCategoryDto[0].boardCategoryNo}" class="tit-title">
                  	${mainBoardCategoryList-1[0].boardCategoryIcon}
                  	${mainBoardCategoryList-1[0].boardCategoryName}
                  </a>
                </span>  
                <a href="${rt}" class="tit"><span>${mainBoardCategoryDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${mainBoardCategoryDto.boardCount}</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
             </c:forEach> 
            </div>
    
            <div class="article-best">
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList-2}">
              <div class="b1">
                <span class="topic">
                  <a href="#" class="tit-title">
                  	${mainBoardCategoryList-2[0].boardCategoryIcon}
                  	${mainBoardCategoryList-2[0].boardCategoryName}
                  </a>
                </span>
                <a href="#" class="tit"><span>${mainBoardCategoryDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${mainBoardCategoryDto.boardCount}</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
             </c:forEach> 
            </div>
            
            <div class="article-best">
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList-3}">
              <div class="b1">
                <span class="topic">
                  <a href="#" class="tit-title">
                  	${mainBoardCategoryList-3[0].boardCategoryIcon}
                  	${mainBoardCategoryList-3[0].boardCategoryName}
                  </a>
                </span>
                <a href="#" class="tit"><span>${mainBoardCategoryDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${mainBoardCategoryDto.boardCount}</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
             </c:forEach> 
            </div>
            
            <div class="article-best">
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList-4}">
              <div class="b1">
                <span class="topic">
                  <a href="#" class="tit-title">
                  	${mainBoardCategoryList-4[0].boardCategoryIcon}
                  	${mainBoardCategoryList-4[0].boardCategoryName}
                  </a>
                </span>
                <a href="#" class="tit"><span>${mainBoardCategoryDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${mainBoardCategoryDto.boardCount}</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
             </c:forEach> 
            </div>
            
            <div class="article-best">
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList-5}">
              <div class="b1">
                <span class="topic">
                  <a href="#" class="tit-title">
                  	${mainBoardCategoryList-5[0].boardCategoryIcon}
                  	${mainBoardCategoryList-5[0].boardCategoryName}
                  </a>
                </span>
                <a href="#" class="tit"><span>${mainBoardCategoryDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${mainBoardCategoryDto.boardCount}</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
             </c:forEach> 
            </div>
            
            <div class="article-best">
            <c:forEach var="mainBoardCategoryDto" items="${mainBoardCategoryList-6}">
              <div class="b1">
                <span class="topic">
                  <a href="#" class="tit-title">
                  	${mainBoardCategoryList-6[0].boardCategoryIcon}
                  	${mainBoardCategoryList-6[0].boardCategoryName}
                  </a>
                </span>
                <a href="#" class="tit"><span>${mainBoardCategoryDto.boardTitle}</span></a>
              </div>
              <div class="b2">
                <i class="far fa-thumbs-up"></i><span>${mainBoardCategoryDto.boardCount}</span>     
                <i class="far fa-comment-alt"><span>1</span></i>
              </div>
             </c:forEach> 
            </div>
    
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
                <a href="#">
              <i class="far fa-comments"></i>블라블라1</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
          <div class="arti1">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 블라블라 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
          </div>
  
  
  
          <div class="article" id="a2">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="#">
               <i class="fas fa-chart-line"></i>주식</a>
              </h3> 
              
              <hr>
            </div>
            <!-- content -->
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
          <div class="arti1">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 블라블라 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>
          </div>
  
  
          <div class="article" id="a3">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="#">
              <i class="fab fa-bitcoin"></i>암호화폐</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
          <div class="arti1">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 블라블라 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>
          </div>
      </div>
  
  
          <div class="m1Box" id="mb2">
          <div class="article" id="bb1">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="#">
              <i class="fab fa-gratipay"></i>썸·연애</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
          <div class="arti1">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 블라블라 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>
          </div>
  
  
          <div class="article" id="bb2">
            <!-- title -->
            <div class="articleTitle">
              <h3 id="qq">
                <a href="#">
               <i class="fas fa-briefcase"></i>이직·커리어</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
          <div class="arti1">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 블라블라 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>
          </div>       
  
  
          <div class="article" id="bb3">
            <!-- title -->
            <div class="articleTitle"> 
              <h3 id="qq">
                <a href="#">
             <i class="fas fa-route"></i>여행·먹방</a>
              </h3>  
              <hr>
            </div>
            <!-- content -->
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
            <div class="arti1">  
              <div class="m1">
                <span class="article-description">
                <a href="#">우와 블라블라 조아요</a>
                </span>
              </div>  
              <div class="m2">
                  <i class="fas fa-mouse"></i><span>1</span>     
              </div> 
            </div>  
  
          <div class="arti1">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 블라블라 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
          </div>
        </div>
  
        </section>
      </section>
      
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>