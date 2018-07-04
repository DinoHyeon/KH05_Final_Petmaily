<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>실종 게시글 작성</title>
<style>
table, tr, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
	margin: auto;
}

th {
	width : 70px;
}

input[type='text']{
	width:100%;
}

#fileUpBtn {
	margin-left: 600px;
}

#editable{
			height : 400px;
			text-align:left;
}
</style>
</head>
<body>
	<center>
		<h3>실종 글 등록</h3>
	</center>
	<form id="missingSend" action="missingWrite" method="post">
		<table>
			<tr>
				<th>지역</th>
				<td><select id="">
						<option value="/" selected>--[시|도]--</option>
				</select> <select id="">
						<option value="/" selected>--[시|구]--</option>
				</select> <select id="">
						<option value="/" selected>--[동|읍|리]--</option>
				</select></td>
			</tr>
			<tr>
				<th>동물</th>
				<td><select id="">
						<option value="/" selected>--동물종--</option>
				</select> <select id="">
						<option value="/" selected>--품종--</option>
				</select></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="board_title"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="editable" contenteditable="true"></div> 
					<input id="contentForm" type="hidden" name="content"/>
				</td>
			</tr>
			<tr>
				<th id="field">사진 첨부</th>
				<td><input type="button" id="fileUpBtn" onclick="fileUp()" value="첨부" /></td>
			</tr>
			<tr>
				<td colspan="3" height="50px"></td>
			</tr>
		</table>
		<p>
		<p>
		<p>
		<center>
			<input type="password" placeholder="비밀번호" /> 
			<input type="button" id="save" value="등록"> <input type="button" value="취소">
		</center>
	</form>
</body>
<script>
	function fileUp() {
		var myWin = window.open("./uploadForm", "파일 업로드", "width=300, height=150");
	}

	$("#save").click(function() {
		$("#editable input[type='button']").remove();//삭제 버튼 제거
		$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
		$("#missingSend").submit();
	});
</script>
</html>