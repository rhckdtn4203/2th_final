<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    		</section>
		<footer>
			<h5>KHAcademy 취업반 수업자료 &copy;</h5>
			<hr>
			세션 ID : ${pageContext.session.id},
			로그인한 회원 ID: ${dtoss.getMemberId()}, 
			로그인 : ${not empty dtoss}
		</footer>
	</main>
</body>
</html>

    