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
	opacity: 0.5;
}

main {
	position: absolute;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}


#check {
	all: unset;
	display: flex;
	height: 50px;
	justify-content: center;
	box-sizing: border-box;
}

p {
	width: fit-content;
	margin: 0;
	color: white;
}

.joinForm {
	margin-top: 25px;
}

.input {
	all: unset;
    background: rgb(25, 26, 28);
    color: rgb(255, 255, 255);
    font-size: 14px;
    font-weight: 400;
    letter-spacing: 0px;
    text-decoration: none;
    line-height: 20px;
    width: 300px;
    padding: 13px 11px;
    border: 1px solid rgb(231, 62, 62);
    border-radius: 4px;
    caret-color: rgb(248, 47, 98);
    appearance: none;
}

input[name="userid"] {
	width: 300px;
}

h2 {
	color: rgb(255, 255, 255);
    text-align: center;
    margin: 0px 0px 16px;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 0px;
    line-height: 26px;
}
input[value="중복확인"] {
	all:unset;
	text-align: center;
	color: white;
	font-size: 13px;
	font-weight: bold;
	padding: 2px 5px;
	background-color: rgba(0, 0, 0, 0.95);
	border: 2px solid red;
	border-radius: 4px;
	width: 100px;
}
input[value="가입하기"] {
	margin-top: 10px;
	background: rgb(80, 81, 85);
    color: rgb(153, 156, 161);
    width: 300px;
    box-sizing: content-box;
    padding: 0 12px;
    height: 40px;
    border: 0;
    border-radius: 5px;
}
input[type="submit"]:hover {
	cursor: pointer;
}
input[value="가입하기"]:hover {
	transition-duration: 0.5s;
	background-color: #434343;
	border: 2px solid #darkgrey;
}
#gender {
	background: rgb(25, 26, 28);
	border: 1px solid rgb(231, 62, 62);
	padding: 4px 11px;
	width: 300px;
    border-radius: 4px;
}
#lime,
#red {
	font-size: 13px;
	font-weight: bold;
}
#lime {
	color: lime;
}
#red {
	color: red;
}

.hidden {
	display: none;
}

#notEqualPw {
	font-size: 13px;
	font-weight: bold;
	color: red;
}
#EqualPw {
	font-size: 13px;
	font-weight: bold;
	color: lime;
}

</style>
</head>
<body>
	<section id="bg">
	
	</section>

	<main>
		<c:if test="${pageContext.request.method == 'GET' }">
				<div class="joinForm_inner flex center">
					<div class="joinForm_inner_inner">
						<h2>회원가입</h2>
						<form method="POST" action="check.jsp" id="check">
							<div>	
								<p>
									<input type="text" name="userid" placeholder="ID" value="${param.userid }" class="input" autofocus> 
								</p>
								<p>
									<input type="submit" value="중복확인"> <span id="${!empty param.result && param.result == 0 ? 'lime' : 'red' }"> ${!empty param.result && param.result == 0 ? '사용 가능한 아이디입니다' : ''}
									 ${!empty param.result && param.result == 1? '중복된 아이디입니다' : ''} </span>
								</p>
							</div>
						</form>

						<form method="POST" class="joinForm">

							<input type="hidden" name="userid" value="${param.userid} ">

							<p>
								<input id="pass" class="input" type="password" name="userpw" placeholder="PW" required>  
							</p>
							<p>
								<input id="pwcheck" name="pwcheck" class="input" type="password" placeholder="PW확인" required>  
							</p>
							<p class="hidden" id="notEqualPw">
								비밀번호가 일치하지 않습니다.
							</p>
							<p class="hidden" id="EqualPw">
								비밀번호가 일치합니다.
							</p>
							<p>
								<input class="input" type="text" name="nickname" placeholder="NICKNAME" required>
							</p>
							<p id="gender">
								성별
								<label><input type="radio" name="gender" value="남성" required>남성</label>
								<label><input type="radio" name="gender" value="여성" required>여성</label>
							</p>
							<p>
								<input class="input" type="email" name="email" placeholder="example@naver.com" required>
							</p>
							<p>
								<input id="submitBtn" type="submit" value="가입하기" ${empty param.result or param.result == 1 ? 'disabled' : '' }>
							</p>
						</form>
					</div>
				</div>
		</c:if>
		<c:if test="${pageContext.request.method =='POST' }">
			<jsp:useBean id="dto" class="member.MemberDTO" />
			<jsp:setProperty property="*" name="dto" />
			<c:set var="row" value="${memberDAO.insert(dto) }" />
			<c:if test="${ row == 0 }">
				<script>
					alert('회원가입 실패')
					history.back()
				</script>
			</c:if>
			<c:if test="${ row != 0  }">
				<script>
					alert('회원가입 성공')
					location.href = 'login.jsp'
				</script>
			</c:if>


		</c:if>
	</main>
	
	<script>

		
		// 패스워드 재입력 창
		const pwCheck = document.getElementById('pwcheck')
		
		// 패스워드 불일치 시 화면에 표시할 내용
		const notEqualPw = document.getElementById('notEqualPw')
		
		// 패스워드 일치 시 화면에 표시할 내용
		const EqualPw = document.getElementById('EqualPw')
		
		// 패스워드 입력창
		const pwInput = document.getElementById('pass')
		
		// 패스워드 재입력 창에 키보드 입력이 될 때마다 발생하는 이벤트
		const pwChecker = function(event) {
			const pw1 = document.querySelector('input[name="userpw"]')
			const pw2 = document.querySelector('input[name="pwcheck"]')
			
			if(pw1.value != pw2.value) {
				notEqualPw.classList.remove('hidden')
				EqualPw.classList.add('hidden')
			}
			else {
				notEqualPw.classList.add('hidden')
				EqualPw.classList.remove('hidden')
			}
		}
			
		pwCheck.onkeyup = pwChecker
		pwInput.onkeyup = pwChecker
		
		


		// 회원가입 폼
		const joinForm = document.querySelector('.joinForm')
		
		joinForm.onsubmit = function() {
			const pw1 = document.querySelector('input[name="userpw"]')
			const pw2 = document.querySelector('input[name="pwcheck"]')
			if(pw1.value != pw2.value) {
				alert('비밀번호 재확인이 완료되지 않았습니다!')
				return false
			}
			else {
				return true
			}
		}
		
	</script>
</body>
</html>
