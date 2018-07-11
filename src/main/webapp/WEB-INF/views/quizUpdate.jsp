<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style>
textarea {
	resize: none;
}
</style>
</head>
<body>
	<h1>퀴즈 수정</h1>
	<table>
		<form id="update" action="quizUpdate">
			<tr>
				<td colspan="2">
					<select id="aniamlList"  name="aniamlList">
						<option value="강아지">강아지</option>
						<option value="건강">고양이</option>
						<option value="기타">기타</option>
					</select>
					<select id="category" name="category">
						<option value="건강">건강</option>
						<option value="음식">음식</option>
						<option value="습성">습성</option>
						<option value="생활">생활</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>문제</td>
				<td>
					<input type="hidden" name="quiz_idx" value="${dto.quiz_idx}">
					<textarea id="ask" name="ask" rows="10" cols="5">${dto.quiz_ask}</textarea>
				</td>
			</tr>
			<tr>
				<td>정답</td>
				<td>
					<div id="quizAnswerDiv">
						<input type="radio" name="answer" value="O">O 
						<input type="radio" name="answer" value="X">X
					</div>
				</td>
			</tr>
			<tr>
				<td>해설</td>
				<td><textarea id="content" name="content" rows="10" cols="5">${dto.quiz_content}</textarea></td>
			</tr>
		</form>
	</table>
	<input type="button" onclick="update()" id="updateBtn" value="저장">
	<input type="button" onclick="location.href='./quizDetailPage?idx=${dto.quiz_idx}'" value="취소">

</body>
<script>
	$(document).ready(function() {
		$("input[value='${dto.quiz_answer}']").attr("checked", true);
	});
	
	function update() {
		$("#update").submit();
	}

</script>
</html>