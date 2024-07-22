<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Login - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href=/css/login_form.css rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="">

    <div class="container" style="margin-top: 200px;">
        <h1 class="text-center my-5 fw-bold">로그인</h1>
        <form action="${pageContext.request.contextPath}/login" method="POST" style="width:40%; margin:0 auto">
            <div class="mb-3">
                <label for="userEmail" class="form-label">이메일:</label>
                <input type="text" name="userEmail" class="form-control" id="userEmail" placeholder="이메일을 입력해주세요.">
            </div>
            <div class="mb-3">
                <label for="userPw" class="form-label">비밀번호:</label>
                <input type="password" name="userPw" class="form-control" id="userPw" placeholder="비밀번호를 입력해주세요.">
            </div>
            <div class="mt-4">
                <button type="submit" class="btn">로그인</button>
            </div>
            <div class="d-flex justify-content-end" style="margin: 1rem 0 8rem;">
                <a class="float-end text-decoration-none small" href="${pageContext.request.contextPath}/user/join_form.jsp"
                   style="color: grey; font-family: 'NanumSquareNeo-Variable';">회원가입</a>
                <p class="mx-2 my-0 small" style="color: grey; font-family: 'NanumSquareNeo-Variable';">|</p>
                <a class="float-start text-decoration-none small" href="#" style="color: grey; font-family: 'NanumSquareNeo-Variable';">비밀번호 찾기</a>
            </div>
        </form>
    </div>
       <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
