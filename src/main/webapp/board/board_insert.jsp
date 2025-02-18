<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- ########################  지도 밑에 이미지 여픙로 보이게 하려면 반드시 필요  ######################## -->
<style>
     .inline-block {
         display: inline-block;
         vertical-align: top; /* 필요시 요소들을 세로로 정렬 */
         margin-right: 10px; /* 오른쪽에 여백 추가 */
         margin-top: 20px; /* 오른쪽에 여백 추가 */
     }
</style>

</head>
<body>


<form  class="container-xxl" style="margin-left: 600px; margin-top: 300px;" action="${pageContext.request.contextPath}/board_insert" method="post" id="boardForm" enctype="multipart/form-data">
	<div class="col-md-6 container-xxl">
        <label for="inputTitle" class="form-label">제목</label>
        <input type="text" class="form-control" id="title" name="title">
    </div>
    <div class="col-md-6">
        <label for="textarea" class="form-label">내용</label>
        <textarea name="contents" id="contents" class="form-control" id="textarea"></textarea>
    </div>
    <div class="col-md-6 container-xxl">
        <label for="inputTitle" class="form-label">글쓴이</label>
        <c:if test="${not empty sessionScope.SESS_USER_EMAIL}">
        	${sessionScope.SESS_USER_EMAIL}
        </c:if>
    </div>
    <div class="col-12">
        <button type="button" id="saveButton"  class="btn btn-primary">글쓰기</button>
    </div>
</form>


<!-- ########################  카카오 지도 보여지는 부분  ######################## -->
<div id="map" style="margin-left: 600px; width:540px;height:400px;"></div>

<div id="clickSpotImg" style="margin-left: 600px; width:540px;height:400px;"></div> 


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- ------------------------------------ 카카오 지도 거리 계산 스크립트 ---------------------------------- -->
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=3a3bc4bd8b50e62eea65aae69c1fb564"></script>	
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>



<script>
var maxCoordinates = 6; // 최대 좌표 개수
var coordinatesCount = 0; // 현재 좌표 개수



var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(37.5665, 126.9780), // 지도의 중심좌표 - 서울
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	
	 coordinatesCount += 1;
	 // 좌표 개수가 최대치를 초과하면 클릭 이벤트를 무시합니다
	   if (coordinatesCount >= maxCoordinates) {
	       alert("최대 5개의 좌표만 등록할 수 있습니다. 우클릭하시면 총 거리 계산을 보실 수 있습니다.");
	       return;
	   }
	   
	 
	// 마우스로 클릭한 위치입니다 
    var clickPosition = mouseEvent.latLng;

    // 클릭한 위치의 위도와 경도 값을 표시합니다
    displayLatLng(clickPosition);

    // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
    if (!drawingFlag) {

        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
        drawingFlag = true;
        
        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
        deleteClickLine();
        
        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
        deleteDistnce();

        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
        deleteCircleDot();
    
        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
        clickLine = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
        
        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
        moveLine = new kakao.maps.Polyline({
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다    
        });
    
        // 클릭한 지점에 대한 정보를 지도에 표시합니다
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면

        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();

        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);

        var distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition, distance);
    }
    

   
	 
});
    
// 지도에 마우스무브 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

    // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag){
        
        // 마우스 커서의 현재 위치를 얻어옵니다 
        var mousePosition = mouseEvent.latLng; 

        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
        
        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
        var movepath = [path[path.length-1], mousePosition];
        moveLine.setPath(movepath);    
        moveLine.setMap(map);
        
        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
        
        // 거리정보를 지도에 표시합니다
        showDistance(content, mousePosition);   
    }             
});                 

// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

    // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag) {
        
        // 마우스무브로 그려진 선은 지도에서 제거합니다
        moveLine.setMap(null);
        moveLine = null;  
        
        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
    
        // 선을 구성하는 좌표의 개수가 2개 이상이면
        if (path.length > 1) {

            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
            if (dots[dots.length-1].distance) {
                dots[dots.length-1].distance.setMap(null);
                dots[dots.length-1].distance = null;    
            }

            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
                
            // 그려진 선의 거리정보를 지도에 표시합니다
            showDistance(content, path[path.length-1]);  
             
        } else {

            // 선을 구성하는 좌표의 개수가 1개 이하이면 
            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
            deleteClickLine();
            deleteCircleDot(); 
            deleteDistnce();

        }
        
        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
        drawingFlag = false;          
    }  
});    

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
function showDistance(content, position) {
    
    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
        
        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
        
    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
        
        // 커스텀 오버레이를 생성하고 지도에 표시합니다
        distanceOverlay = new kakao.maps.CustomOverlay({
            map: map, // 커스텀오버레이를 표시할 지도입니다
            content: content,  // 커스텀오버레이에 표시할 내용입니다
            position: position, // 커스텀오버레이를 표시할 위치입니다.
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3  
        });      
    }
}

// 그려지고 있는 선의 총거리 정보와 
// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
function displayCircleDot(position, distance) {

    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new kakao.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position: position,
        zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);

    if (distance > 0) {
        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
        var distanceOverlay = new kakao.maps.CustomOverlay({
            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
            position: position,
            yAnchor: 1,
            zIndex: 2
        });

        // 지도에 표시합니다
        distanceOverlay.setMap(map);
    }

    // 배열에 추가합니다
    dots.push({circle:circleOverlay, distance: distanceOverlay});
}

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
function deleteCircleDot() {
    var i;

    for ( i = 0; i < dots.length; i++ ){
        if (dots[i].circle) { 
            dots[i].circle.setMap(null);
        }

        if (dots[i].distance) {
            dots[i].distance.setMap(null);
        }
    }

    dots = [];
}

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
    var walkkTime = distance / 67 | 0;
    var walkHour = '', walkMin = '';

    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
    if (walkkTime > 60) {
        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
    }
    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
    var bycicleTime = distance / 227 | 0;
    var bycicleHour = '', bycicleMin = '';

    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
    if (bycicleTime > 60) {
        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
    }
    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="dotOverlay distanceInfo">';
    content += '    <li>';
    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">도보</span>' + walkHour + walkMin;
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
    content += '    </li>';
    content += '</ul>'

    return content;
}

// 클릭한 위치의 위도와 경도를 표시하는 함수입니다
function displayLatLng(latlng) {
        var lat = latlng.getLat();
        var lng = latlng.getLng();
        var resultDiv = document.getElementById('clickSpotImg');

        // 기존에 등록된 좌표 수가 5개를 초과하면 첫 번째 좌표를 삭제합니다
        if (coordinatesCount >= maxCoordinates) {
        	//resultDiv.removeChild(resultDiv.children[0]);
        	alert("최대 5개의 좌표만 등록할 수 있습니다.");
            return;
        }
        
        
	
   
      	//------------------------------------------------------------------------------
    	//카카오맵에서 클릭한 위경도 좌표와 관련된 서브이미지 1개 가져오기 
    	//------------------------------------------------------------------------------
		//var formData = $("#replyInsertForm").serialize();
		$.ajax({
			method      : "POST",
	        url         : "${pageContext.request.contextPath}/search_subimg_by_kakao",
	        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	        data 		: "lat="+lat+"&lng="+lng,
	        error 	    : function(myval){ console.log("에러:" + myval);   },
	  		success     : function(itemVO){ 
	  										console.log("성공:" + itemVO.mapx);
	  										console.log("성공:" + itemVO.mapy);
	  										console.log("성공:" + itemVO.firstimage);
	  										
	  										// 새 좌표를 등록합니다
	  								        var coordDiv = document.createElement('div');
	  								      	coordDiv.className = 'inline-block'; // 클래스 이름 설정
	  								        coordDiv.innerHTML += "<img src='"+ itemVO.firstimage +"' width=100 height=100>";
	  								        resultDiv.appendChild(coordDiv);
	  								        
	  								        
	  								   		// Create hidden input element for the image URL
	  								        var hiddenInput = document.createElement('input');
	  								        hiddenInput.type = 'hidden';
	  								        hiddenInput.name = 'ufiles'; // Use an array to store multiple images
	  								        hiddenInput.value = itemVO.firstimage;
	  								    
	  								        // Append hidden input to the form
	  								        var form = $("#boardForm");
	  								        form.append(hiddenInput);
   
	  									}
		}); //e.o.ajax */ 
		
    }
</script>


<script>
<!-- 게시판 저장 버튼 클릭 시 카카오 지도를 이미지로 변환 -->
$(function() {
	$(document).on("click", "#saveButton",  function(event){
		event.preventDefault(); 		//페이지이동 막기 ==  href='#'
		// 지도 캡처 함수
	    html2canvas(mapContainer).then(function(canvas) {
	        var imgData = canvas.toDataURL("image/png");
	        var imgElement = document.getElementById('mapImage');
	        alert(imgData);
	        
	        // AJAX 요청을 통해 서버에 이미지 데이터 전송
            var form = document.getElementById('boardForm');
            var formData = new FormData(form);
            
            
            var serializedData = $(form).serialize();
            console.log(serializedData);
            
            var params = new URLSearchParams(serializedData);
			params.getAll('ufiles').forEach(function(url) {
			    formData.append('ufiles', new File([""], url));
			});
            
            
         	// 카카오 지도 맵 이미지 
            formData.append('imageData', imgData);
            var fileInput = document.getElementById('fileInput');
            if (fileInput) {
                for (var i = 0; i < fileInput.files.length; i++) {
                    formData.append('ufiles', fileInput.files[i]);
                }
            }
			            
            $.ajax({
                url: '/board_insert',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    //alert('Image saved successfully: ' + response.fileName);
                    location.href="/board_list";
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('Failed to save image: ' + textStatus);
                }
            });
	     
		});
	});
});		
</script>
    
    

</body>
</html>