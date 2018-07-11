<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
<title>보호 게시판</title>
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

.protectList {
	width: 700px;
}

#write {
	margin: 300px 300px;
}
</style>
</head>
<body>
	<h3>보호 게시판</h3>
		<!-- 지역 -->
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
		<select id="sigundo">
		</select>

		<!-- 동물종 -->
		<select id="animal" onchange="getAnimalType()">
			<option value="">선택</option>
			<option value="417000">개</option>
			<option value="422400">고양이</option>
			<option value="429900">기타</option>
		</select>

		<!-- 품종 -->
		<select id="animalType" name="animalType">
		</select> 
		<input type="text" id="keyWord" placeholder="검색어를 입력해주세요." /> 
		<input type="button" onclick="listCall(showPageNum)" value="검색" />
	<div class="list">
	</div>
	<input type="button" id="write" onclick="protectWrite()" value="글쓰기">
	<div id="paging"></div>
</body>
<script>
var showPageNum=1;//현재 내가 보는 페이지

$(document).ready(function() {
	listCall(showPageNum);
});

function listCall(page){ //page -> showPageNum
	$.ajax({
		type : "get",
		url : "./getProtectList",
		data : {
			"sido" : $("#sido option:selected").html(),
			"sigundo" : $("#sigundo").val(),
			"animal" : $("#animal option:selected").html(),
			"animalType" :$("#animalType").val(),
			"keyWord" : $("#keyWord").val(),
			"showPageNum" : page
		},
		success : function(data) {
			listPrint(data);
			console.log(data);
		},
		error : function(e) {
			console.log(e);
		}
	});
}



function listPrint(data){
	var content = "";
	data.list.forEach(function(item){
		content += "<table>";
		content += "<tr>";
		content += "<td>"+item.board_idx+"</td>";
		content += "<td><a href='protectDetail?board_idx="+item.board_idx+"'>"+item.board_title+"</a></td>";
		content += "</tr>";
		content += "<tr>";
		content += "<td colspan='2'><img width='300' height='400' src='./resources/upload/"+item.photo_newName+"'/></td>";
		content += "</tr>";
		content += "</table>";
	})
	$(".list").empty();
	$(".list").append(content);
	
	$("#paging").zer0boxPaging({
        viewRange : 5,
        currPage : data.currPage,
        maxPage : data.range,
        clickAction : function(e){
        	listCall($(this).attr('page'));
        }
    });
}



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

	//보호 게시글 작성
	function protectWrite(){
		location.href="./protectWriteForm";
	}
</script>
</html>