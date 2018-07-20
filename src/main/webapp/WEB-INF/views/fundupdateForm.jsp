<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="icon" href="resources/icon.png">
		
		<title>Insert title here</title>		
		<style>
		table{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
	margin: auto;
	width : 70%;
   	top : 10%;
    left : 10%;
}

th {
	width: 70px;
}
td{
	border : 1px solid black;
	border-collapse: collapse;
	padding : 15px;

}
input[type='text']{
			width:99%;
		}
#tcontent{
	 text-align: center;
}
#ttitle{
	 text-align: center;
}		
#twriter{
	 text-align: center;

}
#tdate{
	 text-align: center;

}
		
	#contentFrame {
   position: absolute;
   left: 17.52%;
   top: 20.5%;
   width: 78.95%;
   height: 150%;
   background: white;
}

#sideFrame{
   position: absolute;
   left: 0.52%;
   top: 11.4%;
   width: 15%;
   height: 150%;
   background: black;
}
#editable{
	height: 60%;
}

#buttonarea{
    position: absolute;
    top : 72%;
    left : 48%;
}
	</style>
	</head>
	<body>
	<jsp:include page="mainFrame.jsp"/>
		<div id="sideFrame"></div>
	<div id="contentFrame">
	
	<form id="sendForm" action="fundupdate" method="post">
		<table>
			
			<tr>
			<td style="background:#217D65">	<input type="hidden" value=${dto.board_idx} name="idx"></td>
	<td id="ttitle" style="background:#A9CB73">제목</td>
				<td><input type="text" id="title" name="subject" value="${dto.board_title}"/>
					
				<td id="twriter" style="background:#A9CB73">작성자</td>
			<td>	${dto.board_writer}	</td>		
				<td id="tdate" style="background:#A9CB73">등록날짜</td>
			
				<td>${dto.board_regDate }</td>
			</tr>
			
         <tr>
               <th colspan='8'>※모금 게시판 사진 수정 불가※</th>
         </tr>
			
			<tr>
							<td id ="tcontent" style="background:#A9CB73">내 용</td>
			
				<td colspan="7">	
				
					<!-- div 에서 내용을 받아 보여준다. -->
					<div id="editable" contenteditable="true">${dto.board_content}</div>
					<!-- 전송은 hidden 에 담아서 한다. -->
					<input id="contentForm" type="hidden" name="content"/>
				</td>
			</tr>
		
			
		</table>
		<div id="buttonarea">
		<input type="button" onclick="home()" value="취소"/>
					<input id="savefund" type="button" value="저장"/></div>		
		</form>
		</div>
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















