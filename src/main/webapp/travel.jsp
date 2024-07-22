<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>키워드로 장소 검색하고 목록으로 표출하기</title>
    <style>
        .map_wrap {position:relative; width:100%; height:350px; overflow:hidden;}
        #map {width:80%; height:100%; float:left;}
        #searchWrap {margin: 10px; padding: 10px; background: #f1f1f1; border-radius: 5px; clear: both;}
        #searchInput {width: 200px; padding: 5px; border: 1px solid #ccc; border-radius: 3px; margin-right: 10px;}
        #searchButton {padding: 5px 10px; border: none; background: #007bff; color: white; border-radius: 3px; cursor: pointer;}
        #searchButton:hover {background: #0056b3;}
        #category {margin-top: 10px; border-radius: 5px; border:1px solid #909090; background: #fff; overflow: hidden; z-index: 2;}
        #category li {float:left; list-style: none; width:50px; border-right:1px solid #acacac; padding:6px 0; text-align: center; cursor: pointer;}
        #category li.on {background: #eee;}
        #category li:hover {background: #ffe6e6;}
        #category li:last-child{border-right:0;}
        #category li span {display: block; margin:0 auto 3px; width:27px; height: 28px;}
        #category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
        #category li .bank {background-position: -10px 0;}
        #category li .mart {background-position: -10px -36px;}
        #category li .pharmacy {background-position: -10px -72px;}
        #category li .oil {background-position: -10px -108px;}
        #category li .cafe {background-position: -10px -144px;}
        #category li .store {background-position: -10px -180px;}
        #category li.on .category_bg {background-position-x:-46px;}
        #placesList {list-style:none; padding:0; margin:0; max-height: 200px; overflow-y: auto; position:absolute; right:10px; top:60px; width:250px; background:white; border:1px solid #ccc;}
        #placesList li {padding:10px; border-bottom:1px solid #ddd; cursor:pointer;}
        #placesList li:hover {background:#f0f0f0;}
    </style>
</head>
<body>
<div id="searchWrap">
    <input id="searchInput" type="text" placeholder="장소를 검색하세요"/>
    <button id="searchButton">검색</button>
    <ul id="category">
        <li id="BK9" data-order="0"><span class="category_bg bank"></span>은행</li>
        <li id="MT1" data-order="1"><span class="category_bg mart"></span>마트</li>
        <li id="PM9" data-order="2"><span class="category_bg pharmacy"></span>약국</li>
        <li id="OL7" data-order="3"><span class="category_bg oil"></span>주유소</li>
        <li id="CE7" data-order="4"><span class="category_bg cafe"></span>카페</li>
        <li id="CS2" data-order="5"><span class="category_bg store"></span>편의점</li>
    </ul>
</div>
<div class="map_wrap">
    <div id="map"></div>
    <ul id="placesList"></ul>
</div>

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ac58ace84bf2ce71079d32d9e4d4931b&libraries=clusterer,services"></script>
<script>
    var map, clusterer, placeOverlay, contentNode, markers = [], currCategory = '', placesList;

    document.addEventListener('DOMContentLoaded', function() {
        initializeMap();
        addCategoryClickEvent();
        addSearchEvent();
        placesList = document.getElementById('placesList');
    });

    function initializeMap() {
        map = new kakao.maps.Map(document.getElementById('map'), {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 5
        });

        clusterer = new kakao.maps.MarkerClusterer({
            map: map,
            averageCenter: true,
            minLevel: 10
        });

        placeOverlay = new kakao.maps.CustomOverlay({zIndex:1});
        contentNode = document.createElement('div');
        contentNode.className = 'placeinfo_wrap';
        placeOverlay.setContent(contentNode);

        searchPlaces();  // 기본 카테고리 검색
    }

    function addCategoryClickEvent() {
        var category = document.getElementById('category');
        var categories = category.querySelectorAll('li');

        categories.forEach(function(category) {
            category.addEventListener('click', function() {
                var id = this.id;
                currCategory = id;
                searchPlaces();
                var current = category.querySelector('.on');
                if (current) {
                    current.classList.remove('on');
                }
                this.classList.add('on');
            });
        });
    }

    function addSearchEvent() {
        var searchButton = document.getElementById('searchButton');
        searchButton.addEventListener('click', function() {
            var keyword = document.getElementById('searchInput').value;
            if (keyword) {
                searchKeywordPlaces(keyword);
            }
        });
    }

    function searchKeywordPlaces(keyword) {
        placeOverlay.setMap(null);
        removeMarker();
        placesList.innerHTML = '';  // 검색 리스트 초기화
        var ps = new kakao.maps.services.Places(map);
        ps.keywordSearch(keyword, placesSearchCB, {useMapBounds:true});
    }

    function searchPlaces() {
        if (!currCategory) {
            return;
        }
        placeOverlay.setMap(null);
        removeMarker();
        placesList.innerHTML = '';  // 검색 리스트 초기화
        var ps = new kakao.maps.services.Places(map);
        ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true});
    }

    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            var newMarkers = data.map(function(place) {
                return new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(place.y, place.x)
                });
            });
            clusterer.addMarkers(newMarkers);
            showPlaceInfo(data);
            displayPlacesList(data);
        }
    }

    function displayPlacesList(places) {
        places.forEach(function(place, index) {
            var item = document.createElement('li');
            item.textContent = place.place_name;
            item.addEventListener('click', function() {
                var marker = markers[index];
                map.setCenter(marker.getPosition());
                placeOverlay.setPosition(marker.getPosition());
                contentNode.querySelector('.title').innerText = place.place_name;
                contentNode.querySelector('.tel').innerText = place.phone;
                contentNode.querySelector('.jibun').innerText = place.road_address_name || place.address_name;
                placeOverlay.setMap(map);
            });
            placesList.appendChild(item);
        });
    }

    function showPlaceInfo(places) {
        contentNode.innerHTML = '';
        var list = document.createElement('ul');
        contentNode.appendChild(list);

        places.forEach(function(place, index) {
            var item = document.createElement('li');
            var title = document.createElement('span');
            title.className = 'title';
            title.innerHTML = place.place_name;
            item.appendChild(title);
            var tel = document.createElement('span');
            tel.className = 'tel';
            tel.innerHTML = place.phone;
            item.appendChild(tel);
            var address = document.createElement('span');
            address.className = 'jibun';
            address.innerHTML = place.road_address_name || place.address_name;
            item.appendChild(address);
            list.appendChild(item);
        });
    }

    function removeMarker() {
        clusterer.clear();
    }
</script>
</body>
</html>
