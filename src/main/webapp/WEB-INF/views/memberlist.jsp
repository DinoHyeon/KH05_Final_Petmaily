<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지 회원 상태 리스트</title>
<style>
table {
   border-collapse: collapse;
   padding: 0.6% 1.5%;
   margin: 17% 1% 10.5% 44%;
   text-align: center;
}

td{
color: black;
    padding: 0.6% 1.5%;
   margin: 17% 1% 10.5% 44%;
   text-align: center;
}
 tr {
   border: 1px solid gray;
   
   
}

th{
   border: 1px solid gray;


background-color: #217D65;
   color:white;
      padding: 0.6% 1.5%;
   margin: 17% 1% 10.5% 44%;

}

/*button css  */
.delmem{
  background:#1AAB8A;
   border:none;
 width:59%;

}

.delmem:hover{
  background:#fff;
  color:#1AAB8A;
}
.delmem:before,.delmem:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #1AAB8A;
  transition:400ms ease all;
}
.delmem:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
.delmem:hover:before,.delmem:hover:after{
  width:100%;
  transition:800ms ease all;
}

#member{
   position: absolute;
   right: 24%;
   top: -15.5%;
   width: 59.95%;
   height: 6%;
   background: white;

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
#paging{
position: absolute;
   left: 39.52%;
   top: 82.4%;
   width: 15%;
}
/* 첫번째 타이틀 */
#title1 h1 {
   top: 0%;
   left: 40%;
   margin: 50px 0px 25px 0px;
   text-align: center;
   color: #A9CB73;
   font-weight: 700;
   font-size: 40;
   position: absolute;
}
.ui-widget-content {
    background: #F9F9F9;
    border: 1px solid #90d93f;
    color: #222222;
}
</style>
</head>
<body>
   <jsp:include page="mainFrame.jsp"/>
   <div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
   <div id=title1>
            <h1>회원관리</h1>
            
         </div>
   <table id="member">
   <thead>
      <tr>
               <th>아이디</th>
               <th>이름</th>
               <th>이메일</th>
               <th>상태</th>
               <th>추방</th>
               
            </tr>
            </thead>
                  <tbody id="memberTable">
         </tbody>
   </table>
      <div id="paging" >
   </div>
   </div>
</body>
<script>

var obj = {};      
obj.type="get";
obj.dataType="json";
obj.error=function(e){console.log(e)};
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
      if (key == '회원관리') {
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
   
   memberlistCall(showPageNum)

});

function pageMove(e) {
   console.log($(e).attr("id"));
   location.href = "./" + $(e).attr("id");
};

function memberlistCall(page){
   $.ajax({
      type : "get",
      url : "./getmemberList",
      data : {
         "showPageNum" : page
      },
      success : function(data) {
         console.log(data.currPage);
         memberlistPrint(data);
         showPageNum=data.currPage;  //보여지는 페이지 = 현재 페이지 (data.currPage)
      },
      error : function(e) {
         console.log(e);
      }
   });
}



function memberlistPrint(data) {
   
   var content = "";
      data.list.forEach(function(item,idx) {
      content += "<tr>"; 
      content += "<td>" + item.member_id + "</td>";
      content += "<td>" + item.member_name + "</td>";
      content += "<td>" + item.member_email+ "</td>";
      content += "<td>" + item.member_state +"</td>";
        if(item.member_state=='member'){
         content+="<td><input class='delmem' type='button' value='추방'  onclick='delmember(id)' id="+ item.member_id +"></td>";
        }   
        else{
          content+="<td></td>";
        }   
         content += "</tr>"; 
      })
      $("#memberTable").empty();
      $("#memberTable").append(content); 
      
      $("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
                memberlistCall($(this).attr('page'));
            }
        });
      
   }      

/*회원 추방 버튼 onclick */
function delmember(id) {
   var del = confirm("추방시키겠습니까?");
    if(del){   
   console.log("추방");
   console.log(id);
   obj.url = "./changeState";
   obj.data = {
      idx : id
   };
   obj.success = function(data) {
      console.log(data);
   
      if (data==1) {
      
            memberlistCall(showPageNum);
      }
    else {
         alert("삭제 실패")
      }
   }
   ajaxCall(obj);

    }
};
   


function ajaxCall(param){
   console.log(param);
   $.ajax(param);
}



</script>

</html>