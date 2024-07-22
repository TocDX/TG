<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>region_detail</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac58ace84bf2ce71079d32d9e4d4931b&libraries=clusterer"></script>

</head>

<body>
<%@ include file="../common/header.jsp"%>
<section>
    <c:forEach items="${KEY_COMMONDETAIL}" var="commonItem">
        <div class="container-xxl d-flex" style="justify-content: center;margin-top: 100px;" >
            <p style="font-size: 50px">${commonItem.title}</p>
        </div>

        <div class="container-xxl d-flex" style="justify-content: center;" >
            <p>${commonItem.addr1}</p>
        </div>

        <div class="container-xxl d-flex" style="justify-content: start;gap: 15px;">

            <i class="bi bi-heart-fill"> 숫자</i>

            <i class="bi bi-eye"> ${commonItem.viewcnt}</i>
        </div>

        <hr class="container-xxl">

        <div class="container-xxl d-flex" style="justify-content: center;margin-top: 10px;" >
            <img src="${commonItem.firstimage}" style="width: 1000px; height: 700px"/>
        </div>

    <hr class="container-xxl" style="margin-top: 50px">

        <div class="container-xxl d-flex" style="justify-content: center; text-align:center;width:1000px;margin-top: 50px;">
              ${commonItem.overview}
        </div>
    </c:forEach>
    <hr class="container-xxl" style="margin-top: 50px">

    <div id="map" class="d-flex container-xl" style="margin-top:50px;justify-content:center;width:80%;height:350px;"></div>
</section>
<script>
    document.addEventListener("DOMContentLoaded", function() {

// console.log(${items});
    <c:forEach var="items" items="${KEY_COMMONDETAIL}">
        console.log(${items.mapx}, ${items.mapy})
    var mapContainer = document.getElementById('map'); // 지도를 표시할 div
    var mapOption = {
    center: new kakao.maps.LatLng( ${items.mapy} , ${items.mapx}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
    };
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

        var markerPosition  = new kakao.maps.LatLng(${items.mapy} , ${items.mapx});

// 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });

// 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);
        </c:forEach>
});

    </script>

    <%@ include file="../common/footer.jsp" %>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</body>
</html>
