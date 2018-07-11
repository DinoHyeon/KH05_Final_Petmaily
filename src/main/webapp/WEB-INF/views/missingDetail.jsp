<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>Insert title here</title>
<style>
table, tr, td{
		width : 800px;
		border : 1px solid black;
		border-collapse: collapse;
        padding: 5px 10px; 
	}
</style>
</head>
<body>
	<table>
		<tr>
			<td>${missingDetail.board_title}</td>
			<td>${missingDetail.board_writer}</td>
			<td>${missingDetail.board_hit}</td>
		</tr>
		<tr>
			<td>동물종 : ${missingDetail.animal_idx}</td>
			<td>품종 : ${missingDetail.animal_type}</td>
			<td>즐겨찾기</td>
		</tr>
		<tr>
			<td colspan="2">실종 위치 : ${missingDetail.missing_loc}</td>
			<td>작성일 : ${missingDetail.board_regDate}</td>
		</tr>
		<tr>
			<td colspan="3">${missingDetail.board_content}</td>
		</tr>
	</table>
	
	
	<!-- 댓글 include -->
	
	
	<input type="button" onclick="missingList()" value="리스트"/>
	<input type="button" onclick="missingUpdate()" value="수정"/>
	<input type="button" onclick="missingDelete()" value="삭제"/>
</body>
<script>
	//리스트보기
	function missingList(){
		location.href="./missingList";
	}

	//수정하기
	function missingUpdate(){
		location.href="./missingUpdateForm?board_idx=${missingDetail.board_idx}";
	}
	
	//삭제
	function missingDelete(){
		location.href="./missingDelete?board_idx=${missingDetail.board_idx}";
	}
</script>
</html>