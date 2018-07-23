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
		</style>		
	</head>
	<body>
 		<jsp:include page="mainFrame.jsp" />
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
	</body>
	<script>
		$(function(){
			$(".table_style h1").click(function(){
				$(".table_style ul ul").slideUp();
				
				if(!$(this).next().is(":visible")) {
					$(this).next().slideDown();
				}
			});
		});
	</script>
</html>










