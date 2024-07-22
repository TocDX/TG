<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>region</title>
</head>
<body>
<%@ include file="../common/header.jsp"%>

<main>
    <div class="d-flex container-xxl" style="margin-top: 80px; justify-content: space-around; border-radius: 10px; flex-wrap: wrap;">
    <c:forEach items="${KEY_EVENTLIST}" var="rvo">

        <div class="card mb-3" style="width: 22rem; margin-bottom: 15px;">
            <a href="${pageContext.request.contextPath}/event_detail?contentid=${rvo.contentid}">
                <img style="height: 200px" src="${rvo.firstimage}" class="card-img-top" alt="...">
                <div class="card-body" style="text-align: center;">
                    <p class="card-text">${rvo.title}</p>
                </div>
            </a>
        </div>

    </c:forEach>

    </div>

    <div class="d-flex" style="justify-content: center">
    ${KEY_PAGEING_HTML1}
    </div>
</main>
<%@ include file="../common/footer.jsp"%>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</body>
</html>
