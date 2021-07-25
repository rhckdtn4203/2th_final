<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <section id="container1">
      <div class="search-bar">
      	<div class="welcome-box">
				
			<c:if test="${dtoss != null }">
				<p id="p-search"><span id="p-span">${dtoss.memberNick}</span>님<br>
				환영합니다!</p>
			</c:if>
		</div>
		
		<div class="search-box">
        <form id="searchbar" action="#" method="post">
          <div class="abox">
          <label for="search-input"></label> 
          <span id="input-icon"><i class="fas fa-search"></i></span>   
          <input id="search-input" type="text"
          autocomplete="on" placeholder="'관심있는 내용을 검색해보세요!">
          </div>    
        </form>
        </div>
        
      </div>
    </section>

    <section id="container2">

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
          <div class="b1">
            <span class="topic">
              <a href="#" class="tit-title">유머</a>
            </span>
            <a href="#" class="tit"><span>아이스크림 주세여</span></a>
          </div>
          <div class="b2">
            <i class="far fa-thumbs-up"></i><span>1</span>     
            <i class="far fa-comment-alt"><span>1</span></i>
          </div>
        </div>


        <div class="article-best">
          <div class="b1">
            <span class="topic">
              <a href="#" class="tit-title">반려동물</a>
            </span>
            <a href="#" class="tit"><span> 블 라블라</span></a>
          </div>
          <div class="b2">
            <i class="far fa-thumbs-up"></i><span>1</span>     
            <i class="far fa-comment-alt"><span>1</span></i>
          </div>
        </div>
        <div class="article-best">
          <div class="b1">
            <span class="topic">
              <a href="#" class="tit-title">직장인 취미생활</a>
            </span>
            <a href="#" class="tit"><span> 탁구짱</span></a>
          </div>
          <div class="b2">
            <i class="far fa-thumbs-up"></i><span>1</span>     
            <i class="far fa-comment-alt"><span>1</span></i>
          </div>
        </div>
        <div class="article-best">
          <div class="b1">
            <span class="topic">
              <a href="#" class="tit-title">스포츠</a>
            </span>
            <a href="#" class="tit"><span>이건 안해도되지 않을까?</span></a>
          </div>
          <div class="b2">
            <i class="far fa-thumbs-up"></i><span>1</span>     
            <i class="far fa-comment-alt"><span>1</span></i>
          </div>
        </div>
        <div class="article-best">
          <div class="b1">
            <span class="topic">
              <a href="#" class="tit-title">코로나 바이러스</a>
            </span>
            <a href="#" class="tit"><span> 이것도 그닥..</span></a>
          </div>
          <div class="b2">
            <i class="far fa-thumbs-up"></i><span>1</span>     
            <i class="far fa-comment-alt"><span>1</span></i>
          </div>
        </div>
        <div class="article-best">
          <div class="b1">
            <span class="topic">
              <a href="#" class="tit-title">직접홍보</a>
            </span>
            <a href="#" class="tit"><span> 지금 안사면 백퍼 손해</span></a>
          </div>
          <div class="b2">
            <i class="far fa-thumbs-up"></i><span>1</span>     
            <i class="far fa-comment-alt"><span>1</span></i>
          </div>
        </div>

      </div>    

      <aside>
        <h2 id="kk">실시간 인기회사</h2>
        <div class="a-inner">
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          <p class="rank">
            <em>1</em>
            <a href="#">LG화학</a>
          </p>
          
          <p class="dics"><i class="fas fa-exclamation-circle"></i>밤부에서 실시간으로 많이 검색된 회사 순위</p>

        </div>
      </aside>
    </section>


  
    <section id="container3">
    <div class="wrapping">
    
     <div class="img-wrap">
<img src="http://localhost:8080/khblind/img/bam.jpg" alt="background-img" class="bg">
      </div>
 

      <div class="article" id="a1">
            <h3 id="qq">
              <a href="#">
            <i class="far fa-comments"></i>블라블라</a>
            </h3>  

            <hr>

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
          <h3>
          <a href="#">
            <i class="fas fa-chart-line"></i>주식</a>
          </h3>  

          <hr>

          <div class="arti2">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 주식 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  
      
          <div class="arti2">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 주식 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti2">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 주식 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti2">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 주식 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti2">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 주식 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  
      </div>
      
      <div class="article" id="a3">
          <h3>
          <a href="#">
            <i class="fab fa-bitcoin"></i>암호화폐</a>
          </h3>

          <hr>

          <div class="arti3">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 코인 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti3">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 코인 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti3">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 코인 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti3">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 코인 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti3">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 코인 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  
      </div>   

      <div class="article" id="a4">
          <h3>
            <a href="#">
            <i class="fab fa-gratipay"></i>썸·연애</a>
          </h3>

          <hr>

          <div class="arti4">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 썸연애 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
          <div class="arti4">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 썸연애 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
          <div class="arti4">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 썸연애 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
          <div class="arti4">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 썸연애 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
          <div class="arti4">  
            <div class="m1">
              <span class="article-description">
              <a href="#">우와 썸연애 조아요</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div> 
      </div> 
      <div class="article" id="a5">
          <h3>
          <a href="#">
            <i class="fas fa-briefcase"></i>이직·커리어</a>
          </h3>  

          <hr>

          <div class="arti5">  
            <div class="m1">
              <span class="article-description">
              <a href="#">이직할꺼야</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  
      
          <div class="arti5">  
            <div class="m1">
              <span class="article-description">
              <a href="#">빌드업 커리어!</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti5">  
            <div class="m1">
              <span class="article-description">
              <a href="#">빌드업 커리어!</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  
          <div class="arti5">  
            <div class="m1">
              <span class="article-description">
              <a href="#">빌드업 커리어!</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  

          <div class="arti5">  
            <div class="m1">
              <span class="article-description">
              <a href="#">빌드업 커리어!</a>
              </span>
            </div>  
            <div class="m2">
                <i class="fas fa-mouse"></i><span>1</span>     
            </div> 
          </div>  
      </div>

      <div class="article" id="a6">
        <h3>
        <a href="#">
          <i class="fas fa-route"></i>여행·먹방</a>
        </h3>  

        <hr>

        <div class="arti6">  
          <div class="m1">
            <span class="article-description">
            <a href="#">우와 여행 조아요</a>
            </span>
          </div>  
          <div class="m2">
              <i class="fas fa-mouse"></i><span>1</span>     
          </div> 
        </div>  
    
        <div class="arti6">  
          <div class="m1">
            <span class="article-description">
            <a href="#">우와 먹방 조아요</a>
            </span>
          </div>  
          <div class="m2">
              <i class="fas fa-mouse"></i><span>1</span>     
          </div> 
        </div>  

        <div class="arti6">  
          <div class="m1">
            <span class="article-description">
            <a href="#">우와 먹방 조아요</a>
            </span>
          </div>  
          <div class="m2">
              <i class="fas fa-mouse"></i><span>1</span>     
          </div> 
        </div>  

        <div class="arti6">  
          <div class="m1">
            <span class="article-description">
            <a href="#">우와 먹방 조아요</a>
            </span>
          </div>  
          <div class="m2">
              <i class="fas fa-mouse"></i><span>1</span>     
          </div> 
        </div>  

        <div class="arti6">  
          <div class="m1">
            <span class="article-description">
            <a href="#">우와 먹방 조아요</a>
            </span>
          </div>  
          <div class="m2">
              <i class="fas fa-mouse"></i><span>1</span>     
          </div> 
        </div>  
    </div>
  </div>
  
  </section>
  
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>