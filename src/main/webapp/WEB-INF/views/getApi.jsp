<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.css">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.theme.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/plugIn/jquery-ui.js"></script>
<title>Insert title here</title>
</head>
<body>
	<select id="sido" onchange="getSigungu()">
		<option></option>
	</select>

	<select id="sigundo">
		<option></option>
	</select>

	<select id="animal" onchange="getAnimalType()">
		<option value="417000">개</option>
		<option value="422400">고양이</option>
		<option value="429900">기타</option>
	</select>
	
	<select id="animalType">
		<option></option>
	</select>
	
	
	
	
	<!-- 지역에 따른 보호소 검색 -->
	<input type="button" onclick="getShelter()" value="검색"> 
	결과 :<select id="shelter">
	</select>
	
	
	
</body>
<script>
	$(document).ready(function() {
		//버튼화
		$("input[type='button']").button();
		$( "#sido" ).selectmenu({
			change: function( event, ui ) {
				getSigungu();
			}
		});
		$( "#sigundo" ).selectmenu();
		$( "#animal" ).selectmenu({
			change: function( event, ui ) {
				getAnimalType();
			}
		}).selectmenu( "menuWidget" ).addClass( "overflow" );
		$( "#animalType" ).selectmenu();
		
		$.ajax({
			"url" : "./getSido",
			"type" : "get",
			"success" : function(data) {
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.sidoCode+">";
					content += item.sidoName;
					content += "</option>";
				});
				
				$("#sido").empty();
				$("#sido").append(content);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	});
	
	function getSigungu() {
		console.log($("#sido").val())
		$.ajax({
			"url" : "./getSigungu",
			"type" : "get",
			"data" : {"sidoCode" : $("#sido").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.sigundoCode+">";
					content += item.sigundoName;
					content += "</option>";
				})
				$("#sigundo").empty();
				$("#sigundo").append(content);
				
				$( "#sigundo" ).selectmenu( "destroy" );
				$( "#sigundo" ).selectmenu();
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
	function getAnimalType() {
		$.ajax({
			"url" : "./getAnimalType",
			"type" : "get",
			"data" : {"animalCode" : $("#animal").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.animalCode+">";
					content += item.animalType;
					content += "</option>";
				})
				$("#animalType").empty();
				$("#animalType").append(content);
				
				$( "#animalType" ).selectmenu( "destroy" );
				$( "#animalType" ).selectmenu();
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
	function getShelter() {
		$.ajax({
			"url" : "./getShelter",
			"type" : "get",
			"data" : {
				"sidoCode" : $("#sido").val(),
				"sigundoCode" : $("#sigundo").val()
				},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.shelterCode+">";
					content += item.shelterName;
					content += "</option>";
				})
				$("#shelter").empty();
				$("#shelter").append(content);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
</script>
</html>