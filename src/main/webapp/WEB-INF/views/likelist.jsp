<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지 즐겨찾기 리스트 출력 </title>
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
   height: 30%;
}
 tr {
   border: 1px solid gray;
   
   
}

th{
   border: 1px solid gray;


background-color: #217D65;
	color:white;
	   padding: 2.6% -0.5%;
   margin: 17% 1% 10.5% 44%;

}
#tlike{

position:absolute;
top:-11%;
left:-28%;

}

.heart {
  width: 100px;
  height: 100px;
  top:30px;
  left:10px;
  transform: translate(-4px, -4px);
  background: url("resources/img/heart.png") repeat;  
  
  cursor: pointer;
 
}
.heart-blast {
  background-position: -2800px 0;
  transition: background 1s steps(28);
  
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
   left: 36.52%;
   top: 147.4%;
   width: 15%;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
	<div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
	<table id="tlike">
			<thead>
				<tr>
				    <th style="width: 200px">즐겨찾기 번호</th>
			
					<th style="width: 200px">게시판 제목</th>
					<th style="width: 200px">글제목</th>
					<th style="width: 200px">작성자</th>
					<th style="width: 100px">찜</th>
				</tr>
				</thead>			
				<tbody id="likelistTable">
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
		'내정보' : 'memberUpdateForm',
		'내가작성한모금게시글' : 'mylist',
		'즐겨찾기' : 'likelist'
	};
/* 즐겨찾기 리스트 */
$(document).ready(function() {
	var content = "";
	for ( var key in menuName) {
		console.log(key);
		content += "<div class='menuName'";
		content += "style='"
		if (key == '즐겨찾기') {
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
	 likelistCall(showPageNum);
});
function pageMove(e) {
	console.log($(e).attr("id"));
	location.href = "./" + $(e).attr("id");
};

function likelistCall(page){
	$.ajax({
		type : "get",
		url : "./getlikeList",
		data : {
			"showPageNum" : page
		},
		success : function(data) {
			likelistPrint(data);
			showPageNum=data.currPage;  //보여지는 페이지 = 현재 페이지 (data.currPage)

		},
		error : function(e) {
			console.log(e);
		}
	});
}



function likelistPrint(data) {
		var content = "";
	   data.list.forEach(function(item) {
		content += "<tr>"; 
		content += "<td>" + item.favorite_idx + "</td>";
		content += "<td>" + item.board_type + "</td>";
        if(item.board_type=='보호'){
		content += "<td><a href='protectDetail?board_idx="+item.board_idx+"&call=detail' style='color: black'>"+ item.board_title +"</a></td>";
	      }
        if(item.board_type=='실종'){
    		content += "<td><a href='missingDetail?board_idx="+item.board_idx+"&call=detail' style='color: black'>"+ item.board_title +"</a></td>";
    		
            }
		content += "<td>" + item.board_writer + "</td>";
		content += "<td><div class='heart' id="+ item.favorite_idx +"></div></td>";
     	content += "</tr>"; 
			
		})
		$("#likelistTable").empty();
		$("#likelistTable").append(content); 
		
		$(".heart").toggleClass("heart-blast");
		
		$("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
            	 likelistCall($(this).attr('page'));
            }
        });
	}	
	
	
/*즐겨찾기 해제 */	
	$(document).on('click', '.heart', function() {	

		   $(this).toggleClass("heart-blast");
			console.log("삭제");
			var idx = $(this).attr("id");
			
			console.log(idx);
			obj.url = "./delLikelist";
			obj.data = {
				idx : idx
			};
			obj.success = function(data) {
				console.log(data);
				if (data==1) {
					alert("즐겨찾기 해제")
                    likelistCall(showPageNum);
				
				}
			}
			ajaxCall(obj);
  
		  });

	


function ajaxCall(param){
	console.log(param);
	$.ajax(param);
}




</script>

</html>