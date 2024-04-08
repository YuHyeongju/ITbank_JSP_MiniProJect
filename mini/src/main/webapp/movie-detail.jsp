<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<c:set var="movie" value="${movieDAO.selectOne(param.idx) }" />
<style>
	#bg {
		position: absolute;
		width: 100%;
		height: 100%;
		opacity: 0.7;
	}
	#bg > iframe {
		width: 100%;
		height: 900px;
	}
	.content {
		width: 100%;
		height: 100%;
		position: absolute;
		z-index: 1;
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	}
	.movie {
		border-radius: 40px;
		width: 1000px;
		height: 540px;
		margin: 0 auto;
		color: white;
		background-color: rgba(0, 0, 0, 0.90);
		box-shadow: 4px 4px 4px 4px black;
		box-sizing: border-box;
		padding: 0 10px;
	}
	.left {
		box-sizing: border-box;
		padding: 45px 20px;
	}
	.right {
		position: relative;
	}
	img {
		width: 280px;
		height: 330px;
	}
	.movie > div:first-child {
		width: 35%;
	}
	.movie > div:nth-child(2) {
		width: 65%;
	}
	.back {
		position: absolute;
		top: 85%;
		left: 85%;
	}
	#backBtn {
		all: unset;
		padding: 10px 5px;
		border-radius: 20px;
		border: 3px solid #df243b;
		background-color: red;
		color: white;
		box-shadow: 1px 1px 1px 1px black;
	}
	#backBtn:hover {
		transition-duration: 0.5s;
		background-color: #ec5353;
	}
	#like {
		margin-top: 10px;
		font-size: 20px;
		font-weight: bold;
	}
	.review {
		position: absolute;
		top: 87%;
		font-size: 22px;
		font-weight: bold;
	}
	.info {
		font-size: 13px;
		margin-top: 5px;
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
	z-index: 2;
	}

	.modal_overlay {
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.4);
		position: absolute;
	}
	
	.modal_content {
		background-color: white;
		padding: 10px 20px;
		text-align: center;
		position: relative;
		border-radius: 10px;
		width: 15%;
		box-shadow: 0 0 2px 2px black;
	}
	
	.hidden {
	display: none;
	}
	
	.stars {
		width: 100%;
		font-size: 20px;
		font-weight: bold;
		color: black;
	}
	
	.star:hover {
		cursor: pointer;
	}
	
	.yellow {
		color: yellow;
	}
	
	.white {
		color: white;
	}
	
	.starScore {
	    display: flex;
    	justify-content: center;
   		align-items: center;
    	margin-left: 65px;
		transform: translate(43px, 0);
	}
	
	#star {
		transform: translate(-75px, 2px);
		opacity: 0;
	}
	
	#eval {
		margin-top: 10px;
	}
	
	#eval > button {
		border: 0;
	    border-radius: 12px;
	    background-color: yellow;
	    color: palevioletred;
	    font-size: 13px;
	    font-weight: bold;
	}
	
	#eval > button:hover {
		cursor: pointer;
		background-color: orange;
	}
</style>

<section id="bg">
	${movie.trailer }
</section>

<section class="content flex center">
	<div class="movie frame flex sb">
		<div class="left">
			<div><img src="movie/${movie.movie_img }"></div>
			<div class="flex sb likeStar">
				<div id="like">
					<c:set var="like" value="${movieDAO.isLike(login.userid, movie.idx) }"/>
					<a href="movie-like.jsp?userid=${login.userid}&idx=${movie.idx}" onclick="${empty login ? 'needlogin()' : ''}">${like == 0 ? '🤍' : '🧡' }</a>
					<span>${movieDAO.getLikeCount(movie.idx) }</span>
				</div>
				<div class="starScore">
					<c:set var="score" value="${starDAO.getStarScore(movie.idx) }"/>
					<span class="${score >= 1 ? 'yellow' : 'white'}">★</span>
					<span class="${score >= 2 ? 'yellow' : 'white'}">★</span>
					<span class="${score >= 3 ? 'yellow' : 'white'}">★</span>
					<span class="${score >= 4 ? 'yellow' : 'white'}">★</span>
					<span class="${score >= 5 ? 'yellow' : 'white'}">★</span>						
					<span style="margin-top:5px; margin-left: 2px;">${empty score ? '0' : '' }
					${score } / 5</span>
				</div>
				<div id="star" class="flex center">
					<a id="open">별점 주기</a>
				</div>
			</div>
			<div class="info">개봉 ${movie.release_date }</div>
			<div class="info">장르 ${movie.genre }</div>
			<div class="info">출연진 ${movie.casting }</div>
			<div class="info">상영시간 ${movie.playtime }분</div>
		</div>
		<div class="right">
			<div>
				<h1>${movie.name }</h1>
			</div>
			<h2>시놉시스</h2>
			<div>
				<p style="font-size: 14px;">${movie.content }</p>
			</div>
			<div class="back">	
					<a href="index.jsp"><button id="backBtn">메인으로</button></a>
			</div>
		</div>
	</div>
</section>

	<div class="modal hidden">
		<div class="modal_overlay"></div>
	
		<div class="modal_content">
			<h2>별점주기</h2>
			<div class="stars">
				<span class="star" value="1">★</span>
				<span class="star" value="2">★</span>
				<span class="star" value="3">★</span>
				<span class="star" value="4">★</span>
				<span class="star" value="5">★</span>			
			</div>
			<div id="eval">			
				<button id="evalBtn">평가하기</button>
				<button id="closeBtn">닫기</button>
			</div>
		</div>
	</div>
<script>
	function needlogin() {
		event.preventDefault()
		alert('좋아요 하시려면 로그인 상태여야 합니다.')
	}

	
	const openBtn = document.getElementById('open')
	const modal = document.querySelector('.modal')
	const overlay = modal.querySelector('.modal_overlay')
	const closeBtn = modal.querySelector('#closeBtn')
	
	const openModal = () => {
		modal.classList.remove('hidden')
	}
	const closeModal = () => {
		modal.classList.add('hidden')
	}
	
	overlay.onclick = closeModal
	
	openBtn.onclick = login_userid == '' ? wantlogin : openModal
	
		

	
	const stars = document.querySelectorAll('.star')
	var starCount = 0
	
	
	function initstar() {
		for(let i = 0; i < stars.length; i++) {
			stars[i].style.color = 'black'
		}
	}		
	closeBtn.addEventListener('click', closeModal)
	closeBtn.addEventListener('click', initstar)
	
	function clickStar(event) {
		starCount = event.target.getAttribute('value')
		for(let i = 0; i < starCount; i++) {
			stars[i].style.color = 'yellow'
		}
		for(let i = starCount; i < stars.length; i++) {
			stars[i].style.color = 'black'
		}
	}
	stars.forEach(e => e.onclick = clickStar)
	
	
	const evalBtn = document.getElementById('evalBtn')
	evalBtn.onclick = function() {
		location.href = 'star.jsp?movie_idx=${movie.idx}&userid=${login.userid}&score=' + starCount
	}
	
</script>
</body>
</html>