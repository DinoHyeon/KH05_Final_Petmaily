<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>보호 게시글 작성</title>
<style>
input[type='text'] {
   width: 100%;
}

/* 타이틀 */
#title h1 {
   top: 2%;
   left: 39%;
   margin: 50px 0px 25px 0px;
   text-align: center;
   color: #28977B;
   font-weight: 700;
   position: absolute;
}

#title h5 {
   top: 16%;
   left: 54.5%;
   margin: 10px 0px 40px 0px;
   text-align: right;
   color: black;
   font-weight: 700;
   font-size: 10;
   position: absolute;
}

/* 셀렉트박스 테이블 */
#contentFrame  #selectTable {
   top: 16.5%;
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
   top: 30%;
   left: 13%;
   width: 1000px;
   margin: 0px 5px 5px 5px;
   border-collapse: collapse;
   padding: 5px 10px;
   position: absolute;
}

#writeTable #editable {
   height: 300px;
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
   left: 62%;
   top: 92%;
   position: absolute;
   margin: auto auto 50px auto;
}

.btn {
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

#attachArea {
   padding: 1%;
   float: left;
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
</style>
</head>
<body>
   <jsp:include page="mainFrame.jsp" />
   <div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
      <center>
         <div id=title>
            <h1 style="font-size: 30;">보호 동물 등록</h1>
            <h5>보호중인 동물을 등록합니다, 동물의 종류와 품종, 보호중인 지역을 선택해 주세요</h5>
         </div>
      </center>
      <form id="protectSend" action="protectWrite" method="post">
         <table id="selectTable">
            <tr>
               <th colspan=2 style="width: 1000px">필수 선택 항목</th>
            </tr>
            <td class="tap">지역</td>
            <td><select id="sido" onchange="getSigungu()">
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
                  <option value="">선택</option>
            </select> <input type="hidden" id="location" name="sido"></td>
            </tr>
            <tr>
               <td class="tap">동물</td>
               <td>
                  <!-- 동물종 --> <select id="animal" onchange="getAnimalType()">
                     <option value="">선택</option>
                     <option value="417000">개</option>
                     <option value="422400">고양이</option>
                     <option value="429900">기타</option>
                     <input type="hidden" id="selectAnimal" name="animal">
               </select> <!-- 품종 --> <select id="animalType" name="animalType">
                     <option value="">선택</option>
               </select>
               </td>
            </tr>
         </table>

         <table id="writeTable">
            <tr>
               <th style="width: 100px">작성자</th>
               <td><input id="board_writer" type="text" name="board_writer"
                  readOnly value="${loginId}" /></td>
            </tr>

            <tr>
               <th style="width: 100px">제목</th>
               <td><input type="text" name="board_title" id="bTitle"/></td>
            </tr>
            <tr>
               <th colspan="2" style="width: 1000px">내 용</th>
            </tr>
            <tr>
               <td colspan="2">
                  <div id="editable" contenteditable="true"></div> <input
                  id="contentForm" type="hidden" name="board_content" />
               </td>
            </tr>

            <tr>
               <th colspan="2" style="width: 1000px">사진 첨부</th>
            </tr>
            <tr>
               <td colspan="3" style="height: 150px; border: 1px solid lightgray;">
                  <div id="attach"><h4>이미지 파일만 등록해 주세요.</h4></div>
               </td>
            </tr>

         </table>
         <table id="btnTable">
            <tr>
               <td>
                  <center>
                     <input type="button" class="btn" id="fileUpBtn"
                        onclick="fileUp()" value="첨부" />
                     <c:if test="loginId == null">
                        <input id="pass" name="pass" type="password" placeholder="비밀번호"
                           style="height: 35px;" />
                     </c:if>
                     <input type="button" class="btn" id="btn_protectWrite" value="등록">
                     <input type="button" class="btn" id="back" value="취소">
                  </center>
               </td>
            </tr>
         </table>
      </form>
   </div>
</body>
<script>
   var menuName = {
      '실종' : 'missingList',
      '보호' : 'protectList'
   };
   $(document).ready(function() {
      var content = "";
      for ( var key in menuName) {
         console.log(key);
         content += "<div class='menuName'";
         content += "style='"
         if (key == '보호') {
            content += "background:#28977B;color:white;font-weight: 600;";
         }
         content += "cursor: pointer'";
         content += "onclick='pageMove(this)' id=" + menuName[key] + ">";
         content += key;
         content += "</div>";
      }
      ;

      $("#sideMenu").empty();
      $("#sideMenu").append(content);
   });

   function pageMove(e) {
      console.log($(e).attr("id"));
      location.href = "./" + $(e).attr("id");
   };
   //지역
   function getSigungu() {
      console.log();
      $.ajax({
         "url" : "./getSigungu",
         "type" : "get",
         "data" : {
            "sidoCode" : $("#sido").val()
         },
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
         "data" : {
            "animalCode" : $("#animal").val()
         },
         "success" : function(data) {
            console.log(data);
            var content = "";
            data.forEach(function(item) {
				var selAni = item.animalType.replace(/ /gi, "");
				content += "<option value="+selAni+">";
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
   function pDel(elem) {
      var fileName = elem.id.split("/")[2];
      $.ajax({
         url : "./pFileDel",
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

   /* 사진 체크 */
   function pcheckphoto() {
      var photoChk;
      $.ajax({
         url : "./pcheckphoto",
         type : "get",
         async : false,
         success : function(data) {
            photoChk = data;
         },
         error : function(e) {
            console.log(e);
         }
      });

      return photoChk;

   }

   //파일 업로드 창
   function fileUp() {
      var myWin = window.open("./puploadForm", "파일 업로드",
            "width=300, height=150");
   }

   //취소
   $("#back").click(function() {
      location.href = "./protectList";
   });

   //게시글 등록 버튼
   $("#btn_protectWrite").click(function() {
      if ($("#sido option:selected").html() == "선택") {
         $("#sido").focus();
         alert("지역을 선택해 주세요.");
      } else if ($("#animal option:selected").html() == "선택") {
         $("#animal").focus();
         alert("동물종을 선택해 주세요.");
      } else if ($("#bTitle").val() == "") {
         $("#bTitle").focus();
         alert("제목을 입력해 주세요.");
      } else if (!pcheckphoto()) {
         alert("파일을 1개이상 등록해주세요.");
      } else if (!$("input:radio[name='main']").is(":checked")) {
         $("input:radio[name='main']").focus();
         alert("대표이미지를 선택해 주세요.");
      } else if ($("#pass").val() == "") {
          $("#pass").focus();
          alert("비밀번호를 입력해 주세요.");
      }else {
         $("#editable input[type='button']").remove();//삭제 버튼 제거
         $("#editable input[type='checkbox']").remove();//체크박스 버튼 제거
         $("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
         $("#location").val($("#sido option:selected").html());
         $("#selectAnimal").val($("#animal option:selected").html());
         $("#protectSend").submit();
      }
   });
</script>
</html>