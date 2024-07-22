<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="../resources/template.css"  />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
  </head>
  <body>
    <nav class="navbar navbar-expand-lg  shadow" style="background-color:white; ">
      <div class="container-xxl">
        <a class="navbar-brand" href="#" style="color: black;">Navbar</a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0" >
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="/index" style="color: black;">홈</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/region_list" style="color: black;">지역</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/board_list"style="color: black;">코스추천</a>
            </li>
            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
                style="color: black;"
              >
                여행정보
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/festival_list" style="color: black;">축제</a></li>

                <li><hr class="dropdown-divider" /></li>
                <li>
                  <a class="dropdown-item" href="/event_list" style="color: black;">공연/행사</a>
                </li>
              </ul>
            <li class="nav-item">
              <a class="nav-link" href="#"style="color: black;">여행지도</a>
            </li>
            </li>
          </ul>
          <form action="${pageContext.request.contextPath}/search" method="get">
            <input type="text" name="keyword" placeholder="Enter search keyword"/>
            <button type="submit">Search</button>
          </form>
          <c:choose >
            <c:when test="${not empty sessionScope.SESS_USER_EMAIL}">
              <!-- 로그인 상태일 때 -->
              <div style="margin: 20px;"> <a href="${pageContext.request.contextPath}/user_detail?userSeq=${sessionScope.SESS_USER_SEQ}">${sessionScope.SESS_USER_EMAIL} </a>님 안녕하세요 </div>
            </c:when>
            <c:otherwise>
              <!-- 비로그인 상태일 때 -->
              <ul class="navbar-nav mb-5 mb-lg-0">
                <li class="nav-item">
                  <a href="user/login_form.jsp" class="nav-item" style="margin: 10px"
                  ><svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                  </svg></a
                  >
                </li>
              </ul>
            </c:otherwise>
          </c:choose>


        </div>
      </div>
    </nav>


    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
