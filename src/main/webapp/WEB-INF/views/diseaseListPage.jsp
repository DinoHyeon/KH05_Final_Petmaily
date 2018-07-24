<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>질병리스트</title>
		<style>
			h3{
				padding: 20px 600px 5px 740px;
			}
		
			.table_style li{ 
				list-style:none;
			}
			
			li > ul{ 
				display:none;	
			}
		
			.table_style { 
				width:2000px; position:relative; padding-top:10px;
			}

			.table_style ul {
				clear: left;
				margin: 0;
				padding :0;
				list-style-type: none;
			}
		
			.table_style ul.header li {
				font-weight:bold;
				text-align:center;
			}

			.table_style ul li {
				float: left;
				margin: 0;
				padding: 2px 1px;
				border : 1px solid black;
			}
			
			.table_style ul .column {
				width: 60px;
			}
	
			#diseaseList{
				padding: 10px 220px;
			}
	
			#text{
				width: 1000px;
			}
	
			h1{
				font-size: 10pt;
			}
	
			#detail{
				border-right:none;
				border-left:none;
				border-top:none;
				border-bottom:none;
			}
			#contentFrame {
   position: absolute;
   left: 15.52%;
   top: 12.5%;
   width: 82.95%;
   height: 95%;
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
		<h3>질병 리스트</h3>
		<hr>
		
		<form id="diseaseList" action="">
			<div class="table_style">
				<ul class="header">
					<li class="column1" id="text">품종-질병</li>
				</ul>
				<c:forEach items = "${SearchList}" var = "SearchList">
					<ul>
						<li class="column" id="text">
							<h1>품종: ${SearchList.animal}&nbsp;&nbsp;/&nbsp;&nbsp;질병:<c:out value="${SearchList.disease_name}" />▼</h1>
							<ul>
								<li id="detail">${SearchList.define}</li>
							</ul>
						</li>
					</ul>			
				</c:forEach>
			</div>
		</form> 
		</div>
	</body>
	<script>
	var menuName = {'보호소센터 찾기':'searchShelter', '퀴즈':'quizSetting', '질병':'diseaseMain', '커뮤니티':'communityMain'};
		$(function(){
			$(".table_style h1").click(function(){
				$(".table_style ul ul").slideUp();
				
				if(!$(this).next().is(":visible")) {
					$(this).next().slideDown();
				}
			});
		});
		
		$(document).ready(function() {
			var content = "";
			for(var key in menuName){
				console.log(key);
				content += "<div class='menuName'";
				content += "style='"
				if(key=='질병'){
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
	
	</script>
</html>










