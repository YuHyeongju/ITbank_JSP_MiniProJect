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
	background-image:
		url('${cpath}/image/batman.jpg');
	background-repeat: no-repeat;
	background-size: 100%;
	width: 100%;
	height: 100%;
	position: absolute;
	top: 60px;
	z-index: -1;
	opacity: 0.7;
}

.review_write {
	position: absolute;
	top: 100px;
	right: 500px;
	border-radius: 15px;
	background-color: rgba(0, 0, 0, 0.4);
	height: 600px;
	box-shadow: 1px 1px 16px 16px black;
}

#review_h2 {
	color: white;
}

.reviewForm {
	margin: auto auto;
	text-align: center;
}

.reviewForm> p > input {
	width: 400px;
	margin: 10px;
	background-color: rgba(0, 0, 0, 0.6);
	border-radius: 15px;
	border: 0;
}

.reviewForm> p > textarea {
	background-color: rgba(0, 0, 0, 0.6);
	border-radius: 15px;
	padding: 5px;
	color: white;
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
#submitBtn{
	color: white;
	background-color: rgba(0, 0, 0, 0.01);
}
.reviewBtn {
	position: absolute;
	bottom: 10px;
	left: 10px;
	background-color: rgba(0, 0, 0, 0.1);
	border: 0;
	color: white;
}

input[type="text"] {
	color: white;
}
</style>

</head>
<body>
	<section id="bg"></section>

	<main>
		<c:if test="${pageContext.request.method =='GET' }">
			<c:if test="${empty login }">
				<script>
					alert('먼저 로그인후 글을 작성할 수 있습니다.')
					location.href = 'login.jsp'
				</script>
			</c:if>
			<div class="review_write frame flex">
				<form method="POST" enctype="multipart/form-data" class="reviewForm">
					<h2 id="review_h2">리뷰 작성 하기</h2>

					<input type="hidden" name="writer" value="${login.userid }" />

					<p>
						<input type="text" name="title" placeholder="리뷰 제목 입력">
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
						<textarea name="content" placeholder="리뷰 내용 입력" rows="10"
							cols="55"></textarea>
					</p>
					<P>
						<input type="submit" value="작성하기" id="submitBtn">
					</P>
				</form>
				<a href="review.jsp"><button class="reviewBtn">리뷰목록으로
						돌아가기</button></a>
			</div>
		</c:if>
		<c:if test="${pageContext.request.method =='POST' }">
			<c:set var="dto"
				value="${reviewFileUtil.getDTO(pageContext.request) }" />
			<c:set var="row" value="${reviewDAO.insert(dto) }" />
			<c:if test="${row != 0 }">
				<script>
					location.href = '${cpath}/review.jsp'
				</script>
			</c:if>
			<c:if test="${row == 0 }">
				<script>
					alert('작성실패')
					history.back()
				</script>
			</c:if>



		</c:if>
	</main>
</body>
</html>