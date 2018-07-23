<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>구조 후기 게시판</title>
<style>
/* 타이틀 */
#title h1 {
	top: 16%;
	left: 45%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}

#title h5 {
	top: 43%;
	left: 70%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: black;
	font-weight: 700;
	font-size: 10;
	position: absolute;
}

/* 셀렉트박스 테이블 */
.save  #selectTable {
	top: 36%;
	left: 30%;
	height: 50px;
	margine: 10px 40px 10px 40px;
	position: absolute;
	float: left;
}
#selectTable td {
}
/* IE 10, 11의 네이티브 화살표 숨기기 */
#selectTable select::-ms-expand {
	display: none;
}
#selectTable select {
	width: 130px; /* 원하는 너비설정 */
	padding: .8em .5em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 30%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}
/* 검색버튼 */
.save #searchBtn {
	top: 280px;
	left: 62%;
	width: 80px;
	height: 36px;
	position: absolute;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	text-align: center;
	color: white;
	cursor: pointer;
	margin: auto auto auto 20px;
}
/* 검색창 */
#selectTable #keyWord {
	height: 35px;
	width: 350px;
	margin: auto 20px auto 20px;
}
/* 글 목록 */
.save #listTable {
	top: 45%;
	left: 20%;
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

#sList a:link {
	text-decoration: none;
	color: black;
}

/* 페이징 목록, 글쓰기 버튼 및 hr */
#paging {
	left: 38%;
	margin: 50px auto auto auto;
	position: absolute;
}

.save #writeBtn {
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

.save #ListBtn {
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

.save hr {
	margin: 5px auto auto auto;
	border: none;
	width: 1000px;
	border: 1px solid lightgray;
	color: lightgray; /* IE */
	border-color: lightgray; /* 사파리 */
	background-color: lightgray; /* 크롬, 모질라 등, 기타 브라우저 */
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div class="save">

		<div id=title>
			<h1>구조 후기</h1>
			<h5>구조 후기를 남기는 게시판 입니다</h5>
		</div>

		<table id="selectTable">
			<td>
			<select id="sido" onchange="getSigungu()" name="adopt_loc1">
					<option value="지역 선택">지역 선택</option>
					<option value="6110000">서울특별시</option>
					<option value="6260000">부산광역시</option>
					<option value="6270000">대구광역시</option>
					<option value="6280000">인천광역시</option>
					<option value="6290000">광주광역시</option>
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
			</td>
			<td><input type="text" id="keyWord" placeholder="검색할 제목 또는 작성자를 입력하세요." /></td>
			<input type="button " id="searchBtn" onclick="saveList(showPageNum)" value="검색">
			</button>
		</table>
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
			<tbody id="sList">
			</tbody>
			<tr colspan="5">
			</tr>
			<tr colspan="5">
				<td>
					<div id="paging"></div>
					<button id="writeBtn" onclick="location.href='./saveForm'">글
						작성</button>
					<button id="ListBtn" onclick="location.href='./saveMain'">전체
						글 보기</button>
				</td>
			</tr>
		</table>
	</div>
</body>
<script>
	 
	   /* 리스트 출력 및 검색 기능 */
	   //현재 보여줄 페이지
	  var showPageNum = 1;
	  var page=1;
	  
	   $(document).ready(function() {
	      saveList(showPageNum);
	   });
	   
	   function saveList(page) {
		  var target1 = document.getElementById("sido");
	      var selsido1 = target1.options[target1.selectedIndex].text;
			
	      $.ajax({
	         type : "get",
	         url : "./saveList",
	         data : {
	        	 "keyWord": $("#keyWord").val(),
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
	   function listPrint(data) {
	      var content = "";
	      data.sList.forEach(function(item) {
	         var date = new Date(item.board_regDate);
	         content += "<tr>";
	         content += "<td>" + item.board_idx + "</td>";
	         content += "<td><a href='./saveDetail?board_idx="
	            + item.board_idx + "'>" + item.board_title + "</td>";
	         content += "<td>" + item.board_writer + "</td>";
	         content += "<td>"+date.toLocaleDateString("en-KOR")+"</td>";
	         content += "<td>" + item.board_hit + "</td>";
	         content += "</tr>";
	      })
	      $("#sList").empty();
	      $("#sList").append(content);
	      $("#paging").zer0boxPaging({
	            viewRange : 5,
	            currPage : data.currPage,
	            maxPage : data.range,
	            clickAction : function(e){
	                saveList($(this).attr('page'));
	            }
	        });
	   }
	   //페이징 그리기
		function pagePrint(currPage, range){
			
			var start = 1;
			var end = 5;
			var content = "";
			
			
	/* 		//이전
			if(currPage >5){			
				//end = currPage + 4; <- 이경우 페이지 변화 시 마다 페이징이 이동
				//우리가 원하는 것은 5단위로 움직일때 새로운 페이징 생성
				end = Math.ceil(currPage/5)*5;//6,11,16 씩 대입 해 보자
				start = end - 4;
				content += " <a href='#' onclick='listCall("+(start-1)+")'>"
				+"이전</a> | ";
			} */
					
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
	
	</script>
</html>