<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<c:set var="row" value="${replyDAO.deleteReply(param.idx) }"/>
<c:if test="${row != 0 }">
		<script>
			alert('삭제 성공')
			location.href = '${cpath}/review-detail.jsp?idx=${param.board_idx}'
		</script>
</c:if>
<c:if test="${row == 0 }">
	<script>
		alert('삭제 실패')
		history.back()
	</script>	
</c:if>

</body>
</html>