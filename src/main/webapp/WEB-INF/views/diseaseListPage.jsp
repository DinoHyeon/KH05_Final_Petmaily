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
   </body>
   <script>
   
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
                  diseaseList(e.currentTarget.innerHTML);
              }
           });  
           
      });
      
      
      function diseaseList(page) {
         
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
                     console.log("에러!!");
                     diseaseList(data.currPage+1);
                  }else{
                     diseaseList(e.currentTarget.innerHTML);      
                  }
                      
               }
           });
      }
   </script>
</html>








