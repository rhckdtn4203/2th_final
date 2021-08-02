//
//function checkId(){
//	  const input = document.querySelector('.form-control');
//	  const span = document.querySelector('.form-control+span');
//
//	  if(input.value.length>=8 && input.value.length <=20) {
//	    span.textContent="올바른 형식입니다";
//	  }
//	  else{
//	    spam.textContent="잘못 입력된 형식입니다"
//	  }
//}
//
//function formCheck(){
//	 const idRegex = /^[a-zA-Z0-9]{8,20}$/;
//	 const idinput = document.querySelector('#inputId');
//	 if(!idRegex.test(idinput.value)){
//	   var idspan = idinput.nextElementSibling;
//	   idspan.textContent = "아이디는 8~20자 이내 영문, 숫자"
//
//	   return false;
//	 }
//	 
//	 const pwRegex = /^[a-zA-Z0-9#?!@$ %^&*-]{8,20}$/;
//	 const pwinput = document.querySelector('#inputPw');
//	 if(!pwRegex.test(pwinput.value)){
//		 var pwspan = pwinput.nextElementSibling;
//		 pwspan.textContent = "비밀번호는 8~20자 이내 영문, 숫자, 특수기호"
//	 }
//

//회원탈퇴
		$(function(){
			$("#confirmLink").click(function(e){
				
				//var message=$(this).attr("data-message")||"이동하시겠습니까?";
				var choice = window.confirm("정말 탈퇴하시겠습니까?");
				if(!choice){
				e.preventDefault();				
				}
			});
		}); 
	 
	

