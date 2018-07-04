<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">
#animalChoice{
	position: absolute;
	left: 10%;
	top: 5%;
	width: 10%;
	height: 20%;
}
.animal{
	width: 10%;
	height: 10%;
	background-color: gray;
}

.animalImg{
	width: 10%;
	height: 20%;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
	<form action="quizPlaySetting" id="quizPlaySetting">
	<div id="animalChoice">
		<input type="hidden" name="animal">
		<div class="animal" id="강아지">
			<img class="animalImg" alt="강아지" src="resources/img/dog.png">
		</div>
		<div class="animal" id="고양이">
			<img class="animalImg" alt="강아지" src="resources/img/cat.png">
		</div>
		<div class="animal" id="기타">
			<img class="animalImg" alt="강아지" src="resources/img/fish.png">
		</div>
		<div class="animal" id="전체">
			전체
		</div>		
	</div>
	<div id="categoryChoice">
		<input type="radio" value="전체" name="category">전체
		<input type="radio" value="음식" name="category">음식
		<input type="radio" value="습성" name="category">습성
		<input type="radio" value="생활" name="category">생활
		<input type="radio" value="건강" name="category">건강
		<input type="radio" value="기타" name="category">기타
	</div>
	<div id="quizNumChoice">
	 	<input type="radio" value="3" name="quizNum">3
	 	<input type="radio" value="5" name="quizNum">5
	 	<input type="radio" value="10" name="quizNum">10
	</div>		
	
	<input type="button" onclick="quizPlay()" value="문제풀기">
	</form>
</body>
<script>
	var animal;
	$(".animal").click(function() {
		animal=$(this).attr("id");
	});
	
	function quizPlay() {
		$("input[name='animal']").val(animal);
		$("#quizPlaySetting").submit();
	}
</script>
</html>