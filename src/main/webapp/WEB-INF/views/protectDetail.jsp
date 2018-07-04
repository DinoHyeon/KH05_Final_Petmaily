<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
			<td>${protectDetail.board_title}</td>
			<td>${protectDetail.board_writer}</td>
			<td>${protectDetail.board_hit}</td>
		</tr>
		<tr>
			<td>동물종 : <select></select>
			</td>
			<td>품종 : <select></select>
			</td>
			<td>즐겨찾기</td>
		</tr>
		<tr>
			<td colspan="2">발견 위치 : ${protectDetail.protect_loc}</td>
			<td>작성일 : ${protectDetail.board_regDate}</td>
		</tr>
		<tr>
			<td colspan="3">${protectDetail.board_content}</td>
		</tr>
	</table>
	
	
	<!-- 댓글 include -->
	
	
	<input type="button" onclick="protectUpdate()" value="수정"/>
	<input type="button" onclick="protectDelete()" value="삭제"/>
</body>
</html>