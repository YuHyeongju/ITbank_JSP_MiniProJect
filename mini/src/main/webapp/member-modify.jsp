<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H&H</title>
<style>
body {
	overflow-y: hidden;
}

#bg {
	position: absolute;
	width: 100%;
	height: 100%;
	background-image: url('${cpath}/image/amsal.jpeg');
	background-repeat: no-repeat;
	background-size: 100%;
	opacity: 0.4;
	z-index: -1;
}


main {
	position: absolute;
	width: 100%;
	height: 100%;
	top: 60px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.modifyForm{
	border-radius: 40px;
	width: 600px;
	height:400px;
	color: white;
	background-color: rgba(0, 0, 0, 0.90);
	box-shadow: 4px 4px 4px 4px black;
	box-sizing: border-box;
}

.modifyForm_inner {
	flex-flow: column;
}

.modify_info {
	padding-top: 10px;
	
}

.inputStyle {
	all: unset;
	padding: 10px 20px;
	border-radius: 10px;
	border: 1px solid red;
	background-color: rgba(0, 0, 0, 0.3);
}

.modifyItem {
	position: absolute;
	top: 50%;
	left: 40%;
	color: white;
	font-size: 16px;
	font-weight: bold;
	z-index: 1;
}

.modifyItem > p {
	margin-bottom: 25px;
}

input[type="file"] {
	transform: translate(12px, 10px);
	margin-top: 10px;
	margin-left: 5px;
	background-color: grey;
	border-radius: 5px;
}

input[type="submit"] {
    all: unset;
    transform: translate(0, 15px);
    font-size: 13px;
    font-weight: bold;
}

input[type="submit"]:hover {
	cursor: pointer;
	color: lightgrey;
}

</style>
</head>
<body>
	<section id="bg">
	
	</section>
	
	<div class="modifyItem">
		<p>패스워드</p>
		<p>닉네임</p>
		<p>이메일</p>
		<p>프로필사진</p>
	</div>
	
	<main>

	
		<c:if test="${pageContext.request.method =='GET' }">
				<form method="POST" enctype="multipart/form-data" class="modifyForm flex center">
					<div class="modifyForm_inner flex center">
						<h2 class="modify_info">정보 수정</h2>
						<input type="hidden" name="userid" value="${login.userid }">
						<input type="hidden" name="gender" value="${login.gender }">
						<div>
							<input class="inputStyle" type="password" name="userpw" placeholder="수정할 PW 입력" value="${login.userpw }">
						</div>

						<div>
							<input class="inputStyle" type="text" name="nickname" placeholder="수정할 닉네임 입력" value="${login.nickname }">
						</div>
							
						<div>
							<input class="inputStyle" type="email" name="email" placeholder="수정할 이메일 입력" value="${login.email }">
						</div>
	
						<div>
							<input type="file" name="uploadFile">
						</div>
					
						<div>						
							<input type="submit" value="수정하기">
						</div>
					
					</div>
				</form>

		</c:if>
		<c:if test="${pageContext.request.method =='POST' }">
			<c:set var="memberfileUtil" value="${MemberFileUtil.getInstance() }"/>
			<c:set var="dto" value="${memberfileUtil.getDTO(pageContext.request) }" />
			<c:set var="row" value="${memberDAO.modify(dto) }" />
			<c:if test="${row != 0 }">
				<script>
					alert('수정 완료. 다시 로그인 해주세요')
					location.href = '${cpath}/logout.jsp'
				</script>
			</c:if>
			<c:if test="${row == 0 }">
				<script>
					alert('수정실패')
					history.back()
				</script>
			</c:if>

		</c:if>


	</main>
</body>
</html>