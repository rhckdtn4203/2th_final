
function validate() {
        //event.preventDefault();
        var objID = document.getElementById("memberId");
        var objPwd1 = document.getElementById("memberPw");
        var objPwd2 = document.getElementById("reMemberPw");
        var objEmail = document.getElementById("memberEmail");
        var objName = document.getElementById("memberName");
        var objNum1 = document.getElementById("my_num1");
        var objNum2 = document.getElementById("my_num2");
 
        var arrNum1 = new Array();
        var arrNum2 = new Array();
 
    
 
        //아이디와 패스워드 값 데이터 정규화 공식
        var regul0 = /^[a-zA-Z0-9#?!@$ %^&*-]{8,20}$/;
        var regul1 = /^[a-zA-Z0-9]{8,20}$/;
        //이메일 값 데이터 유효성 체크
        //[]안에 있는 값만 쓰겠다
 
        //이메일 정규화 공식
        var regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
        //이름 정규화 공식
        var regul3 = /^[가-힝a-zA-Z]{2,}$/;
        //var email = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
 
        //아이디 입력 하지 않았을 경우
        if ((objID.value) == ""){
            alert("아이디를 입력하지 않았습니다.");
            objID.focus();
            return false;
        }
        //아이디 유효성 검사
        //내가 입력한 데이터를 검사하는 check()
        //만약 내가 아이디에 정규화 방식을 하나라도 지키지 않으면 if문 안으로 들어가서 alert message를 띄움
        if (!check(regul1,objID,"8~20자 영문, 숫자")) {
            return false;//반환 할 곳 없이 if문 탈출
        }
        //비밀번호 입력 하지 않았을 경우
        if ((objPwd1.value) == ""){
            alert("비밀번호를 입력해 주세요");
            objPwd1.focus();
            return false;
        }
        if ((objPwd2.value=="")){
            alert("비밀번호를 입력해 주세요");
            objPwd2.focus();
            return false;
        }
 
        //비밀번호 유효성 검사
        //만약 내가 비밀번호에 정규화 방식을 하나라도 지키지 않으면 if문 안으로 들어가서 alert message를 띄움
        if (!check(regul0,objPwd1,"8~20자의 영문, 숫자, #?!@$ %^&*-")) {
            return false;
        }
        
        //비밀번호와 비밀번호 확인이 일치 하지 않을 경우
        if ((objPwd1.value)!=(objPwd2.value)) {
            alert("비밀번호가 일치 하지 않습니다.");
            objPwd1.focus();
            objPwd2.focus();
            return false;
        }
        //이메일 입력 안했을 경우
        if ((objEmail.value)=="") {
            alert("이메일을 입력해 주세요");
            objEmail.focus();
            return false;
        }
        //이메일이 잘못된 경우
        if (!check(regul2,objEmail,"이메일을 잘못 입력 했습니다.")) {
            return false;
        }
        //이름 입력 안 한 경우
        if ((objName.value)=="") {
            alert("이름을 입력해 주세요");
            objName.focus();
            return false;
        }
        //이름에 특수 문자가 들어간 경우
        if (!check(regul3,objName,"이름이 잘못 되었습니다.")) {
        	return false;
        }
	}