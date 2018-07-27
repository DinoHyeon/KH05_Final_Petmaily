<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.css">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.theme.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/plugIn/jquery-ui.js"></script>

<title>입양 후기 게시판</title>
<style>
/* 타이틀 */
#title h1 {
	top: 0%;
	left: 45%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}

#title h5 {
	top: 22%;
	left: 42%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: black;
	font-weight: 700;
	font-size: 10;
	position: absolute;
}

/* 셀렉트박스 테이블 */
.adopt  #selectTable {
	top: 16.7%;
	left: 25%;
	height: 50px;
	margine: 10px 40px 10px 40px;
	position: absolute;
	float: left;
}

#selectTable td {
	padding: 5px 10px 5px 10px;
}
/* IE 10, 11의 네이티브 화살표 숨기기 */
#selectTable select::-ms-expand {
	display: none;
}

#selectTable select {
	width: 150px; /* 원하는 너비설정 */
	padding: .8em .5em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 50%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}
/* 검색버튼 */
.adopt #searchBtn {
	top: 17.5%;
	left: 67%;
	width: 80px;
	height: 40px;
	position: absolute;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}
/* 글 목록 */
.adopt #listTable {
	top: 24%;
	left: 12%;
	width: 1000px;
	margin: 20px 5px 200px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#listTable input[type='text'] {
	width: 100%;
}

#listTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#listTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
}

#listTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#aList a:link {
	text-decoration: none;
	color: black;
}

/* 페이징 목록, 글쓰기 버튼 및 hr */
#paging {
	left: 38%;
	margin: 50px auto auto auto;
	position: absolute;
}

.adopt #writeBtn {
	left: 88%;
	height: 40px;
	width: 107px;
	margin: 50px auto auto auto;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
	position: absolute;
}

.adopt #ListBtn {
	left: 76%;
	height: 40px;
	width: 107px;
	margin: 50px auto auto auto;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
	position: absolute;
}

.adopt hr {
	margin: 5px auto auto auto;
	border: none;
	width: 1000px;
	border: 1px solid lightgray;
	color: lightgray; /* IE */
	border-color: lightgray; /* 사파리 */
	background-color: lightgray; /* 크롬, 모질라 등, 기타 브라우저 */
}

#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 107%;
	background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 107%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="contentFrame">
		<div class="adopt">

			<div id=title>
				<h1>입양 후기</h1>
				<h5>입양 후기를 남기는 게시판 입니다</h5>
			</div>
			<table id="selectTable">
				<td><select id="animal" onchange="getAnimalType()"
					name="animal_idx">
						<option value="선택" selected>선택</option>
						<option value="417000">개</option>
						<option value="422400">고양이</option>
						<option value="429900">기타</option>
				</select></td>

				<td><select id="animalType" name="animal_type">
						<option value="선택" selected>선택</option>
						<option></option>
				</select></td>

				<td><select id="sido" onchange="getSigungu()" name="adopt_loc1">
						<option value="선택">선택</option>
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
				</select></td>
			</table>
			<input type="button" id="searchBtn" onclick="adoptList(showPageNum)"
				value="검색" />
			<table id="listTable">
				<thead>
					<tr>
						<th style="width: 150px">글번호</th>
						<th style="width: 450px">제목</th>
						<th style="width: 150px">작성자</th>
						<th style="width: 150px">작성일</th>
						<th style="width: 100px">조회수</th>
					</tr>
				</thead>
				<tbody id="aList">
				</tbody>
				<tr colspan="5">
				</tr>
				<tr colspan="5">
					<td>
						<div id="paging"></div>
						<button id="writeBtn" onclick="location.href='./adoptForm'">글
							작성</button>
						<button id="ListBtn" onclick="location.href='./adoptMain'">전체
							글 보기</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
<script>
   /* 리스트 출력 및 검색 기능 */
   //현재 보여줄 페이지
  var showPageNum = 1;
  var menuName = {'유기동물공고':'animalNotice', '입양후기':'adoptMain'};
  var page=1;
   $(document).ready(function() {
	   var content = "";
		for(var key in menuName){
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if(key=='입양후기'){
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id="+menuName[key]+">";
			content += key;
			content += "</div>";
		};	
		
		$("#sideMenu").empty();
		$("#sideMenu").append(content);
	   
      adoptList(showPageNum);
   });
   
   function adoptList(page) {
		var target1 = document.getElementById("sido");
		var selsido1 = target1.options[target1.selectedIndex].text;
		
		var target2 = document.getElementById("animalType");
		var selanimal2 = target2.options[target2.selectedIndex].text;
		var ani_type = selanimal2.replace(/ /gi, "");
      $.ajax({
         type : "get",
         url : "./adoptList",
         data : {
        	 "animal_type" : ani_type,
        	 "sido" : selsido1,        	
             "showPageNum" : page
         },
         success : function(data) {
            listPrint(data);

         },
         error : function(e) {
            console.log(e);
         }
      });
   }
   
   function pageMove(e) {
		console.log($(e).attr("id"));
		location.href="./"+$(e).attr("id");
	};
   
   function listPrint(data) {
      var content = "";
      data.aList.forEach(function(item) {
         var date = new Date(item.board_regDate);
         content += "<tr>";
         content += "<td>" + item.board_idx + "</td>";
         content += "<td><a href='./adoptDetail?board_idx="
            + item.board_idx + "'>" + item.board_title + "</td>";
         content += "<td>" +item.board_writer + "</td>";
         content += "<td>"+date.toLocaleDateString("en-KOR")+"</td>";
         content += "<td>" + item.board_hit + "</td>";
         content += "</tr>";
      })
      $("#aList").empty();
      $("#aList").append(content);
      $("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
                adoptList($(this).attr('page'));
            }
        });
   }
   //페이징 그리기
	function pagePrint(currPage, range){
		
		var start = 1;
		var end = 5;
		var content = "";
				
		for(var i=start; i<=end;i++){			
			if(i <=range){//i는 절대 생성 가능 페이지보다 크면 안된다.
				if(currPage == i){
					content +=" <b> [ "+i+" ] </b> "
				}else{
					content +=" <a href='#' onclick='listCall("+i+")'> "
						+i+" </a> "
				}		
			}		
		}
		//이후(range 가 5보다 클 경우)
		if(end<range){
			content += " | <a href='#' onclick='listCall("+(end+1)+")'>"
					+"다음</a>";
		}		
		$("#paging").empty();
		$("#paging").append(content);
	}
 
	////////////////////////////////////////////////////////////////
	/* 셀렉트테이블 api */
	function getSigungu() {
		// 텍스트값 가져오기
		var target = document.getElementById("sido");
		var selsido = target.options[target.selectedIndex].text;

		$.ajax({
			"url" : "./getSigungu",
			"type" : "get",
			"data" : {
				"sidoCode" : $("#sido").val()
			},
			"success" : function(data) {
				console.log(data);
				$("#selsido").val(selsido);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}

	function getAnimalType() {
		// 텍스트 값 가져오기
		var target = document.getElementById("animal");
		var selanimal = target.options[target.selectedIndex].text;
		

		$.ajax({
			"url" : "./getAnimalType",
			"type" : "get",
			"data" : {
				"animalCode" : $("#animal").val()
			},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					var bbo = item.animalType.replace(/ /gi, "");
					content += "<option value="+bbo+">";
					content += item.animalType;
					content += "</option>";
				})
				$("#animalType").empty();
				$("#animalType").append(content);
				$("#selanimal").val(selanimal);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
   
   </script>
</html>