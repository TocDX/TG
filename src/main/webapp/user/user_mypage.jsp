<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
    <title>Title</title>

</head>
<body>
<%@ include file="../common/header.jsp"%>


<div style="background-color: rgb(247, 247, 247); height:500px;">
    <div class="container d-flex flex-row justify-content-center py-5">
        <div class="col-4" style="max-width: 1080px; max-height: 404px; margin-right:4px; background-color: white;">
            <!-- 프로필 -->
            <div class="p-3">
                <!-- 프사 -->
                <div class="d-flex justify-content-center mb-3">
                    <c:choose>
                        <c:when test="${not empty MY_USERVO.profileImg}">
                            <img src="user/imgs/remove-background-before-qa1 (1).png" alt="Profile Image" style="width:180px; height:180px; border-radius:2rem; object-fit:cover;" />
                        </c:when>
                        <c:otherwise>
                            <img src=""
                                 style='width: 180px; height: 180px; border-radius: 2rem; object-fit: cover;' alt="더미프사">
                        </c:otherwise>
                    </c:choose>

                </div>
                <h4 class="text-center fw-bold my-4" style="font-family: 'NanumSquareNeo-Variable';">${MY_USERVO.userName}님의 프로필</h4>
                <!-- 팔로잉 팔로워 -->


                </div>

                <div>
                    <a href="${pageContext.request.contextPath}/user/user_update.jsp">
                        <button class="btn" style="width: 100%; margin:0 auto; font-family: 'NanumSquareNeo-Variable';">프로필 수정</button>
                    </a>
                </div>

            </div>
        </div>

    </div>
</div>

<div></div>

</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>
