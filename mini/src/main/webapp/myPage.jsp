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
	color: white !important;
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
	top: 60px;
	width: 100%;
	height: 100%;
}

.myPage {
	border-radius: 40px;
	width: 1000px;
	height: 800px;
	margin: 0 auto;
	color: white;
	background-color: rgba(0, 0, 0, 0.90);
	box-shadow: 4px 4px 4px 4px black;
	box-sizing: border-box;
	padding: 0 10px;
}

.login_info {
	color: white;
	text-align: center;
}

.myPage_inner>div {
	width: 49%;
}

.profile_img>img {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	padding: 10px;
	margin-left: 50px;
}


table {
	border-collapse: collapse;
}

tr, th {
	border: 1px solid gray;
	padding: 10px;
}

th {
	background-color: #dadada;
}

#writeName {
	width: 300px;
}

#writeDate {
	width: 200px;
}

th {
	width: 100px;
}



.reviewArea {
	overflow: hidden;
	position: relative;
	border: 2px solid white;
	width: 500px;
	height: 260px;
	margin-left: 20px;
}


.replyArea {
	position: relative;
	border: 2px solid white;
	width: 500px;
	height: 258px;
	margin-left: 20px;
	margin-bottom: 10px;
}
.link_btn a {
	font-size: 13px;
	font-weight: bold;
}
.link_Btn_inner{
	width: 100%;
}
.link_Btn_inner > div{
	flex: 1;
	box-sizing: border-box;
	padding-left: 35px;
}

p {
	margin: 0;
}

h3 {
	margin: 0;
	box-sizing: border-box;
	padding: 0 20px;
}

.likeMovie {
	display: flex;
	flex-wrap: wrap;
	box-sizing: border-box;
	border: 2px solid white;
	width: 400px;
	height: 550px;
	margin-left: 20px;
	margin-bottom: 10px;
}

#poster {
	width: 130px;
	height: 150px;
}

#likeItem {
	box-sizing: border-box;
	width: 33%;
	margin-left: 1px;
	height: 165px;
}
#title {
	font-size: 13px;
	font-weight: bold;
}
.modify > div {
	width: fit-content;
}
.modify > div:nth-child(1) {
	margin-right: 10px;
}

.modal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0 0 2px 2px black;
}

.modal_overlay {
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	position: absolute;
}

.modal_content {
	background-color: rgba(128, 128, 128, 0.7);
	padding: 50px 100px;
	text-align: center;
	position: relative;
	border-radius: 10px;
	width: 30%;
	box-shadow: 0 0 2px 2px black;
}


.hidden {
	display: none;
}

#withdraw {
	all:unset;
    background-color: red;
    color: white;
    padding: 0 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bolder;
    font-size: 16pt;
    margin-left: 10px;
}

#closeBtn {
    all: unset;
    transform: translate(375px, -180px);
    color: red;
    font-weight: bold;
}

#closeBtn:hover {
	cursor: pointer;
	color: orange;
}

h2 {
	color: black;
}

input[type="password"] {
	padding: 5px 20px;
	border: 2px solid grey;
	border-radius: 5px;
	margin-left: 10px;
}


#reviewContent {
	border: 1px solid white;
	border-radius: 5px;
	width: 100px;
	font-size: 13px;
	display: -webkit-box;
	-webkit-line-clamp: 14;
	-webkit-box-orient: vertical;
	text-overflow: ellipsis;
	overflow: hidden;
	font-weight: bold;
}

#reviewItem {
	display: flex;
    flex-flow: column;
}

.myBoard {
	font-size: 13px;
	font-weight: bold;
	bottom: 5px;
	right: 5px;
	position: absolute;
}

#replyContent {
	border: 1px solid white;
    border-radius: 5px;
    width: 100px;
    font-size: 13px;
    display: -webkit-box;
    -webkit-line-clamp: 14;
    -webkit-box-orient: vertical;
    text-overflow: ellipsis;
    overflow: hidden;
    font-weight: bold;
}
</style>

</head>
<body>
	<section id="bg">
		
	</section>

	<main class="flex center">

		<div class="myPage frame">
			<h2 class="login_info">MY MOVIE</h2>
			<div class="myPage_inner flex sb">
				<div class="profile_img">
					<img src="${cpath }/image/${login.profile_img}" />
				</div>
				<div class="profile">
					<p>닉네임 ${login.nickname }</p>
					<p>이메일 ${login.email }</p>
					<p>성별 ${login.gender }</p>
				</div>
			</div>
			<section class="flex center">
				<div>
					<c:set var="list" value="${movieDAO.selectLikeMovies(login.userid) }"/>
					<h3 class="like_movie">LIKE MOVIE</h3>
					<div class="likeMovie flex">
						<c:forEach var="dto" items="${list }">
							<div id="likeItem">					
								<p>
									<a href="movie-detail.jsp?idx=${dto.idx }"><img id="poster" src="movie/${dto.movie_img}"></a>
								</p>
								<p id="title">${dto.name }</p>
							</div>
						</c:forEach>
					</div>
				</div>
				<div>	
					<div>
						<h3 class="review_info">MY REVIEW</h3>
						<div class="reviewArea flex wrap">
								<c:set var="myReviews" value="${reviewDAO.selectMyReviews(login.userid) }"/>
								<c:forEach var="review" items="${myReviews }">
									<div id="reviewItem">
									<a></a>							
										<h3 id="reviewTitle" style="font-size: 15px;">
											<a href="review-detail.jsp?idx=${review.idx }">${review.title }</a>
										</h3>
										<p id="reviewContent">${review.content }</p>
									</div>
								</c:forEach>
								<div class="myBoard">
									<a href="myBoard.jsp">내가 쓴 글 전체보기</a>
								</div>
						</div>
					</div>
					<div>
						<h3 class="reply_info">MY REPLY</h3>
						<div class="replyArea flex sa">
							<c:set var="myReplys" value="${replyDAO.selectReplyListALL(login.userid) }" />
							<c:forEach var="reply" items="${myReplys }">
								<div>							
									<p align="center">${reply.writer }</p>
									<p id="replyContent"><a href="review-detail.jsp?idx=${reply.board_idx }">${reply.content }</a></p>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</section>
			<div class="link_btn">
				<div class="link_Btn_inner flex sb">
					<div class="modify flex" style="justify-content: flex-end;">			
						<div>
							<a href="member-modify.jsp">정보 수정</a>
						</div>
						<div style="margin-right: 10px;">
							<a id="open">회원 탈퇴</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<div class="modal hidden">
		<div class="modal_overlay"></div>
	
		<div class="modal_content">
			<h2 style="color: white;">회원 탈퇴</h2>
			<p style="color: white; font-weight: bold;">탈퇴하시려면 아래 창에 비밀번호를 입력하세요</p>
			<form id="withdrawForm" method="POST" class="flex center" style="margin-top: 10px;">
				<input type="hidden" name="userid" value="${login.userid }">
				<input type="password" name="userpw" placeholder="PW입력" required>
				<button id="withdraw">탈퇴</button>
			</form>
			<button id="closeBtn">X</button>
		</div>
	</div>
	
	<c:if test="${pageContext.request.method == 'POST' }">
		<jsp:useBean id="dto" class="member.MemberDTO"/>
		<jsp:setProperty property="*" name="dto"/>
		
		<c:set var="row" value="${memberDAO.withdraw(dto) }"/>
		
		<c:if test="${row == 0 }">
			<script>
				alert('비밀번호를 확인해주세요')
				location.href = location.href
			</script>
		</c:if>
		
		<c:if test="${row != 0 }">
			<%
				session.invalidate();
			%>
			<script>
				alert('탈퇴되었습니다')
				location.href = 'index.jsp'
			</script>
		</c:if>
	</c:if>

<script>
	const withdrawForm = document.getElementById('withdrawForm')
	withdrawForm.onsubmit = function() {
		const flag = confirm('정말 탈퇴하시겠습니까?')
		if(flag) {
			return true
		}
		else {
			return false
		}
	}

	const openBtn = document.getElementById('open')
	const modal = document.querySelector('.modal')
	const overlay = modal.querySelector('.modal_overlay')
	const clostBtn = modal.querySelector('#closeBtn')
	
	const openModal = () => {
		modal.classList.remove('hidden')
	}
	const closeModal = () => {
		modal.classList.add('hidden')
	}
	
	overlay.onclick = closeModal
	clostBtn.onclick = closeModal
	openBtn.onclick = openModal
	

</script>
	
</body>
</html>

