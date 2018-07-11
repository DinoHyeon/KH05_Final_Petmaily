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
	<h1>퀴즈 상세보기</h1>
	<table>
		<tr>
			<td>동물</td>
			<td>${dto.animal_idx}</td>
			<td>주제</td>
			<td>${dto.quiz_category}</td>
		</tr>
		<tr>
			<td>문제</td>
			<td colspan="3"><textarea id="ask" rows="10" cols="5" readonly="readonly">${dto.quiz_ask}</textarea></td>
		</tr>
		<tr>
			<td>정답</td>
			<td colspan="3">
				<div id="quizAnswerDiv">
					<input type="radio" name="answer" value="O">O <input
						type="radio" name="answer" value="X">X
				</div>
			</td>
		</tr>
		<tr>
			<td>해설</td>
			<td colspan="3">
				<textarea id="content" rows="10" cols="5" readonly="readonly">${dto.quiz_content}
				</textarea>
			</td>
		</tr>
	</table>
	<button id="updateFormBtn" onclick="location.href='./quizUpdatePage?idx=${dto.quiz_idx}'">수정</button>
	<button id="deleteBtn" onclick="del()">삭제</button>
	<button onclick="location.href='./quizMain'">리스트</button>
</body>
<script>
	$(document).ready(function() {
		//$("input[name='answer").not('input[value="${dto.quiz_answer}"]').attr("disabled",true);
		$("input[value='${dto.quiz_answer}']").attr("checked",true);
		$("input[name='answer']").attr("disabled",true);
	});
	
	function del() {
		var del = confirm("해당 문제를 삭제하시겠습니까?");
		
		if(del){
			location.href='./quizDelete?idx=${dto.quiz_idx}'
		}
	}
</script>
</html>