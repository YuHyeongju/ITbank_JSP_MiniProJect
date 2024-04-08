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
	background-image: url('${cpath}/image/batman_logo-wallpaper-1920x1080.jpg');
	background-repeat: no-repeat;
	background-size: 100%;
	width:100%;
	height:100%;
	position: absolute;
	top:60px;
	z-index:-1;
	
}
	.myReviewList{
		position: absolute;
		top:90px;
		left:500px;
		background-color: black;
		height: 800px;
		border-radius: 15px;
		opacity:0.7;
		z-index:1;
		box-shadow: 1px 1px 16px 16px black;
		padding:10px;
	}
	.myReviewListTable{
		
		border-collapse: collapse;
		color: white;
	}
	tr{
		
		border-bottom: 1px solid white;
	}
	
	tr,td{
		
		padding: 10px;
		text-align: center;
	}
	#title{
		width:400px;
	
	}
	#restoreBtn{	
		color:white;
		background-color: rgba(0, 0, 0, 0.1);
		border:0;
	
	
	}
	.paging{
		position: absolute;
		bottom:0;
		left:300px;
		width:300px;
		margin: 0 auto;
		color: white;
		background-color: grey;
		padding:10px;
		border-radius: 15px;
		opacity: 0.8;
		
	}
	.bold{
		font-weight: bold;
		color: red;	
	}
</style>
</head>
<body>
	<section id="bg">
	
	</section>

	<main>
		<div class="myReviewList frame">
			<c:set var="myReviewCount" value="${reviewDAO.selectCount(login.userid) }" />
			<c:set var="paramPage" value="${empty param.page? 1: param.page }" />
			<c:set var="paging"   value="${ReviewPaging.newInstance(paramPage, myReviewCount, 1) }" />
			<c:set var="list"  value="${reviewDAO.selectReviewListALL(login.userid, paging) }" />
			<table  cellpadding="0" cellspacing="10" class="myReviewListTable frame">
				<tr>
					<th>글 번호</th>
					<th id="title">제목</th>
					<th>작성자</th>
					<th>작성 날짜</th>
					<th>복구</th>
				</tr>
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.idx }</td>
						<td><a href="review-detail.jsp?idx=${dto.idx}">${dto.title }</a></td>
						<td>${dto.writer }</td>
						<td>${dto.writeDate }</td>
						<c:if test="${dto.deleted == 1 }">
							<td><a href="${cpath }/review-delete.jsp?idx=${dto.idx}&restore=1"><button id="restoreBtn">복구하기</button></a></td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
			<div class="paging">
			<c:if test="${paging.prev }">
				<a
					href="${cpath }/myBoard.jsp?page=${paging.begin - 10 }">[이전]</a>
			</c:if>

			<c:forEach var="i" begin="${paging.begin}" end="${paging.end}">
				<a class="${paging.page == i ? 'bold': '' }"
					href="${cpath }/myBoard.jsp?page=${i}">[${i }]
				</a>
			</c:forEach>

			<c:if test="${paging.next }">
				<a
					href="${cpath }/myBoard.jsp?page=${paging.end + 1}">[다음]</a>
			</c:if>
		</div>
		</div>
	</main>
</body>
</html>