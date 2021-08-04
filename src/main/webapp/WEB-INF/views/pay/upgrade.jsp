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
            background-color: var(--color-green);
            color: wheat;
        }
        table,td{
            border:1px solid black;
        }
        table{
        	width: 70%;
        	height: 100px;
        	margin: auto;
        	text-align: center;
        } 
        .set{
			width:100%;
			margin-top: 10px;
			margin-bottom: 10px;    
        }
         .history-link:hover{
        	color: wheat;
        }
        .pay-btn{
        	 background-color: wheat;
             color: var(--color-green);
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

<div class="container-600">
	<div class="set" style="margin-right:48%;">
		<h1 style="font-weight:bolder">회원 플러스 소개</h1>
	</div>

	<div class="set">
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
   
	<div class="set" style="margin-right:48%;">
		<h1 style="font-weight:bolder">회원 플러스 결제</h1>	
	</div>   
	<div class="set text-left" style="margin-right:25%;">	
		<span style="font-size:20px;margin-top:1%;"> (현재 ${dtoss.memberNick}님은 ${dtoss.gradeNo} 등급 입니다.)</span>
		<a href="history" class="history-link" style="margin-left:1%;font-weight:bold;">지난 결제내역 보기</a>
	</div>

	<div class ="set">
		<form action="upgrade" method="post">
			<div class="set">
				<label> 회원 플러스 </label> <!-- 상품의 이름 -->
			</div>
				<input type="hidden" name="item_name" value="회원 플러스">
			<div class="set">	
				<label>주문 수량</label>
				<input type="number" name="quantity" value="0" max="1" min="0" required>
	
				<input type="hidden" name="total_amount" value="5000">
			
				<input type="submit" value="결제" class="pay-btn" id="send">
			</div>
		</form>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>