<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H&H</title>
<style>
body{
	overflow-y:hidden;
}
#bg{
	
	background-image:
		url('${cpath}/image/2023_john_wick_4_movie-wallpaper-1920x1080.jpg');
	background-repeat: no-repeat;
	background-size: 100%;
	width: 100%;
	height: 100%;
	position: absolute;
	top: 60px;
	z-index: -1;
	opacity: 0.2;

}
.review_modify {
	position: absolute;
	top: 100px;
	right: 500px;
	height: 600px;
	background-color: rgba(0, 0, 0, 0.4);
	border-radius: 15px;
	box-shadow: 1px 1px 16px 16px black;
}
#reviewModify_h2{
	color: white;
}
.review_modifyForm{
	margin: auto auto;
	
}
.review_modifyForm > p{
	padding:  10px 0;
	color:white;
}
.review_modifyForm > p > input{
	width: 400px;
	margin: 10px 0;
	background-color: rgba(0, 0, 0, 0.6);
	border-radius: 15px;
	border: 0;
	color:white;
}
#file-label {
	background-color: rgba(0, 0, 0, 0.6);
	border-radius: 15px;
	border: 0;
	color: white;
	display: flex;
	align-items: center;
}

.filesuntek{
	z-index: 5;
	padding-left:3px;
	background-color: rgba(0, 0, 0, 0.1);
	font-size: 12px;
}

#fileArea {
	width: 350px;
	height: 24px;
	display: inline-block;
	overflow: hidden;
	position: relative;
	left: 12px;
	background-color: rgba(0, 0, 0, 0.1);
	
}
#input-file{
	position: absolute; 
	top: 0; 
	left: -75px;
	background-color: rgba(0, 0, 0, 0.1);
	font-size:13px;
}
.review_modifyForm > p > textarea{
	width: 380px;
	margin: 10px 0;
	background-color: rgba(0, 0, 0, 0.6);
	border-radius: 15px;
	border: 0;
	color:white;
	padding:10px;
}
.Btn{
	position: absolute;
	bottom:10px;
	left:10px;
	
}
#modifyBtn{
	background-color: rgba(0, 0, 0, 0); 

}
#reviewListBtn{
	background-color: rgba(0, 0, 0, 0.1);
	border: 0;
	color:white;
}
</style>

</head>


<body>
	<section id="bg">
	
	</section>

	<div class="review_modify frame flex">
		<c:if test="${pageContext.request.method == 'GET' }">
			<c:set var="dto" value="${reviewDAO.selectOne(param.idx) }"/>
			<form method="POST" enctype="multipart/form-data"
				class="review_modifyForm">
				<h2 id="reviewModify_h2">리뷰 수정 하기</h2>

				<input type="hidden" name="idx" value="${param.idx }">

				<p>
					<input type="text" name="title" placeholder="수정할 리뷰 제목 입력" value="${dto.title }">
				</p>
				<p>
					<label id="file-label"> 
						<span class="filesuntek">파일 선택</span> 
						<span id="fileArea"> 
							<input type="file" name="uploadFile" id="input-file">
						</span>
					</label>
				</p>
				<p>
					<textarea name="content" placeholder="수정할 리뷰 내용 입력" rows="10" cols="55">${dto.content }</textarea>
				</p>
				<P>
					<input type="submit" value="수정하기" id="modifyBtn">
				</P>
			</form>
		</c:if>
		<c:if test="${pageContext.request.method == 'POST' }">
			<c:set var="dto" value="${reviewFileUtil.getDTO(pageContext.request) }"/>
			<c:set var="row" value="${reviewDAO.modify(dto,param.idx) }" />
			<c:if test="${row != 0 }">
				<script>
					alert('수정성공')
					location.href= '${cpath}/review.jsp?idx=${param.idx}'
				</script>
			</c:if>
			<c:if test="${row == 0 }">
				<script>
					alert('수정실패')
					history.back()
				</script>
			</c:if>
		</c:if>
		<div class="Btn">
			<a href="review.jsp"><button id="reviewListBtn">리뷰 목록으로 이동</button></a>
			
		</div>
	</div>
</body>
</html>