<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<c:set var="liked" value="${movieDAO.isLike(login.userid, param.idx) }" />
<c:if test="${liked  == 0 }">
	${movieDAO.pushLike(login.userid, param.idx) }
</c:if>
<c:if test="${liked  == 1 }">
	${movieDAO.cancelLike(login.userid, param.idx) }
</c:if>

<c:redirect url="movie-detail.jsp?idx=${param.idx }"/>

</body>
</html>