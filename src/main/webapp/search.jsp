<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Search Results</title>
</head>
<body>
<h2>Search Results</h2>

<h3>Contents</h3>
<c:if test="${not empty result.content}">
    <ul>
        <c:forEach var="content" items="${result.content}">
            <li>${content.title}: ${content.content}</li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty result.content}">
    <p>No content found.</p>
</c:if>

<h3>Festivals</h3>
<c:if test="${not empty result.festival}">
    <ul>
        <c:forEach var="festival" items="${result.festival}">
            <li>${festival.title}: ${festival.content}</li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty result.festival}">
    <p>No festivals found.</p>
</c:if>

<h3>Boards</h3>
<c:if test="${not empty result.board}">
    <ul>
        <c:forEach var="board" items="${result.board}">
            <li>${board.title}: ${board.content}</li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty result.board}">
    <p>No boards found.</p>
</c:if>
</body>
</html>
