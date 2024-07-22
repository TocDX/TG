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


    <c:forEach items="${KEY_FESTIVALLIST}" var="festivalItem">
        <a href="${pageContext.request.contextPath}/festival_detail?contentid=${festivalItem.contentid}">
            <div class="card mb-5 container-xxl" style="max-width: 1200px;margin-top: 40px; border: none ">
                <div class="row g-0">
                    <div class="col-md-4">
                        <img src="${festivalItem.firstimage}" class="img-fluid rounded-start" alt="..." style="width: 400px; height: 200px;border-radius: 10px">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title"> 축제명 : ${festivalItem.title}</h5>
                            <p class="card-text">축제기간 : ${festivalItem.eventstartdate} ~ ${festivalItem.eventenddate}</p>
                            <p class="card-text"><small class="text-body-secondary">주소 : ${festivalItem.addr1} </small><br> <small class="text-body-secondary" style="margin: 35px"> ${festivalItem.addr2}</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </a>
        <hr class="container-xxl">
    </c:forEach>
    <div class="d-flex" style="justify-content: center">
        ${KEY_PAGEING_HTML}
    </div>
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
