<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style5.css">

<div class="findwrap">
  
    <div class="sections">
      <div class="section active" data-bgcolor="#C0D85D">
        <div class="inputFind">
          <div class="findTitle">
            <h2>SEARCH FOR ID
            </h2>
          </div>
          
          <form method="post" class="form-find" action="${pageContext.request.contextPath}/member/find_id" name="findform">
            <div class="row-left">
              <label for="name">이름</label>
              <input type="text" id="name" name="memberName" class="form-input"/>
            </div>
            
            <div class="row-left">
              <label for="phone">전화번호</label>
              <input type="text" id="phone" name="memberPhone" class="form-input"/>
            </div>
        
            <div class="row-left">
              <input class="login-btn"
                type="submit" value="click!">
            </div>
          </form>

        </div>
      <div id="findicon">
      <i class="fas fa-chevron-circle-down">password</i>
      </div>
      </div>
      
      
      <div class="section" data-bgcolor="#7ED4A8">
        <div class="inputFind">
          <div class="findTitle">
            <h2>SEARCH FOR PW</h2>
          </div>
        
          <form method="post" class="form-find" action="${pageContext.request.contextPath}/member/find_pw">
            <div class="row-left">
              <label for="memberId">ID</label>
              <input type="text" id="memberId" name="memberId" class="form-input"/>
            </div>
            
            <div class="row-left">
              <label for="memberEmail">E-mail</label>
              <input type="text" id="memberEmail" name="memberEmail" class="form-input"/>
            </div>
        
            <div class="row-left">
              <input class="login-btn"
                type="submit" value="인증번호 받기">
            </div>
          </form>
        
        </div>
      </div>
    </div>
</div>

<script>
// Get all of the images that are marked up to fade in
const images = document.querySelectorAll('.js-lazyload-image');

const sections = document.querySelectorAll('.section');

let config = {
  rootMargin: '0px',
  threshold: 0
};

let observer = new IntersectionObserver((entries) => {
    console.log(entries);
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      intersectionHandler(entry);
    } 

  });
}, config);

sections.forEach(section => {
  observer.observe(section);
});

function intersectionHandler(entry) {
  const current = document.querySelector('.section.active');
  const next = entry.target;
  const header = next.querySelector(".section--header");

  if (current) {
    current.classList.remove('active');
  }
  if (next) {
    next.classList.add('active');
    document.body.style.setProperty("--color-bg", next.dataset.bgcolor);
  }
}

images.forEach(image => {
  observer.observe(image);
});

function preloadImage(img) {
  const src = img.getAttribute('data-src');
  if (!src) { return; }
  img.src = src;
}
</script>	
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>