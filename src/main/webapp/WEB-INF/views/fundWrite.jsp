<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="resources/icon.png">
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

table {
	width: 500px;
}

input[type='text'] {
	width: 100%;
}

textarea {
	width: 100%;
	resize: none;
}

td {
	text-align: center;
}

#editable {
	height: 500px;
	border: 1px solid gray;
	padding: 5px;
	overflow: auto;
	text-align: left;
}

#sessionId{
		border: none;
		text-align: center;
	}
</style>
</head>
<body>
	<form id="sendForm" action="./writefundbbs" method="post">
		<table>
		<tr>
				<th>지역</th>
				<td>
					<input type="hidden" id="location" name ="sido">
					<select id="sido" onchange="getSigungu()">
					<option value="">선택</option>
				      <option value="6110000">서울특별시</option>
				      <option value="6260000">부산광역시</option>
				      <option value="6270000">대구광역시</option>
				      <option value="6280000">인천광역시</option>
				      <option value="6290000">광주광역시</option>
				      <option value="5690000">세종특별자치시</option>
				      <option value="6300000">대전광역시</option>
				      <option value="6310000">울산광역시</option>
				      <option value="6410000">경기도</option>
				      <option value="6420000">강원도</option>
				      <option value="6430000">충청북도</option>
				      <option value="6440000">충청남도</option>
				      <option value="6450000">전라북도</option>
				      <option value="6460000">전라남도</option>
				      <option value="6470000">경상북도</option>
				      <option value="6480000">경상남도</option>
				      <option value="6500000">제주특별자치도</option>
					</select> 
					<select id="sigundo" name="sigundo">
					</select> 
				</td>
			</tr>
			<tr>
			
			
				<th>게시판명</th>
				<td>모금 게시판</td>
			</tr>
			<tr>
					<th>작성자</th>
					<td><input id="sessionId" type ="text" value="${sessionScope.loginId}"  name="board_writer" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="board_title" /></td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td>
					<!-- div 에서 내용을 받아 보여준다. -->
					<div id="editable" contenteditable="true"></div> 
					<!-- 전송은 hidden 에 담아서 한다. -->
					<input id="contentForm" type="hidden" name="board_content" />
					
				</td>
			</tr>
			
			<tr>
				<th>조회수</th>
				<td><input type="text" name="board_hit"/></td>
			</tr>
			<tr>
					<th>동물 병원 정보</th>
					<td><input type="text" name="fund_centerName"/></td>
			</tr>
			
			<tr>
				<th>동물사진 첨부</th>
				<td colspan="2"><input type="button" onclick="fileUp()" value="파일 업로드" /></td>
			</tr>
			
			<tr>
				<td colspan="3"><div id="animalList"></div></td>
			</tr>
							
			<tr>
				<th>영수증사진 첨부</th>
				<td><input type="button" onclick="photoUp()"value="파일 업로드" /></td>
			</tr>
			<tr>
				<td colspan="3"><div id="receiptList"></div></td>
			</tr>
			<tr>
				<td colspan="2"><a href="./">리스트 가기</a>
				<!-- ./ 현재의 루트 --> &nbsp;&nbsp; 
				<input id="save" type="button" value="글 저장" /><a href="./write?idx=${dto.board_idx}">삭제</a>
				</td>				
			</tr>
		</table>
	</form>
</body>
<script>
var msg = "${msg}";
	
	function getSigungu() {
		$.ajax({
			"url" : "./getSigungu",
			"type" : "get",
			"data" : {"sidoCode" : $("#sido").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.sigundoName+">";
					content += item.sigundoName;
					content += "</option>";
				})
				$("#sigundo").empty();
				$("#sigundo").append(content);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
	
	function fileUp(){
		//fileUpload 새창을 띄운다.
		var myWin = window.open("./animalupload","파일 업로드","width=400, height=100");
	}

	
	function photoUp(){
		var myWin = window.open("./receiptUpload","파일 업로드","width=400, height=100");
	}
	//사진 삭제시 초기화가 되지 않기 위해 Ajax 사용
	function del(elem){
		  
		var fileName = elem.id.split("/")[2];
		$.ajax({
			url:"./fileDel",
			type:"get",
			data:{"fileName":fileName},
			success:function(data){
				if(data.success == 1){
					document.getElementById(fileName).remove();
					$(elem).closest("div").remove();
/* 					$(elem).prev().remove();//이미지 삭제
					$(elem).remove();//버튼 삭제		 */				
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	
	function deltwo(elem){
		  
		var fileName = elem.id.split("/")[2];
		$.ajax({
			url:"./filetwoDel",
			type:"get",
			data:{"fileName":fileName},
			success:function(data){
				if(data.success == 1){
					document.getElementById(fileName).remove();
					$(elem).closest("div").remove();
/* 					$(elem).prev().remove();//이미지 삭제
					$(elem).remove();//버튼 삭제		 */				
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	

	var msg = "${msg}";
 	var newFileName;	
	
	$("#save").click(function(){
 	if(checkonephoto()){
			$("#editable input[type='button']").remove();//삭제 버튼 제거
			$("#editable input[type='checkbox']").remove();//체크박스 버튼 제거
			$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
			$("#location").val($("#sido option:selected").html());
	    	$("#sendForm").submit();
		}else{
			alert("※동물사진 3개이상, 영수증 사진 3개 이상 등록해주세요※");
		}  
 
		
	
		
	});
		

	function checkphoto() {
		var photoChk;
		$.ajax({
			url:"./checkphoto",
			type:"get",
			async: false,
			success:function(data){
				photoChk = data;
			},
			error:function(e){
				console.log(e);
			}
		});
		
		return photoChk;
		
	}
	
	function checkonephoto() {
		var photoChk;
		$.ajax({
			"url":"./checkonephoto",
			"type":"get",
			"async": false,
			"success":function(data){
				photoChk = data;
			},
			error:function(e){
				console.log(e);
			}
		});
		
		return photoChk;
		
	}
	
	</script>
</html>












