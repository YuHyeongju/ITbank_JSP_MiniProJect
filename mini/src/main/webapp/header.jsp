<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.*, movie.*, review.*, reply.*, star.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<c:set var="memberDAO" value="${MemberDAO.getInstance() }" />
<c:set var="movieDAO" value="${MovieDAO.getInstance() }" />
<c:set var="reviewDAO" value="${ReviewDAO.getInstance() }"/>
<c:set var="replyDAO" value="${ReplyDAO.getInstance() }"/>
<c:set var="starDAO" value="${StarDAO.getInstance() }"/>
<c:set var="reviewFileUtil" value="${ReviewFileUtil.getInstance() }"/>
<c:set var="memberFileUtil" value="${MemberFileUtil.getInstance() }"/>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H&H</title>
<script>
	const login_userid = '${login.userid}'
</script>
<style>
html {
	scroll-behavior: smooth;
}

body {
	margin: 0;
	padding: 0;
	background-color: rgba(0, 0, 0, 0.9);
}

header {
	width: 100%;
	height: 60px;
	background-color: rgba(0, 0, 0, 0.85); color : white;
	position: fixed;
	z-index: 100;
	color: white;
}

header>div {
	width: 33%;
}

.center { /* 상하좌우 기준으로 중앙 배치 */
	justify-content: center;
	align-items: center;
}

.flex {
	display: flex;
}

.sb {
	justify-content: space-between;
}

.frame {
	width: 900px;
	margin: 0 auto;
}

a {
	text-decoration: none;
	color: inherit;
}

a:hover {
	cursor: pointer;
	color: lightgrey;
}

.logo {
	box-sizing: border-box;
	padding: 0 10px;
	align-items: center;
}

.logo>a {
	font-size: 40px;
	color: red;
	font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
}

.searchBar>.searchBar_inner {
	width: 500px;
	border-bottom: 1px solid grey;
}

.searchArea {
	position: relative;
	font-size: 13px;
	all: unset;
	box-sizing: border-box;
	padding: 0 5px;
	width: 500px;
	height: 40px;
	background-color: darkgray;
}

.searchArea:focus {
	background-color: black;
	border: 2px solid red;
	color: white;
}

.searchArea:focus ~ #searchRank {
	display: block;
}

.searchBar .searchButton {
	width: 50px;
	height: 50px;
	background: inherit;
	all: unset;
}

.nav>ul>li {
	list-style: none;
}

#search {
	display: none;
}

#searchForm {
	all: unset;
}

#menu {
	align-items: center;
}

#menu>li {
	width: 25%;
}


#rankInner>div:nth-child(1) {
	width: 10%;
}

#rankInner>div:nth-child(2) {
	width: 60%;
}

#profile {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin-left: 5px;
	margin-bottom: -10px;
}
</style>
</head>
<body>

	<header class="flex sb">
		<div class="logo flex">
			<a href="${cpath }">H&H</a>
		</div>
		<div class="searchBar flex center">
			<div class="searchBar_inner flex sb">
				<form id="searchForm" action="search.jsp">
					<input class="searchArea" name="search" type="search"
						placeholder="제목, 출연진 등으로 검색..." value="${param.search }"
						autocomplete="off"> <input type="submit" value="검색"
						id="search">
				</form>
			</div>
		</div>
		<div class="nav">
			<ul class="flex center" id="menu">
				<li><a
					href="${cpath }/${empty login ? 'login.jsp' : 'logout.jsp'}">${empty login ? 'LOGIN' : 'LOGOUT' }</a></li>
				<c:if test="${empty login }">
					<li><a href="${cpath }/join.jsp">JOIN</a></li>
				</c:if>
				<li><a href="${cpath }/review.jsp">REVIEW</a></li>
				<c:if test="${!empty login }">
					<li>
						<a href="myPage.jsp">						
							<img src="image/${login.profile_img }" id="profile">
						</a>
						<span style="margin-left: 10px;">${login.nickname } 님 </span>
					</li>
				</c:if>
			</ul>
		</div>
	</header>
	
	<script>
		function wantlogin() {
			const flag = confirm('로그인이 필요한 기능입니다. 로그인 하시겠습니까?')
			if(flag) {
				location.href = 'login.jsp'
			}
		}
	</script>

