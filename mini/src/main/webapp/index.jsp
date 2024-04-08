<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<style>
	body {
		overflow-x: hidden;
	}
	main {
		position: absolute;
		width: 100%;
		top: 60px;
		color: white;
	}
	.trailer {
		width: 600px;
		margin: 20px auto;
	}
	.trailerInner {
		width: 70%;
	}
	.trailerItem {
		position: absolute;
		transition-duration: 1s;
		z-index: 1;
	}
	.leftbar {
		position: fixed;
		top: 80px;
		left: 0;
		width: 200px;
		height: 100%;
		text-align: center;
		color: white;
		z-index: 1;
	}
	.wrap {
		position: relative;
		display: flex;
	}
	p {
		padding: 0;
	}
	.leftbar > div {
		height: 16%;
	}
	.leftbar > div:first-child {
		margin-top: 60px;
	}
	.leftbar a {
		border: 2px solid lightgrey;
		border-radius: 20px;
		padding: 10px 15px;
		font-size: 13px;
	}
	.leftbar a:hover {
		transition-duration: 0.5s;
		background-color: darkgrey;
		color: black;
	}
	.arrow {
		position: absolute;
		width: 80px;
		height: 315px;
		z-index: 5;
	}
	.arrow > a {
		all: unset;
		width: 80px;
		height: 315px;
		box-sizing: border-box;
		padding: 130px 35px;
	}
	.arrow:hover {
		cursor: pointer;
		transition-duration: 0.5s;
		background-color: rgba(0, 0, 0, 0.4);
	}
	.movies {
		width: 80%;
		margin-top: 70px;
		margin-left: 300px;
	}
	.movieItem {
		width: 18%;
		position: relative;
	}
	.wrapper {
		flex-wrap: wrap;
	}
	#movieImg {
		width: 200px;
		height: 250px;
		border-radius: 10px;
		box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	.movieItem > div {
		transition-duration: 0.5s;
	}
	.movieItem  a:hover > #movieImg {
		cursor: pointer;
		opacity: 0.5;
		transition-duration: 0.5s;
		box-shadow: 0px 0px 5px 5px lightskyblue;
		border: 1px solid skyblue;
	}
	.movieItem a:hover + .synopsys {
		opacity: 1;
	}
	iframe {
		border-radius: 15px;
 		box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	#bottom {
		opacity: 0;
	}
	#leftArrow {
		top: 20px;
		left: 36%;
	}
	#rightArrow {
		top: 20px;
		right: 29%;
	}
	.hidden {
		opacity: 0;
	}
	#drop {
		position: fixed;
		top:0;
		width: 100%;
		height: 200px;
		background-color: white;
		color: black;
		z-index: 2;
	}
	#topArrow {
		transition-duration: 0.5s;
		position: fixed;
		background-color: rgba(128, 128, 128, 0.4);
		box-shadow: 2px 2px 2px 2px black;
		width: 50px;
		height: 50px;
		border-radius: 50%;
		font-size: 30px;
		font-weight: bold;
		bottom: 30px;
		right: 35px;
		color: white;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: -5;
	}
	#topArrow:hover {
		cursor: pointer;
	}
</style>

<div class="hidden" id="topArrow">
	↑
</div>

<div class="leftbar">
	<div><a class="category" value="0">최신영화</a></div>
	<div><a class="category" value="1">역사</a></div>
	<div><a class="category" value="2">로맨스</a></div>
	<div><a class="category" value="3">코미디</a></div>
	<div><a class="category" value="4">액션</a></div>
	<div><a class="category" value="5">공포</a></div>
</div>
<main id="main">
	<c:set var="trailer" value="${movieDAO.selectTrailers() }"/>
	<section class="trailer flex center">
		<div class="trailerInner flex sb">
			<c:set var="trailerList" value="${movieDAO.selectTrailers() }"/>
			<div class="wrap">	
				<c:forEach var="trailer" items="${trailerList }">			
					<div class="trailerItem">
						${trailer }
					</div>
				</c:forEach>
			</div>
			<div class="control">	
				<div direction="-1" id="leftArrow" class="arrow flex center">
						◀
				</div>
				<div direction="1" id="rightArrow" class="arrow flex center">
						▶
				</div>
			</div>
		</div>
	</section>
	<section class="movies" style="margin-top: 400px;">
		<h3>최신 영화</h3>
		<c:set var="list" value="${movieDAO.selectRecentMovies() }" />
		<div class="wrapper flex">
			<c:forEach var="dto" items="${list }">
				<div class="movieItem">
					<div>
						<a href="movie-detail.jsp?idx=${dto.idx }"><img id="movieImg" src="movie/${dto.movie_img }"></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	<section class="movies">
		<h3>대한민국의 역사 속으로</h3>
		<c:set var="genre" value="역사"/>
		<c:set var="list" value="${movieDAO.selectMovies(genre) }" />
		<div class="wrapper flex">
			<c:forEach var="dto" items="${list }">
				<div class="movieItem">
					<div>
						<a href="movie-detail.jsp?idx=${dto.idx }" ${empty login ? 'disabled' : '' }><img id="movieImg" src="movie/${dto.movie_img }"></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	<section class="movies">
		<h3>달달한 로맨스가 땡긴다면</h3>
		<c:set var="genre" value="로맨스"/>
		<c:set var="list" value="${movieDAO.selectMovies(genre) }" />
		<div class="wrapper flex">
			<c:forEach var="dto" items="${list }">
				<div class="movieItem">
					<div>
						<a href="movie-detail.jsp?idx=${dto.idx }"><img id="movieImg" src="movie/${dto.movie_img }"></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	<section class="movies">
		<h3>웃음이 필요한 당신에게</h3>
		<c:set var="genre" value="코미디"/>
		<c:set var="list" value="${movieDAO.selectMovies(genre) }" />
		<div class="wrapper flex">
			<c:forEach var="dto" items="${list }">
				<div class="movieItem">
					<div>
						<a href="movie-detail.jsp?idx=${dto.idx }"><img id="movieImg" src="movie/${dto.movie_img }"></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	<section class="movies">
		<h3>답답할 땐 속 시원하게</h3>
		<c:set var="genre" value="액션"/>
		<c:set var="list" value="${movieDAO.selectMovies(genre) }" />
		<div class="wrapper flex">
			<c:forEach var="dto" items="${list }">
				<div class="movieItem">
					<div>
						<a href="movie-detail.jsp?idx=${dto.idx }"><img id="movieImg" src="movie/${dto.movie_img }"></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	<section class="movies">
		<h3>더위를 짜릿하게 날려줄</h3>
		<c:set var="genre" value="공포"/>
		<c:set var="list" value="${movieDAO.selectMovies(genre) }" />
		<div class="wrapper flex">
			<c:forEach var="dto" items="${list }">
				<div class="movieItem">
					<div>
						<a href="movie-detail.jsp?idx=${dto.idx }"><img id="movieImg" src="movie/${dto.movie_img }"></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>

</main>

<script>
	const arr = Array.from(document.querySelectorAll('.trailerItem'))
	
	function slider(event) {
		const unit = 900;
		const mid = Math.trunc(arr.length / 2)
		
		const direction = +event.target.getAttribute('direction')
		
		if(direction == 1) arr.push(arr.shift())
		else			   arr.splice(0, 0, arr.pop())
		
		arr.forEach((element, index) => {
			element.style.opacity = 0.2
			element.style.left = - (unit * (mid - index)) / 2 + 'px'
			element.style.zIndex = -5
			element.style.width = 560 + 'px'
			element.style.height = 315 + 'px'
		})
		
		arr[mid].style.opacity = 1
		arr[mid].style.zIndex = 1
		arr[mid].children[0].width = 560 * 1.1 + 'px'
		arr[mid].children[0].height = 315 * 1.1 + 'px'
		
		arr[0].style.opacity = 0
		
		arr[mid - 2].style.opacity = 0
		arr[mid - 1].children[0].width = 560 * 0.9 + 'px'
		arr[mid - 1].children[0].height = 315 * 0.95 + 'px'
		arr[mid - 1].style.display = 'flex'
		arr[mid - 1].style.alignItems = 'center'
		arr[mid + 1].children[0].width = 560 * 0.9 + 'px'
		arr[mid + 1].children[0].height = 315 * 0.95 + 'px'
		arr[mid + 1].style.display = 'flex'
		arr[mid + 1].style.alignItems = 'center'
		
		arr[mid + 2].style.opacity = 0

		
		arr[arr.length - 1].style.opacity = 0
	}
	
	document.querySelectorAll('.control > div').forEach(e => e.onclick = slider)
		
	for(let i = 0; i < 10; i++) {
			document.querySelector('.control > div').dispatchEvent(new Event('click'))
	}
	
	const categoryBtn = document.querySelectorAll('.category')
	
	const categoryHandler = function(event) {
		var loc = event.target.getAttribute('value')
		window.scrollTo(0, loc * 400)
	}
	
	categoryBtn.forEach(e => e.onclick = categoryHandler)
	
	const topArrow = document.getElementById('topArrow')
	
	
	document.body.onscroll = function() {
		if(window.scrollY > 250) {
			topArrow.classList.remove('hidden')
			topArrow.style.zIndex = 5
		}
		else {
			topArrow.classList.add('hidden')
			topArrow.style.zIndex = -5
		}
	}
	
	topArrow.onclick = function() {
		window.scrollTo(0, 0)
	}
	
</script>

</body>
</html>