<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<body>
<h1>회원 플러스 소개</h1>
<table>
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
                <td>자신의 업종 뿐만 아니라 모든 업종의 커뮤니티 이용권</td>
            </tr>
            <tr>
                <td>3</td>
                <td>정회원</td>
                <td>자신의 기업 커뮤니티 이용권, 자신의 업종 커뮤니티 이용권</td>
            </tr>
            <tr>
                <td>4</td>
                <td>정회원 + </td>
                <td>자신의 기업 커뮤니티 이용권, 자신의 업종 뿐만 아니라 모든 업종의 커뮤니티 이용권</td>
            </tr>
         </table>
         
         <br><br>
         <hr>
         <form action="upgrade" method="post">
         	<input type="hidden" name="memberNo" value="${memberDto.no}">
         	<input type="number" name="quantity" value="0" max="1" required>
         	<input type="submit" value="결제하기">
         </form>
</body>         
         
         
