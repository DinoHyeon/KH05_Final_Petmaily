<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="icon" href="resources/icon.png">
		
		<title>Insert title here</title>		
		<style>
	
#attachArea{
float:left;
padding:1%;
}

#sideFrame {
			position: absolute;
			left: 0.52%;
			top: 11.4%;
			width: 15%;
			height: 150%;
			background: black;
		}
		#conDiv {
			position: absolute;
			left: 15.52%;
			top: 12.5%;
			width: 82.95%;
			height: 150%;
			background: white;
		}
		/* 타이틀 */
		#conDiv h1 {
			left: 39%;
			margin: 50px 0px 25px 0px;
			text-align: center;
			color: #28977B;
			font-weight: 700;
			font-size: 30;
			position: absolute;
		}		
		#conDiv table, th, td {
			border: 1px solid gray;
			border-collapse: collapse;
			padding: 6px 15px;
			text-align: center;
		}
		#conDiv #editable {
			border: 1px solid gray;
			height: 250px;
			height: 500px;
			padding: 5px;
			overflow: auto;
			text-align: left;
		}
		/* 글 테이블 */
		#detailTable{
			top:14%;
			left:11%;
			width: 1000px;
			margin: 0px 5px 5px 5px;
			border-collapse: collapse;
			padding: 5px 10px;
			position:absolute;
		}
		#detailTable input[type='text']{
			width:100%;
			height:30px;
		}
		#detailTable textarea{
			width:100%;
			resize:none;
			margin:0;
		}
		#detailTable td{
			text-align: center;
			border: 1px solid white;
			border-collapse: collapse;
			padding: 2px 2px;
			margin: 0px;
		}
		#detailTable th{
			border: 1px solid white;
			border-collapse: collapse;
			padding: 5px 10px;
			background-color: #28977B;
			color: white;
		}
		#detailTable input[type='button'] {
			 height:40px;
	         width:120px;
	         background-color: #28977B;
	         border-color:#28977B;
	         border-style:solid;
	         font-weight: 600;
	         color: white;
	         cursor: pointer;
		}

}
	</style>
	</head>
	<body>
	<jsp:include page="mainFrame.jsp"/>
		<div id="sideFrame"></div>
			<form id="sendForm" action="fundupdate" method="post">
		
		<div id="conDiv">
	<h1>모금 수정</h1>
	<input type="hidden" value=${dto.board_idx} name="idx">
<table id="detailTable" style="border:1px solid gray">			
		<tr class = "littleTr">
		<th style="width:100px">작성자</th><td id="littleTd" style="width:500px">${dto.board_writer }</td>
		<th style="width:100px">작성일</th>	<td id="ddate">${dto.board_regDate}</td>
	
	</tr>
	<tr class = "littleTr">
	<th style="width:100px">제　목</th><td class="littleTd" style="width:500px">
<input type="text" id="title" name="subject" value="${dto.board_title}"/></td>
				<th style="width:100px">조회수</th><td>${dto.board_hit}</td>
			</tr>
			<tr>
			   <tr>
               <th id="al" colspan='8' style="background:#217D65">※모금 게시판 사진 수정 불가합니다※</th>
         </tr>
			<th colspan=4 style="width:1000px; border:1px solid gray;">내　용</th>
					</tr>
				<tr>	
	<td colspan=4 style="text-align: left; border:1px solid gray;">
					
					<!-- div 에서 내용을 받아 보여준다. -->
					<div id="editable" contenteditable="true">${dto.board_content}</div>
					<!-- 전송은 hidden 에 담아서 한다. -->
					<input id="contentForm" type="hidden" name="content"/>
					</td>
					
					
					
				<tr>
	<td colspan="3" style="text-align: right; border:1px solid white;">
						<input id="cancle" type="button" onclick="home()" value="취소"/>
									<input id="savefund" type="button" value="저장"/></div>		
				
				
				
				</tr>	
			
		
		
			
		</table>
		</div>
		</form>
		
	</body>
	<script>
		
		
		$("#savefund").click(function(){
			if($("#title").val()==""){
		         $("#title").focus();
		         alert("제목을 입력해 주세요."); }
			
			else{$("#editable input[type='button']").remove();//삭제 버튼 제거
			$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
			$("#sendForm").submit();}
		});
			
		function home(){
			location.href="./";
		}
	
	</script>
</html>















