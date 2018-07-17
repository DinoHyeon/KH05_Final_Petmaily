<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=672cd5bbb388875a20f43c78deb73240"></script>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<div id="contentFrame">
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
		<input type="button" onclick="shelterList(showPageNum)" value="검색">
		<table>
			<thead>
				<tr>
					<th>지역</th>
					<th>보호소 이름</th>
				</tr>
			</thead>
			<tbody	id="shelter">
			</tbody>
		</table>
			
		<div id="paging"></div>
			
			
		<div id="map" style="width:500px;height:400px;"></div>
	</div>
</body>
<script>
var showPageNum = 1;

$(document).ready(function() {
	shelterList(showPageNum);
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

function shelterList(page) {
	$.ajax({
		"url" : "./shelterList",
		"type" : "get",
		"data" : {
					"sido":$("#sido option:selected").html(),
					"sigundo":$("#sigundo").val(),
					"page":page
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
	data.list.forEach(function(item) {
		var location = item.roadAddr.split(' ');
		content += "<tr>";
		content += "<td>" + location[0]+" "+ location[1] + "</td>";
		content += "<td><span onclick='sehelterDetail(this)' id='"+item.centerName+"'>"+item.centerName+"</span></td>";
		content += "</tr>";
	})
	$("#shelter").empty();
	$("#shelter").append(content);
	
	$("#paging").zer0boxPaging({
        viewRange : 5,
        currPage : data.currPage,
        maxPage : data.pageCnt,
        clickAction : function(e){
        	shelterList($(this).attr('page'));
        }
    });
}

function sehelterDetail(name) {
	$.ajax({
		"url" : "./shelterDetail",
		"type" : "get",
		"data" : {"centetName" : $(name).attr("id")},
		"success" : function(data) {
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new daum.maps.LatLng(data.x, data.y), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new daum.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new daum.maps.ZoomControl();
			map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
			
			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new daum.maps.Marker({ 
			    // 지도 중심좌표에 마커를 생성합니다 
			    position: map.getCenter() 
			}); 
			// 지도에 마커를 표시합니다
			marker.setMap(map);
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}

</script>
</html>