<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<jsp:useBean id="dto" class="star.StarDTO"/>
<jsp:setProperty property="*" name="dto"/>

<c:set var="star" value="${starDAO.hasStar(dto) }"/>

<c:if test="${empty star }">
	<c:set var="row" value="${starDAO.insertStar(dto) }"/>
	<c:if test="${row != 0 }">
		<script>
			location.href = 'movie-detail.jsp?idx=${dto.movie_idx}'
		</script>
	</c:if>
	<c:if test="${row == 0 }">
		<script>
			history.back()
		</script>
	</c:if>
</c:if>
<c:if test="${!empty star }">
	<c:set var="row" value="${starDAO.updateStar(dto) }"/>
	<c:if test="${row != 0 }">
		<script>
			location.href = 'movie-detail.jsp?idx=${dto.movie_idx}'
		</script>
	</c:if>
	<c:if test="${row == 0 }">
		<script>
			history.back()
		</script>
	</c:if>
</c:if>



</body>
</html>