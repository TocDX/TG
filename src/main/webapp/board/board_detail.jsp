<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Tables - SB Admin</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
<body>
<!-- --------------------------------------- 게시물 상세보기 ------------------------------- -->

<form id="boardForm"  class="container-xxl" style="margin-left: 600px; margin-top: 300px;" action="${pageContext.request.contextPath}/board_insert" method="post"  enctype="multipart/form-data">
<input type="hidden" name="seq" value="${KEY_BOARDVO.seq}">
<input type="hidden" name="userSeq" value="${KEY_BOARDVO.userSeq}">
	
	<div class="col-md-6 container-xxl">
        <label for="inputTitle" class="form-label">글번호</label>
        ${KEY_BOARDVO.seq}
    </div>
    <div class="col-md-6 container-xxl">
        <label for="inputTitle" class="form-label">작성자</label>
        ${KEY_BOARDVO.userSeq}
    </div>
    <div class="col-md-6 container-xxl">
        <label for="inputTitle" class="form-label">작성일</label>
        <input type="text" class="form-control" name="regdate" value="${KEY_BOARDVO.regdate}" readonly>
    </div>
    
	<div class="col-md-6 container-xxl">
        <label for="inputTitle" class="form-label">제목</label>
        <input type="text" class="form-control" name="title" size=60  value="${KEY_BOARDVO.title}">
        
    </div>
    <div class="col-md-6">
        <label for="textarea" class="form-label">내용</label>
        <textarea name="contents" cols="80" class="form-control"  rows="6">${KEY_BOARDVO.contents}</textarea>
    </div>
    <div class="col-md-6">
        <label for="textarea" class="form-label">첨부이미지</label>
        <c:forEach items="${KEY_BOARDVO.files}" var="fvo">
			<img src="/board/imgs/${fvo.oname}" width=100 height=100>  <!--  ################################################## 첨부이미지 사이즈 여기서 조절해요....................... -->
	 	 </c:forEach>
    </div>
    <div class="col-12">
        <input type="button" class="btn btn-primary" id="uptButton" value="수정">
		<input type="button" class="btn btn-primary" id="delButton"  value="삭제">
		<input type="button" class="btn btn-primary" id="listButton" value="목록">
		
    </div>
</form>


<!-- --------------------------------------- 댓글목록 ------------------------------- -->
<br>
<div id="replyListDiv" style="margin-left: 600px;"></div>


<!-- --------------------------------------- 댓글등록 ------------------------------- -->
<br>
<form method="post" id="replyInsertForm"  class="container-xxl" style="margin-left: 600px;" >
<input type=hidden name=seq id="seq" value="${KEY_BOARDVO.seq}">
<table width=100% border=1>
<tr>
	<td>
		<input type="text" size=100 name="reply" id="reply">
		<input type="button"  id="replyInsertBtn" value="댓글등록">
	</td>
</tr>
</table>
</form>


<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
		$(function() {
			//---------------------------------------------------------------------------------------------------------
			//화면 준비되면 댓글목록 바로 가져오기 :::  REST
			function makeTable() {
				$.ajax({
					method      : "POST",
			        url         : "${pageContext.request.contextPath}/reply_list_rest",
			        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			        data 		: "seq=${KEY_BOARDVO.seq}",   
			  		error 	    : function(myval){ console.log("에러:" + myval);   },
			  		success     : function(myval){ 
			  										console.log("성공:" + myval);  //ResponseEntity<>(rlist, HttpStatus.OK)   
			  										
			  										//----------------------------------------
			  										// a href로 삭제 버튼 표현한 경우
			  										//----------------------------------------
			  										//var htmlStr = "<table border=1 width=50%>";
			  										//$.map( myval, function( MYval, MYidx ) {                                    
			  										//	htmlStr += "<tr><td><font color=red><a href='#' class='reply_delete_a' data-seq='"+MYval.seq+"' data-rseq='"+MYval.rseq+ "'>[X]</a></font>" + MYval.reply + "</td></tr>";
			  										//});
			  										//htmlStr += "</table>";
			  										
			  										//----------------------------------------
			  										// form로 삭제 버튼 표현한 경우
			  										//----------------------------------------
			  										var htmlStr = "<form><table border=1 width=50%>";
			  										$.map( myval, function( MYval, MYidx ) {                                    
			  											htmlStr += "<tr><td><input type='button' value='[X]'  class='reply_delete_btn' data-seq='"+MYval.seq+"' data-rseq='"+MYval.rseq+ "'>" + MYval.reply + "</td></tr>";
			  										});
			  										htmlStr += "</table></form>";
			  										
			  										
			  										
			  										$("#replyListDiv").empty();
			  										$("#replyListDiv").html(htmlStr);
			  										
			  									}
				});
			}
			
			//---------------------------------------------------------------------------------------------------------
			//화면이 실행되자마자 댓글목록 가져오기 :: REST
			makeTable();
			
			
			//---------------------------------------------------------------------------------------------------------
			//댓글 입력 :: REST
			$("#replyInsertBtn").click(  function(){
				var formData = $("#replyInsertForm").serialize();
				$.ajax({
					method      : "POST",
			        url         : "${pageContext.request.contextPath}/reply_insert_rest",
			        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			        //data 		: "seq=" +$("#seq").val()+"&reply=" + $("#reply").val(),   
			  		data 		: formData,
			        error 	    : function(myval){ console.log("에러:" + myval);   },
			  		success     : function(myval){ 
			  										console.log("성공:" + myval);  //msg = "입력성공"   
			  										makeTable();
			  									}
				});
			});
			
			//---------------------------------------------------------------------------------------------------------
			//댓글 삭제 :: REST
			//동적으로 엘리먼트가 생성되는 경우 클릭이벤트 
			//  : <a href='#' class='reply_delete_a' data-seq='3' data-rseq='2'>[X]</a> 
			$(document).on("click", ".reply_delete_a",  function(event){
				event.preventDefault(); 		//페이지이동 막기 ==  href='#'
                var seq  = $(this).attr("data-seq");
                var rseq = $(this).data("rseq");    //data-rseq 
                formData = "seq="+seq+"&rseq="+rseq;
				//alert(formData);
				
				$.ajax({
					method      : "POST",
			        url         : "${pageContext.request.contextPath}/reply_delete_rest",
			        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			        data 		: formData,
			        error 	    : function(myval){ console.log("에러:" + myval);   },
			  		success     : function(myval){ 
			  										console.log("성공:" + myval);  //msg = "입력성공"   
			  										makeTable();
			  									}
				});
				
			});
			//---------------------------------------------------------------------------------------------------------
			//댓글 삭제 :: REST
			//동적으로 엘리먼트가 생성되는 경우 클릭이벤트 
			//    : <form><input type='button' class='reply_delete_btn'> 사용할 경우
			$(document).on("click", ".reply_delete_btn",  function(event){
				event.preventDefault(); 		//페이지이동 막기
                var seq  = $(this).attr("data-seq");
                var rseq = $(this).data("rseq");
                formData = "seq="+seq+"&rseq="+rseq;
				//alert(formData);
				
				$.ajax({
					method      : "POST",
			        url         : "${pageContext.request.contextPath}/reply_delete_rest",
			        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			        data 		: formData,
			        error 	    : function(myval){ console.log("에러:" + myval);   },
			  		success     : function(myval){ 
			  										console.log("성공:" + myval);  //msg = "입력성공"   
			  										makeTable();
			  									}
				});
				
			});
			
			
			
			
			//---------------------------------------------------------
			// <form> 제어하기
			//---------------------------------------------------------
			//$(".btn.btn-primary.btn-block").click()~~
			
			$("#uptButton").click(  function(){
				//alert("수정");
				$("#boardForm").attr("method","post");
				$("#boardForm").attr("action","${pageContext.request.contextPath}/board_update");
				$("#boardForm").submit();
				return true;
			});
			$("#delButton").click(  function(){
				//alert("삭제");
				$("#boardForm").attr("method","post");
				$("#boardForm").attr("action","${pageContext.request.contextPath}/board_delete");
				$("#boardForm").submit();
				return true;
			});
			$("#listButton").click(  function(){
				location.href = "${pageContext.request.contextPath}/board_list";
			});            
			
			//------------------------------------------------------------
			
		});
		
	</script>
</body>
</html>


