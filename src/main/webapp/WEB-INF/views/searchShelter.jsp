<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style>
table {
	margin: 10px 10px;
	padding: 10px 0;
}

table, tr, th , td{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}
</style>
</head>
<body>
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
      <option value="">선택</option>
   </select>
   <input type="button" onclick="shelterList()" value="검색">
   <table>
      <thead>
         <tr>
            <th>지역</th>
            <th>센터 이름</th>
            <th>전화 번호</th>
         </tr>
      </thead>
      <tbody   id="shelter">
      </tbody>
   </table>
</body>
<script>
$(document).ready(function() {
   shelterList();
});

function getSigungu() {
   $.ajax({
      "url" : "./getSigungu",
      "type" : "get",
      "data" : {"sidoCode" : $("#sido").val()},
      "success" : function(data) { 
         var content = "";
         content += "<option value=''>전체</option>"
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

function shelterList() {
	$.ajax({
		"url" : "./shelterList",
		"type" : "get",
		"data" : {
					"sido":$("#sido option:selected").html(),
					"sigundo":$("#sigundo").val()
				},
		"success" : function(data) {
			listPrint(data);
			console.log(data);
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}

function listPrint(data) {
   var content = "";
   data.forEach(function(item) {
      var location = item.roadAddr.split(' ');
      content += "<tr>";
      content += "<td>" + location[0]+" "+ location[1] + "</td>";
      content += "<td><span onclick='sehelterDetail(this)' id='"+item.centerName+"'>"+item.centerName+"</span></td>";
      content += "<td>" + item.phoneNum + "</td>";
      content += "</tr>";
   })
   $("#shelter").empty();
   $("#shelter").append(content);
}

function sehelterDetail(name) {
   $.ajax({
      "url" : "./shelterDetail",
      "type" : "get",
      "data" : {"centetName" : $(name).attr("id")},
      "success" : function(data) {
         console.log(data);
      },
      "error" : function(x, o, e) {
         alert(x.status + ":" + o + ":" + e);
      }
   });
}

</script>
</html>