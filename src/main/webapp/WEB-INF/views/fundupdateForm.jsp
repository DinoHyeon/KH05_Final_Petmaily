<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<title>Insert title here</title>		
		<style>
		table{
			width:100%;
		}
		input[type='text']{
			width:99%;
		}
		table,td{
			border: 1px solid black;
			border-collapse: collapse;
			padding: 10px;
			text-align:center;
		}
	</style>
	</head>
	<body>
	<form id="sendForm" action="fundupdate" method="post">
		<table>
			<tr>
				<td>	<input type="hidden" value=${dto.board_idx} name="idx"></td>
				<td>작성자</td>
				<td>
				${dto.board_writer}
				
				</td>
				<td>조회수</td>
				<td>${dto.board_hit }</td>
				<td>작성일</td>
				<td>${dto.board_regDate }</td>
			</tr>
			<tr>
				<td >제목</td>
				<td colspan="7">
					<input type="text" name="subject" value="${dto.board_title}"/>
				</td>				
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="7">	
					<!-- div 에서 내용을 받아 보여준다. -->
					<div id="editable" contenteditable="true">${dto.board_content}</div>
					<!-- 전송은 hidden 에 담아서 한다. -->
					<input id="contentForm" type="hidden" name="content"/>
				</td>
			</tr>
		
			<tr>
				<td colspan="8">
					<input type="button" onclick="home()" value="취소"/>
					<input id="save" type="button" value="저장"/>
				</td>
			</tr>	
		</table>		
		</form>
	</body>
	<script>
		
	
		
		$("#save").click(function(){
			$("#editable input[type='button']").remove();//삭제 버튼 제거
			$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
			$("#sendForm").submit();
		});
			
		function home(){
			location.href="./";
		}
	
	</script>
</html>















