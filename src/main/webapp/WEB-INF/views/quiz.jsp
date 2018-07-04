<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<input type="button" id="quizStart" onclick="nextQuiz()" value="퀴즈풀기"> 
	<input type="button" onclick="nextQuiz()" value="다음문제"> 
</body>
<script>
var
var 

$(document).ready(function() {
	$.ajax({
		"url" : "./cleanQuiz",
		"type" : "get",
		"success" : function(data) {
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
});

$("#quizStart").click(function() {
	alert("퀴즈 시작!");
})

function nextQuiz() {
	$.ajax({
		"url" : "./nextQuiz",
		"type" : "get",
		"success" : function(data) {
			if(!data){
				console.log("문제 끝!");
				alert("문제가 끝났습니다!");
			}
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}
</script>
</html>