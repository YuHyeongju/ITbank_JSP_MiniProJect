<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<c:set var="dto" value="${reviewDAO.selectOne(param.idx) }"/>

${reviewFileUtil.deleteFile(dto.review_img) }
<c:set var="row" value="${reviewDAO.delete(param.idx) }"/>

<c:if test="${row != 0 }">
<c:if test="${empty param.restore }">
		<script>
			alert('삭제성공')
			location.href = '${cpath}/review.jsp'
		</script>
</c:if>
<c:if test="${!empty param.restore }">
		<script>
			alert('복구성공')
			location.href = '${cpath}/myBoard.jsp'
		</script>
</c:if>
		
</c:if>
<c:if test="${row == 0 }">
	<script>
		alert('삭제실패')
		history.back()
	</script>	
</c:if>



</body>
</html>