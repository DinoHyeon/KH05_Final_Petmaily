<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>실종 게시판</title>
<style>
table {
	float: left;
	margin: 10px 10px;
	padding: 10px 0;
}

table, tr, td {
	width: 300px;
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

#board_idx {
	width: 40px;
	text-align: center;
}

.missingList {
	width: 700px;
}

#write {
	margin: 300px 300px;
}
</style>
</head>
<body>
	<h3>실종 게시판</h3>
	<form action="listArr" method="get">
		<!-- 지역 -->
		<select id="location">
			<option value="/" selected>--지역--</option>
		</select>

		<!-- 동물종 -->
		<select id="animal_idx">
			<option value="/" selected>--동물종--</option>
		</select>

		<!-- 품종 -->
		<select id="animal">
			<option value="/" selected>--품종--</option>
		</select> <input type="text" id="keyWord" placeholder="검색어를 입력해주세요." /> <input
			type="submit" id="search" value="검색" />
	</form>
	<div class="missingList">
		<c:forEach items="${missingList}" var="missing">
			<table>
				<tr>
					<td id="board_idx">${missing.board_idx}</td>
					<td><a href="missingDetail?board_idx=${missing.board_idx}">${missing.board_title}</a></td>
				</tr>
				<tr>
					<td colspan="2"><img src="#">${missing.mainPhoto}</td>
				</tr>
			</table>
		</c:forEach>
	</div>
	<input type="button" id="write" onclick="missingWriteForm()"
		value="글쓰기">
</body>
<script>

	//보호 게시글 작성
	function missingWriteForm(){
		location.href="./missingWriteForm";
	}
</script>
</html>