<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
			overflow: auto;
}
#attach {
	overflow: auto;
}

#attach img {
	width: 80px;
	height: 80px;
}
</style>
</head>
<body>
<jsp:include page="mainFrame.jsp"/>
	<center>
		<h3>실종 글 등록</h3>
	</center>
	<form id="missingSend" action="missingWrite" method="post">
		<table>
			<tr>
				<th>지역</th>
				<td>
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
				<input type="hidden" id="location" name="sido">
				</select></td>
			</tr>
			<tr>
				<th>동물</th>
				<td>
					<!-- 동물종 -->
					<select id="animal" onchange="getAnimalType()">
						<option value="417000">개</option>
						<option value="422400">고양이</option>
						<option value="429900">기타</option>
						<input type="hidden" id="selectAnimal" name="animal">
					</select>
					
					<!-- 품종 -->
					<select id="animalType" name="animalType">
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="board_title"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="editable" contenteditable="true"></div> 
					<input id="contentForm" type="hidden" name="board_content"/>
				</td>
			</tr>
			<tr>
				<th id="field">사진 첨부</th>
				<td><input type="button" id="fileUpBtn" onclick="fileUp()" value="첨부" /></td>
			</tr>
			<tr>
				<td colspan="3" height="50px">
				<div id="attach"></div>
				</td>
			</tr>
		</table>
		<p>
		<p>
		<p>
		<center>
			<input type="password" placeholder="비밀번호" /> 
			<input type="button" id="btn_missingWrite" value="등록"> 
			<input type="button" id="back" value="취소">
		</center>
	</form>
</body>
<script>
	
	//지역
	function getSigungu() {
		console.log();
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
	
	//동물종&품종 값 가져오기
	function getAnimalType() {
		$.ajax({
			"url" : "./getAnimalType",
			"type" : "get",
			"data" : {"animalCode" : $("#animal").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.animalType+">";
					content += item.animalType;
					content += "</option>";
				})
				$("#animalType").empty();
				$("#animalType").append(content);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
	//사진 삭제 - ajax
	function mDel(elem){
		var fileName = elem.id.split("/")[2];
		console.log(fileName);
		$.ajax({
			url : "./mFileDel",
			type : "get",
			data : {"fileName":fileName},
			success:function(data){
				console.log(data);
				if(data.success == 1){
					$(elem).closest("div").remove();
					document.getElementById(fileName).remove();
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	/* 사진체크 */
	function mcheckphoto() {
      var photoChk;
      $.ajax({
         url:"./mcheckphoto",
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
	
	//파일 업로드 창
	function fileUp() {
		var myWin = window.open("./muploadForm", "파일 업로드", "width=300, height=150");
	}
	
	//취소
	$("#back").click(function(){
		location.href="./missingList";
	});
	
	//게시글 등록 버튼
	$("#btn_missingWrite").click(function() {
	if(mcheckphoto()){
       $("#editable input[type='button']").remove();//삭제 버튼 제거
       $("#editable input[type='checkbox']").remove();//체크박스 버튼 제거
       $("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
       $("#location").val($("#sido option:selected").html());
       $("#selectAnimal").val($("#animal option:selected").html());
       $("#missingSend").submit();
    }else{
       alert("파일을 등록해주세요.");
    }
		
	});
</script>
</html>