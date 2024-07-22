<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>index</title>
</head>
<body>
<%@ include file="common/header.jsp"%>
<section>
	<div id="carouselExampleIndicators" class="carousel slide container-xxl" style=" margin-top:20px;width: 1600px; border-radius: 10px">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="https://marketplace.canva.com/EAGFYJIvEfk/1/0/1600w/canva-%ED%95%98%EB%8A%98%EC%83%89-%EC%8B%AC%ED%94%8C-%EC%97%AC%ED%96%89-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-%EA%B2%8C%EC%8B%9C%EB%AC%BC-FUiPjSNrgVM.jpg"  class="d-block w-100" alt="..." style="height: 500px">
			</div>
			<div class="carousel-item">
				<img src="https://marketplace.canva.com/EAGHSO2N0HM/1/0/1600w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EB%AF%BC%ED%8A%B8%EC%83%89-%EC%97%AC%EB%A6%84-%EB%B0%94%EB%8B%A4-%EC%97%AC%ED%96%89-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-%ED%8F%AC%EC%8A%A4%ED%8A%B8-9rUt6crmX8Q.jpg"  style="height: 500px" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="https://marketplace.canva.com/EAF9Duo4AXE/1/0/1600w/canva-%ED%8C%8C%EB%9E%80%EC%83%89-%EC%A2%85%EC%9D%B4%EC%A7%88%EA%B0%90-%EC%97%AC%ED%96%89%EC%A7%80-%EC%B6%94%EC%B2%9C-%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-%EA%B2%8C%EC%8B%9C%EB%AC%BC-1ccS-UL_XSQ.jpg" style="height: 500px" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next"  type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
</section>
<br>
<main>
	<div class="container-xxl shadow" >
		<ul class="d-flex" style="justify-content: space-evenly; gap: 30px; background-color: #567FF2; height: 50px; border-radius: 10px; align-items: center">
			<li><a href="javascript:void(0);" onclick="loadRegion('seoul');" style="color:white; font-size: 18px">지역</a></li>
			<div class="vr d-flex" style="color: white;height: 10px; margin-top: 17px;"></div>
			<li><a href="javascript:void(0);" onclick="loadCourse('course');" id="loadCourses" style="color:white; font-size: 18px">코스추천</a></li>
			<div class="vr d-flex" style="color: white;height: 10px; margin-top: 17px;"></div>
			<li><a href="javascript:void(0);" onclick="loadTravel('festival');" id="loadTravelInfo" style="color:white; font-size: 18px">여행정보</a></li>
		</ul>
	</div>

	<div id="regionListContainer" class="d-flex container-xxl" style="margin-top: 80px; justify-content: space-around; border-radius: 10px; flex-wrap: wrap;">
		<!-- Initial content loaded on page load -->

	</div>

	<div class="container-xxl d-flex" style="justify-content: end" >
		<p><a >더보기</a></p>
	</div>
</main>


<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"
></script>
<%@ include file="common/footer.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function loadCourse(course) {


		$.ajax({
			url: '${pageContext.request.contextPath}/course_data',  // 컨텍스트 경로를 포함한 URL
			type: 'GET',
			data: {
				course: course
			},
			success: function(data) {
				console.log("Data received:", data);
				var listContainer = $('#regionListContainer');
				listContainer.empty();

				if (data.length > 0) {
					$.each(data, function(index, item) {
						var cardHtml = '' +
								'<div class="card mb-3" style="width: 20rem; margin-bottom: 15px;">' +
								'<a href="/board_detail?seq=' + item.seq + '">' +
								'<img style="height: 200px" src="' + item.firstimage + '" class="card-img-top" alt="...">' +
								'<div class="card-body" style="text-align: center;">' +
								'<p class="card-text">' + item.title + '</p>' +
								'</div>' +
								'</a>' +
								'</div>';
						listContainer.append(cardHtml);
					});
				} else {
					listContainer.append('<p>No data available for this course.</p>');
				}
			},
			error: function(xhr, status, error) {
				console.error("AJAX error:", status, error);
				alert('Failed to load course data.');
			}
		});
	}
	function loadTravel(festival) {
		$.ajax({
			url: '${pageContext.request.contextPath}/travel_data',  // 컨텍스트 경로를 포함한 URL
			type: 'GET',
			data: {
				festival: festival
			},
			success: function(data) {
				console.log("Data received:", data);
				var listContainer = $('#regionListContainer');
				listContainer.empty();

				if (data.length > 0) {
					$.each(data, function(index, item) {
						var cardHtml = '' +
								'<div class="card mb-3" style="width: 20rem; margin-bottom: 15px;">' +
								'<a href="/festival_detail?contentid=' + item.contentid + '">' +
								'<img style="height: 200px" src="' + item.firstimage + '" class="card-img-top" alt="...">' +
								'<div class="card-body" style="text-align: center;">' +
								'<p class="card-text">' + item.title + '</p>' +
								'</div>' +
								'</a>' +
								'</div>';
						listContainer.append(cardHtml);
					});
				} else {
					listContainer.append('<p>No data available for this festival.</p>');
				}
			},
			error: function(xhr, status, error) {
				console.error("AJAX error:", status, error);
				alert('Failed to load travel data.');
			}
		});
	}
	function loadRegion(region) {
		$.ajax({
			url: '${pageContext.request.contextPath}/region_data',
			type: 'GET',
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			data: {
				region: region
			},
			success: function(data) {
				console.log("Data received:", data);  // 받은 데이터 콘솔에 출력

				var listContainer = $('#regionListContainer');
				listContainer.empty();  // 기존 내용을 비우고 새로 추가

				if (data.length > 0) {
					$.each(data, function(index, item) {
						var cardHtml = '' +
								'<div class="card mb-3" style="width: 20rem; margin-bottom: 15px;">' +
								'<a href="${pageContext.request.contextPath}/region_detail?contentid=' + item.contentid + '">' +
								'<img style="height: 200px" src="' + item.firstimage + '" class="card-img-top" alt="...">' +
								'<div class="card-body" style="text-align: center;">' +
								'<p class="card-text">' + item.title + '</p>' +
								'</div>' +
								'</a>' +
								'</div>'
						;
						console.log("Card HTML:", cardHtml);  // 각 카드의 HTML 콘솔에 출력
						listContainer.append(cardHtml);
					});
					$('#loadMoreLink').show();
				} else {
					listContainer.append('<p>No data available for this region.</p>');
					// 더보기 링크를 숨깁니다.
					$('#loadMoreLink').hide();
				}
			},
			error: function() {
				alert('Failed to load region data.');
			}
		});
	}

	$(document).ready(function() {
		loadRegion('seoul');  // 페이지 로드 시 서울 지역 데이터를 로드
	});

</script>
</body>
</html>
