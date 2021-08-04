<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <hr>
<style>
.footer-menu{
background-color: transparent;
}


</style>
      <section id="footer">
        <div class="footer-content">
          <ul class="footer-menu">
            <li class="f-li">서비스소개</li>
            <li class="f-li">이용약관</li>
            <li class="f-li">디렉토리</li>
            <li class="f-li">개인정보 처리방침</li>
            <li class="f-li">기업서비스</li>
          </ul>
        </div>
        
        <h5>KH Academy취업반 수업자료 &copy;</h5>
    
        <div class="app-box">
          <div class="abox1">
            <a href="https://www.apple.com/kr" target='_blank'><i class="fab fa-apple"></i>APP STORE</a>
          </div>
          <div class="abox2">
              <a href="https://play.google.com/" target='_blank'><i class="fab fa-google-play"></i>GOOGLE PLAY</a>
          </div>
        </div>
      </section>
</div>

<!--  -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
   
 <script>
$(document).ready(function() {
	var floatPosition = parseInt($(".FT").css('top'));

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";


		$(".FT").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();

});
</script>
 
  <script>
const arrow = document.querySelector('.arrows');

function scroll(selector){
   const scrollTo = document.querySelector(selector);
   scrollTo.scrollIntoView({ behavior: 'smooth' });
}

arrow.addEventListener('click', () => {
   scroll('#header');
});
</script>
</body>
</html>