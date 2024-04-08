<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<style>
	.root {
		position: absolute;
		width: 100%;
		height: 1080px;
		top: 60px;
		color: white;
	}
	#searchItem {
		width: 50%;
		height: 200px;
		margin: 0 auto;
		margin-bottom: 20px;
		background-color: rgba(0, 0, 0, 0.90);
		border-radius: 15px;
		box-shadow: 4px 4px 4px 4px black;
		box-sizing: border-box;
	}
	#searchItem > div:first-child {
		width: 30%;
	}
	#searchItem > div:last-child {
		width: 60%;
	}
	#poster {
		border-radius: 20px;
		width: 150px;
		height: 150px;
	}
	#title {
		font-size: 20px;
		font-weight: bold;
	}
	#align {
		justify-content: flex-end;
	}
	.alignDrop {
		margin-right: -38px;
		margin-bottom: 5px;
		padding: 0;
		background-color: black;
		list-style: none;
		font-size: 12px;
		font-weight: bold;
		color: white;
		padding: 2px 5px;
	}
	input[type="submit"] {
		all: unset;
	}
	input[type="submit"]:hover {
		cursor: pointer;
	}
	#red {
		color: red;
	}
	.hidden {
		display: none;
	}
	.content {
		font-size: 13px;
	}
</style>

<c:if test="${empty param.search }">
	<c:redirect url="index.jsp" />
</c:if>

<c:if test="${empty param.align or param.align == '이름'}">
	<c:set var="list" value="${movieDAO.selectMoviesBySearch(param.search) }" />
</c:if>

<c:if test="${param.align == '최신' }">
	<c:set var="list" value="${movieDAO.selectMoviesBySearchRecent(param.search) }" />
</c:if>

<c:if test="${param.align == '인기' }">
	<c:set var="list" value="${movieDAO.selectMoviesBySearchPop(param.search) }" />
</c:if>


<main class="root">
	<div class="frame flex" id="align">
		<div>	
			<form>	
				<select class="alignDrop" name="align" id="alignItem">
					<option value="이름" ${param.align == '이름' ? 'selected' : '' }>이름순</option>
					<option value="최신" ${param.align == '최신' ? 'selected' : '' }>최신순</option>
					<option value="인기" ${param.align == '인기' ? 'selected' : '' }>인기순</option>
				</select>
			</form>
		</div>
	</div>
	<c:forEach var="dto" items="${list }">	
		<section class="flex sb" id="searchItem">
			<div>
				<a href="movie-detail.jsp?idx=${dto.idx }&searched=1&search=${param.search}"><img src="movie/${dto.movie_img }" id="poster"></a>
			</div>
			<div class="content">
				<p id="title">${dto.name }</p>
				<p>장르 ${dto.genre }</p>
				<p>개봉일 ${dto.release_date }</p>
				<p>출연진 ${dto.casting }</p>
				<p>상영시간 ${dto.playtime }분</p>
			</div>
		</section>
	</c:forEach>
</main>

<script>
	const align = document.getElementById("alignItem")
	align.onchange = function() {
		var selectValue = align.options[align.selectedIndex].value;
		if(selectValue == "이름") {
			location.href = 'search.jsp?search=${param.search}&align=이름'
		}
		if(selectValue == "최신") {
			location.href = 'search.jsp?search=${param.search}&align=최신'
		}
		if(selectValue == "인기") {
			location.href = 'search.jsp?search=${param.search}&align=인기'
		}
	}
	
	
	const searchItems = document.querySelectorAll('#searchItem')
	const init = function() {
		for(let i = 5; i < searchItems.length; i++) {
			searchItems[i].classList.add('hidden')
		}
	}
	init()

	document.body.onscroll = function(event) {
		const n = window.scrollY
		const current = Array.from(searchItems).filter(e => e.classList.contains('hidden') == false).length
		if(n % 216 == 0 || (n - 216) % 1320 == 0) {
			Array.from(searchItems).filter((element, index) => index <= current + 5).forEach(e => e.classList.remove('hidden'))
		}
	}
	
</script>

</body>
</html>