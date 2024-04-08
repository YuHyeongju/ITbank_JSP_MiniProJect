<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H&H</title>
<style>
#bg {
	width: 100%;
	height: 900px;
	position: absolute;
	top: 60px;
	background-image: url('${cpath}/image/batman.jpg');
	background-repeat: no-repeat;
	background-size: 100%;
	opacity: 0.3;
}

h3 {
	color: white;
}

main {
	width: 100%;
	height: 100%;
	position: absolute;
	display: flex;
	justify-content: center;
	align-items: center;
}

.loginForm {
	width: 300px;
	padding: 10px;
	margin-top: 50px;
}


#loginInput {
	border: 1px solid black;
	border-radius: 10px;
}

p {
	margin: 0;
	padding: 0;
}

.input {
	all: unset;
	width: 300px;
	height: 44px;
	background-color: white;
	box-sizing: border-box;
	padding: 0 10px;
	border: 0;
}

.input:focus {
	color: black;
}

input[name="userid"] {
	border-radius: 10px 10px 0 0;
}

input[name="userpw"] {
	border-radius: 0 0 10px 10px;
}

input[type="submit"] {
	all: unset;
	margin-top: 15px;
	width: 300px;
	height: 48px;
	background-color: #F82F62;
	font-size: 15px;
	font-weight: 700;
	text-align: center;
	border-radius: 20px;
	color: white;
	opacity: 0.7;
}

input[type="submit"]:hover {
	cursor: pointer;
}

#join {
	margin-top: 10px;
	font-size: 13px;
	font-weight: bold;
}

hr {
	height: 1px;
	border: 0;
	background: grey;
}

label {
	color: white;
	font-size: 14px;
	font-weight: bold;
}
</style>
</head>
<body>
	<%
		Cookie[] cookies = request.getCookies();
	
		for(Cookie ck : cookies) {
			if(ck.getName().equals("userid")) {
				request.setAttribute("userid", ck.getValue());
			}
			if(ck.getName().equals("userpw")) {
				request.setAttribute("userpw", ck.getValue());
			}
		}
	%>

	<section id="bg">
	
	</section>

	<main>
		<div class="main_inner flex">
			<c:if test="${pageContext.request.method=='GET' }">
				<form method="POST" class="loginForm flex">
					<div class="loginForm_inner">
						<h3>로그인</h3>
						<div id="loginInput">
							<p>
								<input class="input" type="text" name="userid" placeholder="아이디" value="${userid }">
							</p>
							<p>							
								<input class="input" type="password" name="userpw" placeholder="비밀번호" value="${userpw }">
							</p>
						</div>
						<p align="right"><label><input type="checkbox" name="save" value="1"> 로그인 정보 저장</label></p>
						<p>
							<input type="submit" value="로그인">
						</p> 
						<hr>
						<p id="join" style="color: white;">
							아직 회원이 아니세요? 가입하려면 <a href="${cpath }/join.jsp" style="color: grey;">여기</a>를 클릭
						</p>
					</div>
				</form>
			</c:if>
			<c:if test="${pageContext.request.method == 'POST' }">
				<%
					String userid = request.getParameter("userid");
					String userpw = request.getParameter("userpw");
					
					String save = request.getParameter("save");
					
					Cookie saveId = null;
					Cookie savePw = null;
					
					
					if(save != null) {
						saveId = new Cookie("userid", userid);
						saveId.setMaxAge(24 * 60 * 60);
						
						savePw = new Cookie("userpw", userpw);
						savePw.setMaxAge(24 * 60 * 60);
						
						response.addCookie(saveId);
						response.addCookie(savePw);
					}
					
					
				%>
				<jsp:useBean id="dto" class="member.MemberDTO" />
				<jsp:setProperty property="*" name="dto" />
				<c:set var="login" value="${memberDAO.login(dto) }" scope="session" />
				<c:if test="${empty login }">
					<script>
						alert('회원이 아니시거나 ID/PW가 틀렸습니다')
						history.go(-1)
					</script>
				</c:if>
				<c:if test="${!empty login }">
					<script>
						location.href = '${cpath}/index.jsp'
					</script>
				</c:if>
				

			</c:if>
		</div>
	</main>
</body>
</html>