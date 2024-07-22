<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Register - SB Admin</title>
        <link href="/css/join.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body >
    <div class="container-xxl" style="margin-top: 120px;">
        <h1 class="fw-bold">회원가입</h1>
        <hr>
        <form method="post" action="${pageContext.request.contextPath}/user_insert" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="userEmail" class="form-label">이메일</label>
                <input type="text" name="userEmail" class="form-control" id="userEmail" placeholder="이메일을 입력해주세요.">
            </div>
            <div class="mb-3">
                <label for="userPw" class="form-label">비밀번호</label>
                <input type="password" name="userPw" class="form-control" id="userPw" placeholder="비밀번호를 입력해주세요.">
            </div>
            <div class="mb-3">
                <label for="userName" class="form-label">닉네임</label>
                <input type="text" name="userName" class="form-control" id="userName" placeholder="닉네임을 입력해주세요.">
            </div>
            <div class="mb-3">
                <label for="userPhone" class="form-label">휴대폰번호</label>
                <input type="text" name="userPhone" class="form-control" id="userPhone" placeholder="휴대폰번호를 입력해주세요.">
            </div>
            <div class="mb-3">
                <label for="ufile" class="form-label">프로필 이미지</label>
                <input type="file" name="ufile" class="form-control" id="ufile" onchange="previewImage(event)">
                <img id="preview" src="#" alt="미리보기" style="display: none;">
            </div>
            <button type="submit" class="btn btn-primary">회원가입</button>
        </form>
    </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('preview');
            const reader = new FileReader();

            if (file) {
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            } else {
                preview.src = '#';
                preview.style.display = 'none';
            }
        }
    </script>
    </body>
</html>
