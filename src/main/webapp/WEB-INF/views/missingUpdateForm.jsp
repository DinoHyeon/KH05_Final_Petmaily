<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>실종 게시글 수정</title>
<style>
#fileUpBtn {
	position: absolute;
	top: 1.3%;
	left: 93.5%;
}

#attach img {
	width: 80px;
	height: 80px;
}

#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 150%;
	background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 150%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

#d_title {
	width: 40%;
}

#d_writer {
	text-align: center;
	width: 20%;
}

#d_hit {
	text-align: center;
	width: 10%;
}

#d_reg {
	text-align: center;
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
#detailTable {
	top: 14%;
	left: 11%;
	width: 1000px;
	margin: 0px 5px 5px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#detailTable input[type='text'] {
	width: 96%;
	height: 30px;
}

#detailTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#detailTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
	margin: 0px;
}

#detailTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#detailTable input[type='button'] {
	height: 40px;
	width: 120px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}
/* 업로드 테이블 */
#uploadTable {
	position: absolute;
	top: 73%;
	left: 11%;
	border: 1px solid gray;
	width: 1000px;
	height: 150px;
	margin: 50px 5px 100px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
}

#uploadTable tr, td {
	font-weight: 600;
	font-family: "나눔고딕 보통";
	border: 1px solid gray;
}

#uploadTable input[type='button'] {
	width: 60px;
	height: 30px;
	top: 1.6%;
	left: 93%;
	font-family: "나눔고딕 보통";
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#detailTable select {
	width: 290px; /* 원하는 너비설정 */
	padding: .8em .5em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 50%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
	left: 30%;
}

#attachArea {
	float: left;
	padding: 1%;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="conDiv">
		<h1>실종게시판 수정</h1>
		<form id="sendForm" action="missingUpdate" method="post">
			<input type="hidden" name="board_idx"
				value="${missingDetail.board_idx}" />
			</td>

			<table id="detailTable" style="border: 1px solid gray">
				<tr class="littleTr">
					<th style="width: 100px">작성자</th>
					<td class="littleTd">${missingDetail.board_writer}</td>

					<th style="width: 100px">작성일</th>
					<td>${missingDetail.board_regDate}</td>
				</tr>
				<tr class="littleTr">
					<th style="width: 100px">제목</th>
					<td class="littleTd"><input type="text" name="board_title"
						value="${missingDetail.board_title}" /></td>
					<th style="width: 100px">조회수</th>
					<td id="d_hit">${missingDetail.board_hit}</td>
				</tr>


				<tr class="littleTr">
					<th style="width: 100px">동물 종</th>
					<td class="littleTd"><select id="animal"
						onchange="getAnimalType()">
							<option value="417000">개</option>
							<option value="422400">고양이</option>
							<option value="429900">기타</option>
							<input type="hidden" id="selectAnimal" name="animal" />
					</select></td>
					<th style="width: 100px">품종</th>
					<td colspan="2" id="d_animal" class="litteTd"><select
						id="animalType" name="animalType">
					</select></td>
				</tr>
				<tr>
					<th style="width: 100px">위치</th>

					<td colspan="5" class="littleTd" style="width: 500px"><select
						id="sido" onchange="getSigungu()">
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
					</select> <select id="sigundo" name="sigundo">
							<input type="hidden" id="location" name="sido">
					</select></td>


				</tr>
				<tr>
					<th colspan=5 style="width: 1000px; border: 1px solid gray;">내
						용</th>
				</tr>
				<tr>
					<td colspan=5 style="text-align: left; border: 1px solid gray;">
						<div id="editable" contenteditable="true">${missingDetail.board_content}</div>
						<input id="contentForm" type="hidden" name="board_content" />
					</td>
				</tr>

			</table>
			<table id="uploadTable">
				<tr>
					<th id="field">사진 첨부</th>
					<td colspan="5"><input type="button" id="fileUpBtn"
						onclick="fileUp()" value="첨부" /></td>
				</tr>
				<tr>
					<td colspan="5" height="50px">
						<div id="attach"></div> <input type="hidden" name="mainPhoto">
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right; border: 1px solid white;">
						<input type="button" id="btn_Update" value="수정" /> <input
						type="button" id="back" value="취소" />
				</tr>

			</table>

		</form>

	</div>
</body>
<script>
var fullLoc = "${missingDetail.missing_loc}"; //지역 값 전체 받아오기
var locArr = fullLoc.split(' '); //locArr[0] :시    locArr[1] : 구
var menuName = {
	'실종' : 'missingList',
	'보호' : 'protectList'
};
var mainPhoto;

	//수정페이지 접근시 내가 선택했던 selectBox 값 불러오기
	$(document).ready(function() {
		selectBoxChk($("#sido"), locArr[0]);
		getSigungu();//option 있는상태에서 내가 비교할 값 찾기
		selectBoxChk($("#animal"), "${missingDetail.animal_idx}");
		getAnimalType();
		
		var content = "";
		for(var key in menuName){
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if(key=='실종'){
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id="+menuName[key]+">";
			content += key;
			content += "</div>";
		};	
		
		$("#sideMenu").empty();
		$("#sideMenu").append(content);

		
	});
	
	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href="./"+$(e).attr("id");
	};

	function selectBoxChk(selectBox, data) {
		selectBox.find("option").each(function(index) {
			if ($(this).html() == data) {
				$(this).prop("selected", true);
			}

		});
	}

	//파일
	var fileMap = {};
	var fileCnt = "${size}";//첨부파일 유무 확인

	<c:forEach items="${files}" var = "missingList">
		if("${missingList.mainPhoto}"=="대표이미지"){
			mainPhoto = "${missingList.photo_newName}"
		}
		fileMap["${missingList.photo_newName}"] = "${missingList.photo_oriName}";
	</c:forEach>

	//파일이 있으면 fileMap 에 있는 값으로 링크를 생성
	if (fileCnt > 0) {
		//object 에서 키추출 -> 키에 따른 값을 추출
		//키를 이용해 값을 하나씩 뽑아내기
		var content = "";
		Object.keys(fileMap).forEach(function(item) {
			content += "<div id='attachArea'>"
			content += "<img width='15px' src='resources/upload/"+item+"'/>";
			if(mainPhoto==item){
				content += "<input type='radio' name='main' value='"+item+"' checked>";
			}else{
				content += "<input type='radio' name='main' value='"+item+"'>";
			}
			content += "</div>"
			
		});
		$("#attach").append(content);

	} else {
		$("#attach").html("첨부된 파일이 없습니다.");
	}

	//지역
	function getSigungu() {
		console.log();
		$
				.ajax({
					"url" : "./getSigungu",
					"type" : "get",
					"data" : {
						"sidoCode" : $("#sido option:selected").val()
					},
					"success" : function(data) {
						console.log(data);
						var content = "";
						data
								.forEach(function(item) {
									if (item.sigundoName == locArr[1]) {
										content += "<option value="+item.sigundoName+" selected>";
									} else {
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
					"data" : {
						"animalCode" : $("#animal option:selected").val()
					},
					"success" : function(data) {
						console.log(data);
						var content = "";
						data
								.forEach(function(item) {
									var selAni = item.animalType.replace(/ /gi, "");
									if (selAni == "${missingDetail.animal_type}") {
										content += "<option value="+selAni+" selected>";
									} else {
										content += "<option value="+selAni+">";
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
		var myWin = window.open("./muploadForm", "파일 업로드",
				"width=300, height=150");
	}

	//사진 삭제 - ajax
	function mDel(elem) {
		console.log(elem)
		var fileName = elem.id.split("/")[2];
		console.log(fileName);
 		$.ajax({
			url : "./mFileDel",
			type : "get",
			data : {
				"fileName" : fileName
			},
			success : function(data) {
				console.log(data);
				if (data.success == 1) {
					$(elem).closest("div").remove();
					document.getElementById(fileName).remove();
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	// (첨부파일 보기란)이미지에 삭제 버튼 붙이기		
	$("#attach img").each(
			function(index, value) {
				var delBtn = "<input id='" + $(this).attr("src")
						+ "' type='button' value='삭제' onclick='mDel(this)'>";
				$(this).after(delBtn);
			});

	//취소
	$("#back").click(function() {
		location.href = "./missingList";
	});
	
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

	//수정
	$("#btn_Update").click(function() {
		if($("#bTitle").val()==""){
			$("#bTitle").focus();
			alert("제목을 입력해 주세요.");
		}else if($("#sido option:selected").html()=="선택"){
			$("#sido").focus();
			alert("지역을 선택해 주세요.");
		}else if(!mcheckphoto()){
			alert("파일을 등록해주세요.");
		}else if(!$("input:radio[name='main']").is(":checked")){
			$("input:radio[name='main']").focus();
			alert("대표이미지를 선택해 주세요.");
		}else{
			$("#editable input[type='button']").remove();//삭제 버튼 제거
			$("input[name='mainPhoto']").val($("input:radio[name='main']:checked").val());
			$("#attach input[type='radio']").remove();//체크박스 버튼 제거
			$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
			$("#location").val($("#sido option:selected").html());//지역 내용 담기
			$("#selectAnimal").val($("#animal option:selected").html());//동물 내용 담기
			$("#sendForm").submit();
		}	
	});
</script>
</html>