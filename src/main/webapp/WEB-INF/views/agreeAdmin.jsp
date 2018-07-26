<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지 승인대기</title>
<style>
table {
   border-collapse: collapse;
   padding: 0.6% 1.5%;
   margin: 17% 1% 10.5% 44%;
   text-align: center;
}

td{
color:white;
    padding: 0.6% 1.5%;
   margin: 17% 1% 10.5% 44%;
   text-align: center;
}
table, tr {
   border: 1px solid gray;
}

th{
   border: 1px solid gray;
background-color: #217D65;
   color:white;
      padding: 0.6% 1.5%;
   margin: 17% 1% 10.5% 44%;

}
#noreason {
   resize: none;
   width: 250px;
   height: 200px;
}

.ui-widget.success-dialog {
   font-family: Verdana, Arial, sans-serif;
   font-size: .8em;
}

.ui-widget-content.success-dialog {
   background: #F9F9F9;
   border: 1px solid #90d93f;
   color: #222222;
}

.ui-dialog.success-dialog {
   left: 0;
   outline: 0 none;
   padding: 0 !important;
   position: absolute;
   top: 0;
}

.ui-dialog.success-dialog .ui-dialog-content {
   background: none repeat scroll 0 0 transparent;
   border: 0 none;
   overflow: auto;
   position: relative;
   padding: 0 !important;
   margin: 0;
}

.ui-dialog.success-dialog .ui-widget-header {
   background: #b0de78;
   border: 0;
   color: #fff;
   font-weight: normal;
}

.ui-dialog.success-dialog .ui-dialog-titlebar {
   padding: 5 0;
   position: relative;
   font-size: 14px;
   font-weight: 600;
   color: black;
}

#agree{
   position: absolute;
   right: 26%;
   top: -16%;
   width: 59.95%;
   height: 6%;
   background: white;

}
#idx {
   font-size: 29px;
   font-weight: 600;
   position: absolute;
   top: 10%;
   left: 20%;
}

#noreason {
   position: absolute;
   top: 10%;
   left: 20%;
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
input[value='보내기']{
   position: absolute;
   top: 87%;
   left: 42%;   
}

#text{
    position: absolute;
    top: 2%;
    left: 43%;
}
#paging{
position: absolute;
   left: 38%;
   top: 80.4%;
   width: 15%;

}
   #agreeTable a:link{
         text-decoration: none;
         color: black;
         
      }
      
#title1 h1 {
   top: 0%;
   left: 38%;
   margin: 50px 0px 25px 0px;
   text-align: center;
   color: #A9CB73;
   font-weight: 700;
   font-size: 40;
   position: absolute;
}      
</style>
</head>
<body>
   <jsp:include page="mainFrame.jsp" />
      <div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
      <div id=title1>
      <h1>모금글 관리</h1>
            
   </div>
   <table id="agree">
      <thead>
         <tr>
            <th style=width:10%>글번호</th>
            <th>글제목</th>
          
            <th>[승인/거부]</th>
         </tr>
      </thead>
      <tbody id="agreeTable">
      </tbody>

   </table>
   <div id="paging"></div>


   <div id="agreedialog">

      <span id="idx"></span><br>
      <span id="text">거절사유</span>
      <textarea id="noreason"></textarea>
      <input type="button" class="send" value="보내기">
   </div>
</div>


</body>
<script>
   var showPageNum = 1
   var menuName = {
         '회원관리' : 'memberlist',
         '모금글관리' : 'agreeAdmin',
         '퀴즈등록' : 'quizMain'
      };
   $(document).ready(function() {
      var content = "";
      for ( var key in menuName) {
         console.log(key);
         content += "<div class='menuName'";
         content += "style='"
         if (key == '모금글관리') {
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
      
      
      $("input[type=button]").button();
      
      agreelistCall(showPageNum);
      $('#agreedialog').dialog({
         title : '　 승인 거부',
         autoOpen : false,
         modal : true,
         width : '400',
         height : '305',
         dialogClass : 'no-close success-dialog'
      });
   });

   function pageMove(e) {
      console.log($(e).attr("id"));
      location.href = "./" + $(e).attr("id");
   };
   function agreelistCall(page) {
      $.ajax({
         type : "get",
         url : "./getagreeList",
         data : {
            "showPageNum" : page
         },
         success : function(data) {
            agreelistPrint(data);
            showPageNum = data.currPage; //보여지는 페이지 = 현재 페이지 (data.currPage)

         },
         error : function(e) {
            console.log(e);
         }
      });
   }

   function agreelistPrint(data) {

      var content = "";
      data.list
            .forEach(function(item) {
               content += "<tr>";
               content += "<td style='background:#217D65'>" + item.board_idx + "</td>";
               content += "<td><a href='funddetail?idx=" + item.board_idx
                     + "&call=detail' style='color: black'>"
                     + item.board_title + "</a></td>";
             
               content += "<td><input class='yes' type='button' value='승인' id="+ item.board_idx +"><input class='no' type='button' value='거부' id="
                     + item.board_idx + "></td>";
               content += "</tr>";
            })
      $("#agreeTable").empty();
      $("#agreeTable").append(content);
      
      $(".no").button();
      $(".yes").button();
      
      $( ".no" ).button( "refresh" );
      $( ".yes" ).button( "refresh" );
      
      $("#paging").zer0boxPaging({
         viewRange : 5,
         currPage : data.currPage,
         maxPage : data.range,
         clickAction : function(e) {
            agreelistCall($(this).attr('page'));
         }
      });
   }

   /*승인 버튼 클릭시 승인대기->승인  */
   $(document).on('click', '.yes', function(event) {
      var agree = confirm("승인하시겠습니까?");
      if (agree) {
         $.ajax({
            "type" : "get",
            "url" : "./agreeAd",
            "data" : {
               idx : $(event.target).attr("id")
            },
            "success" : function(data) {
               console.log(data);
               if (data) {
                  agreelistCall(showPageNum);
                  $("#reason").html(data);
               } else {
                  alert("불러오기 실패!")
               }
            }

         });
      }
   });

   $(document).on('click', '.no', function(event) {
      $('#agreedialog').dialog("open");

      $.ajax({
            "type" : "get",
            "url" : "./sendno",
            "data" : {
               idx : $(event.target).attr("id")
            },
            "success" : function(data) {
               $("#idx").html(data);
            }
         });
      });
       
   //소현: 관리자 페이지 승인 리스트 거부 버튼 클릭시 거절사유 전송
   
   
   $(".send").click(function(event) {
      $.ajax({
         "type" : "get",
         "url" : "./sendreason",
         "data" : {
            idx : $("#idx").text(),
            reason : $("#noreason").val()
         },
         "success" : function(data) {

            if (data) {

               $('#agreedialog').dialog('close');
               agreelistCall(showPageNum);
               alert("거절 사유 전송을 완료했습니다.!")

            } else {
               alert("불러오기 실패!")
            }
         }

      });
   });

</script>

</html>