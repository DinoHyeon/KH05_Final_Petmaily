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
			<td>문제</td>
			<td><textarea id="ask" rows="10" cols="5" readonly="readonly">${dto.quiz_ask}</textarea></td>
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
			<td><textarea id="content" rows="10" cols="5"
					readonly="readonly">${dto.quiz_content}</textarea></td>
		</tr>
	</table>
	<button id="updateFormBtn" onclick="updateForm()">수정</button>
	<button id="updateBtn" onclick="update()" style="display: none">저장</button>
	<button>리스트</button>
</body>
<script>
	$(document).ready(function() {
		console.log($("input[value='${dto.quiz_answer}']"));
		//$("input[name='answer").not('input[value="${dto.quiz_answer}"]').attr("disabled",true);
		$("input[value='${dto.quiz_answer}']").attr("checked",true);
		$("input[name='answer']").attr("disabled",true);
	});

	function updateForm() {
		$("#updateFormBtn").css("display", "none");
		$("#updateBtn").css("display", "inline");
		$("#ask").removeAttr("readonly");
		$("input[name='answer").removeAttr("disabled");
		$("#content").removeAttr("readonly");
	}
	
	function update() {
		$("input[name='answer").not('input[value="${dto.quiz_answer}"]').attr("disabled",true);
		$("#ask").attr("readonly",true);
		$("#content").attr("readonly",true);
	}
</script>
</html>