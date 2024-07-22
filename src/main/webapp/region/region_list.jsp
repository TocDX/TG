<%@ page import="com.tg.vo.AreaBasedListVO" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>region</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        .card-body {
            text-align: center;
            height: 60px;
        }
    </style>
</head>
<body data-page-type="region">
<%@ include file="../common/header.jsp"%>


<div class="d-flex container-xxl" style="margin-top:80px; justify-content: space-around; border-radius: 10px">
    <div class="card" style="width: 10rem;">
        <a href="javascript:void(0);" onclick="loadRegion('seoul');">
            <img style="height: 100px" src="https://img.freepik.com/premium-vector/seoul-flat-cartoon-style-illustration-of-web-background_198565-46.jpg" class="card-img-top" alt="...">
            <div class="card-body" style="height: 10px; text-align: center">
                <p class="card-text" style="margin-top: -11px">서울</p>
            </div>
        </a>
    </div>
    <div class="card" style="width: 10rem;">
        <a href="javascript:void(0);" onclick="loadRegion('daejeon');">
            <img style="height: 100px" src="https://img.freepik.com/free-vector/city-skyline-landmarks-illustration_23-2148810179.jpg?t=st=1721271643~exp=1721275243~hmac=429dec506f60396f50b36ce325007602f75c643fded3a95534a49559a66d66c7&w=1380" class="card-img-top" alt="...">
            <div class="card-body" style="height: 10px; text-align: center">
                <p class="card-text" style="margin-top: -11px">대전</p>
            </div>
        </a>
    </div>
    <div class="card" style="width: 10rem;">
        <a href="javascript:void(0);" onclick="loadRegion('daegu');">
            <img style="height: 100px" src="https://cdn.crowdpic.net/detail-thumb/thumb_d_803E7B31A41E91B3EAC186B59FE6440B.jpg" class="card-img-top" alt="...">
            <div class="card-body" style="height: 10px; text-align: center">
                <p class="card-text" style="margin-top: -11px">대구</p>
            </div>
        </a>
    </div>
    <div class="card" style="width: 10rem;">
        <a href="javascript:void(0);" onclick="loadRegion('busan');">
            <img style="height: 100px" src="https://image.utoimage.com/preview/cp910604/2020/05/202005086877_500.jpg" class="card-img-top" alt="...">
            <div class="card-body" style="height: 10px; text-align: center">
                <p class="card-text" style="margin-top: -11px">부산</p>
            </div>
        </a>
    </div>
</div>
<main>

    <div id="regionListContainer" class="d-flex container-xxl" style="margin-top: 80px; justify-content: space-around; border-radius: 10px; flex-wrap: wrap;">
        <!-- Initial content loaded on page load -->

    </div>

    <a href="#" data-page="1">1</a>
    <a href="#" data-page="2">2</a>
    <a href="#" data-page="3">3</a>
    <div class="d-flex" style="justify-content: center">
        ${KEY_PAGEING_HTML1}
    </div>
    <div class="d-flex" style="justify-content: center" id="pagingContainer">

    </div>
</main>
<%@ include file="../common/footer.jsp"%>

</script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    function loadRegion(region, page) {
        $.ajax({
            url: '${pageContext.request.contextPath}/region_data',
            type: 'GET',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            data: {
                region: region,
                currentPage: page
            },
            success: function(response) {
                console.log("Data received:", response);  // 받은 데이터 콘솔에 출력

                var listContainer = $('#regionListContainer');
                listContainer.empty();  // 기존 내용을 비우고 새로 추가

                if (response.length > 0) {
                    $.each(response, function(index, item) {
                        var cardHtml = '' +
                            '<div class="card mb-3" style="width: 20rem; margin-bottom: 15px;">' +
                            '<a href="${pageContext.request.contextPath}/region_detail?contentid=' + item.contentid + '">' +
                            '<img style="height: 200px" src="' + item.firstimage + '" class="card-img-top" alt="...">' +
                            '<div class="card-body" style="text-align: center;">' +
                            '<p class="card-text">' + item.title + '</p>' +
                            '</div>' +
                            '</a>' +
                            '</div>';
                        console.log("Card HTML:", cardHtml);  // 각 카드의 HTML 콘솔에 출력
                        listContainer.append(cardHtml);
                    });

                    $('#pagingContainer').html(response.pageHtml);
                    console.log("Paging HTML:", response.pageHtml);  // 페이지네이션 HTML 콘솔에 출력

                    // 페이지 링크에 클릭 이벤트 추가
                    $('#pagingContainer a').click(function(e) {
                        e.preventDefault();
                        var page = $(this).data('page');
                        console.log("Page clicked:", page);  // 클릭한 페이지 번호 콘솔에 출력
                        loadRegion(region, page);
                    });
                } else {
                    listContainer.append('<p>No data available for this region.</p>');
                }
            },
            error: function() {
                alert('Failed to load region data.');
            }
        });
    }

    $(document).ready(function() {
        loadRegion('seoul', 1);  // 페이지 로드 시 서울 지역 데이터를 로드
    });


</script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"
></script>

</body>
</html>
