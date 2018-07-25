<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="resources/icon.png">
<title>Insert title here</title>
<style>
/* 타이틀 */
#title h1 {
	top: 0%;
	left: 40%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	position: absolute;
}

#title h5 {
	top: 27%;
	left: 53%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: black;
	font-weight: 700;
	font-size: 10;
	position: absolute;
}

/* 셀렉트박스 테이블 */
#contentFrame  #selectTable {
	top: 11.5%;
	left: 13%;
	padding: 1px 1px 1px 1px;
	margin: 25px auto auto 3px;
	position: absolute;
	float: left;
}

.tap {
	background-color: #28977B;
	font-weight: 600;
	color: white;
	height: 30px;
	margin: auto auto auto auto;
	text-align: center;
	width: 100px;
}

#selectTable th {
	background-color: #28977B;
	height: 30px;
	width: 1000px;
	color: white;
	font-weight: 600;
}

#selectTable td {
	padding: 5px 10px 5px 10px;
}
/* IE 10, 11의 네이티브 화살표 숨기기 */
#selectTable select::-ms-expand {
	display: none;
}

#selectTable select {
	width: 180px; /* 원하는 너비설정 */
	height: 30px;
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 50%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

/* 글 작성 테이블 */
#contentFrame #writeTable {
	top: 19.5%;
	left: 12.8%;
	width: 1000px;
	margin: 0px 5px 5px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#writeTable #editable {
	height: 500px;
	text-align: left;
	border: 1px solid lightgray;
}

#writeTable input[type='text'] {
	width: 100%;
	height: 30px;
}

#writeTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#writeTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
	margin: 0px;
}

#writeTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#btnTable {
	left: 56%;
	top: 95%;
	position: absolute;
	margin: auto auto 50px auto;
}

input[type='text'] {
	width: 100%;
}

#savefund,#back,#frbtn,#fabtn {
	height: 40px;
	width: 107px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#fileUpBtn {
	left: 71%;
	top: -73px;
	height: 40px;
	width: 107px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
	position: absolute;
}

#editable {
	height: 400px;
	text-align: left;
	overflow: auto;
}

#attach {
	overflow: auto;
}

#attach img {
	width: 80px;
	height: 80px;
	float: left;
}

#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 150%;
	background: white;
}

#sideFrame{
    position: absolute;
    left: 0.52%;
    top: 12.4%;
    width: 14.7%;
    height: 250%;
    border-right: 1px solid gray;
    border-left: 1px solid gray;
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
	<div id="contentFrame">
  <div id=title>
				<h1 style="font-size: 30;">모금게시글 등록</h1></div>
		<form id="sendForm" action="./writefundbbs" method="post">
			<table id="selectTable">
				<tr>
					<th colspan=2 style="width: 1000px">필수 선택 항목</th>
				</tr>
			
				<tr>
					<td class="tap">지역</td>
					<td><input type="hidden" id="location" name="sido"> <select
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
					</select></td>
				</tr>
				</table>
				<table id="writeTable">
				 <tr>
               <th>작성자</th>
               <td><input id="sessionId" type ="text" value="${sessionScope.loginId}"  name="board_writer" readonly="readonly" /></td>
         </tr>
			
			 <tr>
            <th>제목</th>
            <td><input type="text" id="titlefund" name="board_title" /></td>
         </tr>
         

				<tr>
						<th colspan="2" style="width: 100px">내 용</th>
					</tr>
				<tr>
						<th id="noticef" colspan="2" style="background:#98C593;" >※동물사진 3장 , 영수증사진 1장 이상 첨부 필수※</th>
					</tr>	
					
					<tr>
						<td colspan="2">
						<!-- div 에서 내용을 받아 보여준다. -->
						<div id="editable" contenteditable="true"></div> <!-- 전송은 hidden 에 담아서 한다. -->
						<input id="contentForm" type="hidden" name="board_content" />

					</td>
				</tr>
<tr>
						<th colspan="2" style="background:#98C593">※병원 정보 등록 필수※</th>
					</tr>	
				<tr>
					<th style="width: 100px">동물 병원 정보</th>
					<td><input type="text" id="center" name="fund_centerName" /></td>
				</tr>
				

				<tr>
					<th colspan="2" style="width: 1000px">동물사진 첨부</th>
					</tr>
					<tr>
					<td colspan="3" style="height: 150px; border: 1px solid lightgray;">	<div id="animalList"></div></td>
			
				</tr>
				<tr>
				<td><input type="button" onclick="fileUp()" id="fabtn"
						value='사진 첨부' /></td>
				</tr>
				

				<tr>
					<th colspan="2" style="width: 1000px">영수증 사진 첨부</th>
					</tr>
					<tr>
					<td colspan="3" style="height: 150px; border: 1px solid lightgray;"><div id="receiptList"></div></td>
				</tr>
				<tr>
					<td><input type="button" onclick="photoUp()" value="사진 첨부"  id="frbtn"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<!-- ./ 현재의 루트 --> &nbsp;&nbsp; <input id="savefund" type="button"
						value="글 저장" />
							<input type="button" class="btn" id="back" value="취소">
						                    
					</td>
				</tr>
			</table>
		</form>
					</div>
		
	
</body>
<script>
var msg = "${msg}";
var menuName = {'구조후기':'saveMain', '모금':'fundMain'};
var photoChk=false;
$(document).ready(function() {
	var content = "";
	for(var key in menuName){
		console.log(key);
		content += "<div class='menuName'";
		content += "style='"
		if(key=='모금'){
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


//취소
$("#back").click(function() {
	location.href = "./fundMain";
});
   
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
      
            }
         },
         error:function(e){
            console.log(e);
         }
      });
   }
   

   var msg = "${msg}";
    var newFileName;   
   
   $("#savefund").click(function(){
      if($("#sido option:selected").html()=="선택"){
         $("#sido").focus();
         alert("지역을 선택해 주세요.");
         }
      else if($("#titlefund").val()==""){
    	  $("#titlefund").focus();
         alert("제목을 입력해 주세요."); 
         }
      else if($("#center").val()==""){
         $("#center").focus();
         alert("병원 정보를 입력해 주세요.");
    }
      else  if(!$("input:radio[name='main']").is(":checked")){
      $("input:radio[name='main']").focus();
      alert("대표이미지를 선택해 주세요.");
      }
      else if(checkonephoto()){
         $("#editable input[type='button']").remove();//삭제 버튼 제거
         $("#editable input[type='checkbox']").remove();//체크박스 버튼 제거
         $("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
         $("#location").val($("#sido option:selected").html());
         $("#sendForm").submit();
      }else{
         alert("※동물사진 3개이상, 영수증 사진 1개 이상 등록해주세요※");
      }  
 
  

   
      
   });
      

  
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










