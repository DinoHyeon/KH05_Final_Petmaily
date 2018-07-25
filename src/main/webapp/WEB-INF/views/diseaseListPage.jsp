<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
      <title>질병리스트</title>
      <style>
      #sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 100%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}
      
         .table_style li{ 
            list-style:none;
         }
         
         li > ul{ 
            display:none;   
         }
      
         .table_style { 
         
			position:absolute;
			left:12%;
            width:80%;
             padding-top:10px;
         }
         
         #paging { 
            width:1000px; padding-top: 100px;
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
   
         .detail{
            border-right:none;
            border-left:none;
            border-top:none;
            border-bottom:none;
         }
         
           #list h1{
            cursor:pointer;
         } 
         			#contentFrame {
   position: absolute;
   left: 15.52%;
   top: 12.5%;
   width: 82.95%;
   height: 95%;
   background: white;
   text-align:center;
}
		#contentFrame h2{
		color:#28977B;
		}
		#paging{
		position:absolute;
		top:100%;
		left:10%;
		}
      </style>      
   </head>
   <body>
       <jsp:include page="mainFrame.jsp" />
       <div id="sideFrame"></div>
		<jsp:include page="sideMenu.jsp" />
		 <div id="contentFrame">
      <h2>질병 리스트</h2>
      <hr/>
      
      <form id="diseaseList" action="">
         <div class="table_style">
            <ul class="header">
               <li class="column1" id="text">품종-질병</li>
            </ul>
            <div id="list">
            <c:forEach items = "${SearchList}" var = "SearchList">
               <ul>
                  <li class="column" id="text">
                     <h1>품종: ${SearchList.animal}&nbsp;&nbsp;/&nbsp;&nbsp;질병:<c:out value="${SearchList.disease_name}" />▼</h1>
                     <ul>
                        <li class="detail">${SearchList.define}</li>
                     </ul>
                  </li>
               </ul>         
            </c:forEach> 
            </div>
         </div>
      </form> 
         <div id="paging">
         </div>
         </div>
   </body>
   <script>
   
   var menuName = {'보호소센터 찾기':'searchShelter', '퀴즈':'quizSetting', '질병':'diseaseMain', '커뮤니티':'communityMain'};

	var keyArr = [];
	var i;
	
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
   
   var title="${title}";//어떤 검색을 통해 넘어왔는가
   console.log("title",title);
   
   $(document).on('click', '#list h1', function() {   
      console.log("클릭");
       $("#list ul ul").slideUp();
       
       if(!$(this).next().is(":visible")) {
          $(this).next().slideDown();
       }
   });
         
      var showPageNum = 1;
      var page=1;
      $(document).ready(function() {
          $("#paging").zer0boxPaging({
               viewRange : 5,
               currPage : ${currPage},
               maxPage : ${range},
               clickAction : function(e){
            	   if(title=="key"){
            		   console.log(e.currentTarget.innerHTML);
            		   keyList(e.currentTarget.innerHTML);
            	   }else if(title=="search"){
            		   diseaseList(e.currentTarget.innerHTML);
            	   }
                  
              }
           });  
           
      });
      
      
      function diseaseList(page) {//수동 입력 검색일 경우
         
         $.ajax({
            type : "get",
            url : "./diseaseSearchListPage2",
            data : {
               "showNum" : page
            },
            success : function(data) {
               listPrint(data);

            },
            error : function(e) {
               console.log(e);
            }
         });
      }
      
      function keyList(page) {//버튼 클릭 검색일 경우
          $.ajax({
             type : "get",
             url : "./diseaseKeywordListPage2",
             data : {
                "showNum" : page
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
         
         var content ="";
          
         console.log(data);
       
          data.SearchList.forEach(function(item) {
             content += "<ul>";
             content += "<li class='column' id='text'>";
             content += "<h1>품종:"+item.animal+"&nbsp;&nbsp;/&nbsp;&nbsp;질병:"+item.disease_name+"▼</h1>";
             content += "<ul>";
             content += "<li id='detail'>"+item.define+"</li>";
             content += "</ul>";
             content += "</li>";
             content += "</ul>";
          })
          
          $("#list").empty();
          $("#list").append(content); 
         
           $("#paging").zer0boxPaging({
               viewRange : 5,
               currPage : data.currPage,
               maxPage : data.range,
               clickAction : function(e){
                  if(e.currentTarget.innerHTML=="Next"){
	              	   if(title=="key"){
	            		   keyList(data.currPage+1);
	            	   }else if(title=="search"){
	            		   diseaseList(data.currPage+1);
	            	   }
                  }else{
	              	   if(title=="key"){
	              		 	keyList(e.currentTarget.innerHTML);
	            	   }else if(title=="search"){
	            		   diseaseList(e.currentTarget.innerHTML);
	            	   }
                  }
               }
           });
      }
   </script>
</html>








