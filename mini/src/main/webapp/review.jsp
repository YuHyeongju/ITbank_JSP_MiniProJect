<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H&H</title>
<style>
body{
 	overflow-y: hidden;
}
#bg{
	background-image: url('${cpath}/image/batman.jpg');
	background-repeat: no-repeat;
	background-size: 100%;
	width:100%;
	height:100%;
	position: absolute;
	top:60px;
	z-index:-1;
	opacity: 0.7;
}
.review {
	position: absolute;
	top: 100px;
	left: 500px;
	height: 600px;
	border-radius: 20px;
	background-color:black;
	opacity:0.8;
	z-index:1;
	box-shadow: 1px 1px 16px 16px black;
}

table {
	border-collapse: collapse;
	width: 800px;
	margin: 0 auto;
	margin-top: 15px;
	
}

th, td {
	border-bottom: 1px solid white;
	color: white;
	padding: 10px;
	text-align: center;
}

#title {
	width: 400px;
}

.btnAndPaging {
	position: absolute;
	bottom: 30px;
	right: 50px;
	width: 800px;
	padding: 10px 0;
}

.paging {
	width: 100%;
	display: flex;
	justify-content: center;
	position:absolute;
	bottom:140px;
	color: white;
	padding:10px;
	border-radius: 15px;
	opacity: 0.8;
}

.bold {
	font-weight: bold;
	color: red;
}

#searchArea{
	all: unset;
	background-color: darkgrey;
	box-sizing: border-box;
	padding: 0 5px;
	color: black;
	border: 2px solid white;
	font-size: 14px;
	border-radius: 15px;
	height: 35px;
}
#searchArea:focus {
	border: 2px solid red;
	background-color: black;
	z-index: 1;
	color: white;
}
#searchArea::placeholder {
	color: white;
}
#searchBtn{
	border: 0;
	border-radius: 15px;
	width: 40px;
    height: 40px;
    font-weight: bold;
    transform: translate(0px, 1px);
}
#searchBtn:hover {
	background-color: #434343;
	cursor: pointer;
}
.btn {
	box-sizing: border-box;
	padding: 10px 0;
}

#writeBtn {
	font-size: 13px; 
	color: white; 
	font-weight: bold;
}

.pagingInner {
	box-shadow: 1px 1px 14px 14px black;
	background-color: rgba(0, 0, 0, 0.9);
}
</style>

</head>
<body>

	<section id="bg">
	
	</section>


	<main>
		<div class="review frame">
			<table cellpadding="0" cellspacing="10">
				<c:set var="reviewCount"
					value="${reviewDAO.selectCount(param.search) }" />
				<c:set var="paramPage" value="${empty param.page? 1: param.page }" />
				<c:set var="paging"
					value="${ReviewPaging.newInstance(paramPage, reviewCount) }" />
				<c:set var="list"
					value="${reviewDAO.selectList(param.search, paging) }" />
				<tr>
					<th>글 번호</th>
					<th id="title">제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성날짜</th>
				</tr>
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.idx }</td>
						<td><a href="review-detail.jsp?idx=${dto.idx}">${dto.title }</a></td>
						<td>${dto.writer }</td>
						<td>${dto.viewCount }</td>
						<td>${dto.writeDate }</td>
					</tr>
				</c:forEach>
			</table>
			<div class="btnAndPaging flex sb frame ">
				<div class="searchbar">
					<form>
						<input type="search" name="search" placeholder="검색어 입력" id="searchArea"> 
						<input type="submit" value="검색" id="searchBtn">
					</form>
				</div>
				<div class="btn">
					<a href="review-write.jsp" id="writeBtn">리뷰 작성</a>
				</div>
			</div>

		</div>
		<div class="paging">	
			<div class="pagingInner">
				<c:if test="${paging.prev }">
					<a
						href="${cpath }/review.jsp?page=${paging.begin - 10 }&search=${param.search }">[이전]</a>
				</c:if>
	
				<c:forEach var="i" begin="${paging.begin}" end="${paging.end}">
					<a class="${paging.page == i ? 'bold': '' }"
						href="${cpath }/review.jsp?page=${i}&search=${param.search }">[${i }]
					</a>
				</c:forEach>
	
				<c:if test="${paging.next }">
					<a
						href="${cpath }/review.jsp?page=${paging.end + 1}&search=${param.search }">[다음]</a>
				</c:if>
			</div>
		</div>
	</main>

	<script>
		const writeBtn = document.getElementById('writeBtn')
		
		writeBtn.onclick = function(event) {
			if(login_userid == '') {
				event.preventDefault()
				wantlogin()
			}
		}
	</script>
</body>
</html>


