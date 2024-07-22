<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body data-page-type="course">


<c:forEach items="${KEY_BOARDLIST}" var="bvo">
	<a href="${pageContext.request.contextPath}/board_detail?seq=${bvo.seq}">
		<div class="card mb-5 container-xxl" style="max-width: 1200px;margin-top: 40px; border: none ">
			<div class="row g-0">
				<div class="col-md-8">
					<div class="card-body">
						<h5 class="card-title"> 제목 : ${bvo.title}</h5>
						<p class="card-text"><small class="text-body-secondary">주소 : ${bvo.regdate} </small></p>
					</div>
				</div>
			</div>
		</div>
		
	</a>
	<hr class="container-xxl">
</c:forEach>
${KEY_PAGEING_HTML}

<p><br>
	<c:choose >
	<c:when test="${not empty sessionScope.SESS_USER_EMAIL}">
		<a href="${pageContext.request.contextPath}/board/board_insert.jsp">글쓰기</a>
	</c:when>
	<c:otherwise>
	</c:otherwise>
	</c:choose>

	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
			crossorigin="anonymous"
	></script>
	
	


</body>
</html>