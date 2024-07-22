<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

회원목록<hr>

<c:forEach items="${MY_USERLIST}" var="uvo">
	${uvo.userSeq}
	<a href="${pageContext.request.contextPath}/user_detail?userSeq=${uvo.userSeq}">${uvo.userName}</a>,
	<img src="/resources/imgs/${uvo.profileImg}"><br><br>
</c:forEach><br>

<p><br>


</body>
</html>