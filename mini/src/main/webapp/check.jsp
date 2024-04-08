<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.net.URLEncoder"%>
<%@ include file="header.jsp"%>
<c:set var="dto" value="${memberDAO.check(param.userid) }" scope="request"/>
<c:if test="${!empty dto }">
	<c:redirect url="join.jsp?result=1&userid=${URLEncoder.encode(param.userid, 'UTF-8') }"></c:redirect>
</c:if>
<c:if test="${empty dto }">
	<c:redirect url="join.jsp?result=0&userid=${URLEncoder.encode(param.userid, 'UTF-8') }"></c:redirect>
</c:if>




</body>
</html>