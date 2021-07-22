<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 <style>
        th{
            display:table-cell;
            vertical-align:inherit;
            font-weight:bold;
            text-align:center;
            border:1px solid black;
        }
        table{
            border:1px solid black;
            text-align : center;
        }
        td{
            border:1px solid black;
        }
    </style>
    
  <script>
  		$(function(){
  			$("#send").click(function(e){
  				var grade = ${dtoss.gradeNo};
  				if(grade==2 || grade ==4){
  					window.alert("이미 플러스 회원입니다.");
  					e.preventDefault();	
  				}
  			});
  		});
  
  </script>  
<body>

<div class="container-900">
	<div class="row text-center">
		<h1>회원 플러스 소개</h1>
	</div>

	<div class="row text-center">
	<table class="table table-border">
            <tr>
                <th>등급 번호</th>
                <th>등급명</th>
                <th>등급별 혜택</th>
            </tr>
            <tr>
                <td>1</td>
                <td>준회원</td>
                <td>자신의 업종 커뮤니티 입장 가능</td>
            </tr>
            <tr>
                <td>2</td>
                <td>준회원 +</td>
                <td>자신의 업종 + 모든 업종의 커뮤니티 이용권</td>
            </tr>
            <tr>
                <td>3</td>
                <td>정회원</td>
                <td>자신의 기업 커뮤니티 이용권, 자신의 업종 커뮤니티 이용권</td>
            </tr>
            <tr>
                <td>4</td>
                <td>정회원 + </td>
                <td>자신의 기업 커뮤니티 이용권, 자신의 업종 + 모든 업종의 커뮤니티 이용권</td>
            </tr>
         </table>
	</div>
</div>
<div class="row text-center">
<a href="history" class="link-btn">지난 결제내역 보기</a>
</div>      
       
<div class="row text-center">
<h1 class=>회원 플러스 결제</h1>
<!-- <h4>준회원, 정회원만 결제 후 + 등급이 되실 수 있습니다.</h4> -->
<h4> 현재 ${dtoss.memberNick}님은 ${dtoss.gradeNo} 등급 입니다.</h4>
</div>

<form action="upgrade" method="post">
	<div class="row text-center">
		<label> 회원 플러스 </label> <!-- 상품의 이름 -->
	</div>
		<input type="hidden" name="item_name" value="회원 플러스">
	<div class="row text-center">
		<label>주문 수량</label><!-- 주문 수량  -->
		<input type="number" name="quantity" value="0" max="1" min="0" required>
	</div>
		<input type="hidden" name="total_amount" value="5000">
	<div class="row text-center">
			<input type="submit" value="결제" class="form-btn form-btn-positive" id="send">
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>