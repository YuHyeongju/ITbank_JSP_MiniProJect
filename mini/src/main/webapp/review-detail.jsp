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
	
	background-image: url('${cpath}/image/batman.jpg');
	background-repeat: no-repeat;
	background-size: 100%;
	width:100%;
	height:100%;
	position: absolute;
	top:60px;
	z-index:-1;
	opacity: 0.2;
	
}	

main {
	position: absolute;
	top: 70px;
	width: 1920px;
	height: 600px;
	z-index:1;
}

.reviewandreply {
	border-radius: 15px;
	justify-content: center;
	background-color: rgba(0,0,0,0.6);
	justify-content: center;
	height: 850px;
	margin: auto auto;
	box-shadow:1px 1px 16px 16px black;
	
	
}

.review_detail {
	border-radius: 15px;
	background-color: rgba(0,0,0,0.1);
	color: white;
	
}

.review_image {
	border: 1px solid white;
	border-radius: 15px;
	width: 300px;
	height: 410px;
	margin-top: 30px;
	margin-left: 30px;
}

.review_image>img {
	width: 280px;
	height: 390px;
	margin: auto auto;
	border-radius: 15px;
}

.review_info {
	width: 500px;
	height: 400px;
	margin-left: 20px;
	margin-top: 30px;
	
}

.review_info_inner {
	width: 500px;
	height: 100px;
	border-radius: 15px;
	border: 1px solid white;
}

.review_comment {
	border: 1px solid white;
	border-radius: 15px;
	width: 500px;
	height: 300px;
	margin-top: 10px;
}

.review_info_list {
	list-style: none;
	margin: 0;
	margin-top: 10px;
	font-size:12px;
	padding-left: 10px;
}

.review_comment>p {
	margin: 0;
	padding: 10px;
	font-size:12px;
}

.replyArea {
	margin: 0 auto;
	margin-top: 15px;
	width: 830px;
	height: 330px;
	border-radius: 15px;
}

#reply_h2 {
	margin: 0 20px;
	color: white;
}

#replyWriteForm {
	padding: 15px;
	padding-bottom: 0;
	padding-top: 5px;
	height: 100px;
}

#replyWriteForm > textArea {
	border-radius: 15px;
	background-color: rgba(0,0,0,0.6);
	color:white;
	padding:5px;
}

#submitBtn {
	color: white;
	font-size: 13px;
	font-weight: bold;
	transform: translate(0, -35px);
	
}

#submitBtn:hover {
	color: lightgrey;
	cursor: pointer;
}

.line > hr {
	border: 1px solid lightgray;
	width: 800px;
	margin-top: 0;
	margin-bottom: 0;
}

.replyList {
	border: 1px solid gray;
	padding: 10px;
	width: 500px;
	height: 50px;
	margin-left: 15px;
	border-radius: 15px;
	margin: 10px 15px;
}

.replyList  p, pre {
	margin: 0;
	padding: 0;
}

.replyItem {
	padding: 5px;
}

.Btn {
	margin: 10px;
	margin-left: 30px;
}
#submitBtn{
	background-color: rgba(0,0,0,0.2);
	border:0;	
	color:white;

}

.replyBtn{
	transform: translate(0, 35px);
	
	
}
.replyList{
	color:white;
}
#reviewBtn{
	background-color: rgba(0,0,0,0.2);
	color:white;
	border-radius: 15px;
	padding:5px;
	border:0;
}
.link {
	color: white;
	font-size: 13px;
	font-weight: bold;
}

a:hover {
	cursor: pointer;
}

.replyListArea {
	width: 620px;
}

.replyWrapper {
	height: 200px;
	overflow-y: scroll;
}
</style>
</head>
<body>

	<section id="bg">
	
	</section>

	<main class="flex">
		<div class="reviewandreply">
			<div class="review_detail frame flex">
				<c:set var="row" value="${reviewDAO.upViewCount(param.idx) }" />
				<c:set var="dto" value="${reviewDAO.selectOne(param.idx) }" />
				<div class="review_image flex">
					<c:if test="${!empty dto.review_img }">					
						<img src="${cpath }/image/${dto.review_img}">
					</c:if>
				</div>
				<div class="review_info">
					<div class="review_info_inner">
						<ul class="review_info_list">
							<li>글 번호:${dto.idx }</li>
							<li>글 제목:${dto.title }</li>
							<li>조회수:${dto.viewCount }</li>
							<li>작성자:${dto.writer }</li>
							<li>작성날짜:<fmt:formatDate value="${dto.writeDate }"
									pattern="yyyy년 MM월 dd일 a hh시 mm분" /></li>
						</ul>
					</div>
					<div class="review_comment flex sb">
						<p>${dto.content }</p>
					</div>
				</div>
			</div>
			<div class="replyArea">
				<h2 id="reply_h2">댓글</h2>
				<form method="POST" id="replyWriteForm">
					<textarea name="content" rows="5" cols="70" required></textarea>
					<input type="hidden" name="writer" value="${login.userid }">
					<input type="hidden" name="board_idx" value=${dto.idx }> 
					<input id="submitBtn" type="submit" value="댓글 등록">
				</form>
				<c:if test="${pageContext.request.method =='POST'}">
					<jsp:useBean id="reply" class="reply.ReplyDTO" />
					<jsp:setProperty property="*" name="reply" />
					<c:set var="row" value="${replyDAO.insertReply(reply) }" />
					<c:if test="${row != 0 }">
						<script>
							location.href ='${cpath}/review-detail.jsp?idx=${dto.idx}'
						</script>
					</c:if>
					<c:if test="${row == 0 }">
						<script>
							history.back()
						</script>
					</c:if>
				</c:if>
				<div class="line">
					<hr>
				</div>
				<div class="replyWrapper">			
				<c:forEach var="reply" items="${replyDAO.selectReplyList(param.idx) }">
					<div class="replyListArea flex">
						<div class="replyList">

							<p>${reply.writer }</p>
							<hr>
							<pre>${reply.content }</pre>

						</div>
						<div>
						
						</div>
						<c:if test="${login.userid == reply.writer }">
							<div class="replyBtn">
								<a class="link" href="reply-delete.jsp?idx=${reply.idx}&board_idx=${param.idx}">
									댓글 삭제
								</a>
							</div>
						</c:if>
					</div>
				</c:forEach>
				</div>	
			</div>
			<div class="Btn">
				<a class="link" href="review.jsp">전체 리뷰</a>

				<c:if test="${login.userid == dto.writer}">
					<a class="link" href="${cpath }/review-modify.jsp?idx=${dto.idx }">리뷰 수정</a>
					<a id="reviewDelete" class="link" href="${cpath }/review-delete.jsp?idx=${dto.idx }&board_idx=${param.idx}">리뷰 삭제</a>
				</c:if>
			</div>
		</div>
	</main>
	
	<script>
		
		if(login_userid != '') {
			const reviewDeleteBtn = document.getElementById('reviewDelete')
			
			reviewDeleteBtn.onclick = function(event) {
				event.preventDefault()
				const loc = event.target.href
				const flag = confirm('정말 삭제하시겠습니까?')
				
				if(flag) {
					location.href = loc
				}
			}
		}
		
		if(login_userid == '') {
			const replyWriteForm = document.getElementById('replyWriteForm')
			replyWriteForm.style.display = 'none'
		}
		
	</script>
</body>
</html>