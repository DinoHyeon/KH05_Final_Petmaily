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
		border : 1px solid black;
		border-collapse: collapse;
        padding: 5px 10px; 
        margin: auto;
	}
	
th{
	width: 70px;
}

#fileUpBtn {
	margin-left: 300px;
}

#attach img {
	width: 80px;
	height: 80px;
}

</style>
</head>
<body>
	<form id="sendForm" action="missingUpdate" method="post">
	<table>
		<tr>
			<td>
				<input type="text" name="board_title" value="${missingDetail.board_title}"/>
				<input type="hidden" name="board_idx" value="${missingDetail.board_idx}"/>
			</td>
			<td>${missingDetail.board_writer}</td>
			<td>${missingDetail.board_hit}</td>
		</tr>
		<tr>
			<td>
				<!-- 동물종 -->
				동물 종 :
				<select id="animal" onchange="getAnimalType()">
					<option value="417000">개</option>
					<option value="422400">고양이</option>
					<option value="429900">기타</option>
					<input type="hidden" id="selectAnimal" name="animal"/>
				</select>
			</td>
			<td colspan="2">
				<!-- 품종 -->
				품종 :
				<select id="animalType" name="animalType">
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">실종 위치 : 
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
			</select>
			<select id="sigundo" name="sigundo">
			<input type="hidden" id="location" name="sido">
			</select>
			</td>
			<td>작성일 : ${missingDetail.board_regDate}</td>
		</tr>
		<tr>
			<td colspan="3">
			<div id="editable" contenteditable="true">${missingDetail.board_content}</div>
			<input id="contentForm" type="hidden" name="board_content"/>
			</td>
		</tr>
		<tr>
				<th id="field">사진 첨부</th>
				<td colspan="2"><input type="button" id="fileUpBtn" onclick="fileUp()" value="첨부" /></td>
			</tr>
			<tr>
				<td colspan="3" height="50px"><div id="attach" contenteditable="true"></div></td>
			</tr>
	</table>
	</form>
	
	<input type="button" id="btn_Update" value="수정"/>
	<input type="button" id="back" value="취소"/>
</body>
<script>
	var fullLoc = "${missingDetail.missing_loc}"; //지역 값 전체 받아오기
	var locArr = fullLoc.split(' '); //locArr[0] :시    locArr[1] : 구
	
	
	$(document).ready(function(){	
      selectBoxChk($("#sido"),locArr[0]);
      getSigungu();//option 있는상태에서 내가 비교할 값 찾기
      selectBoxChk($("#animal"),"${missingDetail.animal_idx}");
      getAnimalType();
	});

	 function selectBoxChk(selectBox,data) {
		 selectBox.find("option").each(function(index){
	         if( $(this).html() == data ){
	        	 $(this).prop("selected", true);
	         }
	         
	      });
	   }
	
	var fileMap = {};
	var fileCnt = "${size}";//첨부파일 유무 확인
	var path = "${path}";//내파일 위치
	console.log("첨부파일 갯수 : "+fileCnt);
	console.log("파일 위치 : "+path);
	
	<c:forEach items="${files}" var = "missingList">
		fileMap["${missingList.photo_newName}"] = "${missingList.photo_oriName}";
	</c:forEach>
	
	//파일이 있으면 fileMap 에 있는 값으로 링크를 생성
	if(fileCnt >0){
		//object 에서 키추출 -> 키에 따른 값을 추출
		//키를 이용해 값을 하나씩 뽑아내기
		var content = "";
		Object.keys(fileMap).forEach(function(item){
			content +=" <img width='15px' src='${path}'/> "
			+fileMap[item];
		});
		$("#attach").append(content);
		
	}else{
		$("#attach").html("첨부된 파일이 없습니다.");
	}

	//지역
	function getSigungu() {
		console.log();
		$.ajax({
			"url" : "./getSigungu",
			"type" : "get",
			"data" : {"sidoCode" : $("#sido option:selected").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					if(item.sigundoName==locArr[1]){
						content += "<option value="+item.sigundoName+" selected>";
					}else{
						content += "<option value="+item.sigundoName+">";
					}
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
			"data" : {"animalCode" : $("#animal option:selected").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					if(item.animalType=="${missingDetail.animal_type}"){
						content += "<option value="+item.animalType+" selected>";
					}else{
						content += "<option value="+item.animalType+">";
					}
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
	
	
	
	
	
	//파일 업로드 창
	function fileUp() {
		var myWin = window.open("./muploadForm", "파일 업로드", "width=300, height=150");
	}
	
	//사진 삭제 - ajax
	function mDel(elem){
		var path = elem.id;
		var pathimg = path+"img";
		var fileName = elem.id.split("/")[2];
		console.log("fileName", fileName);
		$.ajax({
			url : "./mFileDel",
			type : "get",
			data : {"fileName":fileName},
			success:function(data){
				console.log(data);
				if(data.success == 1){
					//이미지 삭제+버튼삭제
   					$(elem).prev().remove();//attach 이미지삭제
					$(elem).remove();//attach 버튼삭제
					$("#attach").remove(); //원래있던 이미지 지우기
					document.getElementById(pathimg).remove();//editable 이미지삭제
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	// 이미지에 삭제 버튼 붙이기		
	$("#editable img").each(function(index,value){		
		var delBtn = "<input id='"+$(this).attr("src")
			+"' type='button' value='삭제' onclick='mDel(this)'>";
		$(this).after(delBtn);
	});
	
	//취소
	$("#back").click(function(){
		location.href="./missingList";
	});
	
	//수정
	$("#btn_Update").click(function(){
		$("#editable input[type='button']").remove();//삭제 버튼 제거
		$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
		$("#location").val($("#sido option:selected").html());//지역 내용 담기
		$("#selectAnimal").val($("#animal option:selected").html());//동물 내용 담기
		$("#sendForm").submit();
	});
	
</script>
</html>