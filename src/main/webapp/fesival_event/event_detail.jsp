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
    <c:forEach items="${KEY_EVENTDETAIL}" var="item">
        <div class="container-xxl d-flex" style="justify-content: center;margin-top: 100px;" >
            <p style="font-size: 50px">${item.title}</p>
        </div>

        <div class="container-xxl d-flex" style="justify-content: center;" >
            <p>${item.addr1}</p>
        </div>

        <div class="container-xxl d-flex" style="justify-content: start;gap: 15px;">
            <i class="bi bi-heart-fill"> 숫자</i>

            <i class="bi bi-eye"> ${item.viewcnt}</i>

                </div>

        <hr class="container-xxl">

        <div class="container-xxl d-flex" style="justify-content: center;margin-top: 10px;" >
            <img src="${item.firstimage}" style="width: 1000px; height: 700px"/>
        </div>
    </c:forEach>
    <h3 class="container-xxl d-flex" style="position: relative;top: 40px; ">상세정보</h3>
    <hr class="container-xxl" style="margin-top: 50px;border: 1px solid black;">
    <c:forEach items="${KEY_COMMONDETAIL2}" var="commonItem">
        <div class="container-xxl d-flex" style="justify-content: center; text-align:center;width:1000px;margin-top: 50px;">
                ${commonItem.overview}
        </div>
    </c:forEach>
    <hr class="container-xxl" style="margin-top: 50px;border: 1px solid black;">
    <c:forEach var="items" items="${KEY_EVENTDETAIL}">
        <a href="https://map.kakao.com/link/to/${items.title},${items.mapy} , ${items.mapx}">
            <div id="map" class="d-flex container-xl" style="margin-top:50px; justify-content:center; width:80%;height:350px;">
            </div>
        </a>
    </c:forEach>
    <c:forEach items="${KEY_INTRO2}" var="introItems1">
        <div class="container-xxl d-flex" style="margin-top:20px; align-items: center; justify-content:start; gap: 10px;  flex-wrap: wrap">
        <i class="bi bi-calendar-date"></i><span style="font-weight:bolder ;">시작일: </span> ${introItems1.eventstartdate}

        <i class="bi bi-calendar-date"></i> <span style="font-weight: bolder; ">종료일: </span> ${introItems1.eventenddate}

        <i class="bi bi-telephone"></i> <span style="font-weight: bolder;">전화번호: </span> ${introItems1.sponsor1tel}

            <i class="bi bi-house"></i> <span style="font-weight: bolder">홈페이지: </span> ${introItems1.eventhomepage}

            <i class="bi bi-person-circle"></i>  <span style="font-weight: bolder">주최: </span>  ${introItems1.sponsor1}

            <i class="bi bi-shop"></i>  <span style="font-weight: bolder">행사장소: </span> ${introItems1.eventplace}
        </div>





    </c:forEach>


</section>
<script>
    document.addEventListener("DOMContentLoaded", function() {

// console.log(${items});
        <c:forEach var="items" items="${KEY_EVENTDETAIL}">
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

</body>
</html>
