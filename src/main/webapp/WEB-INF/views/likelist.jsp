<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지 즐겨찾기 리스트 출력 </title>
<style>
table, th, td {
	border-collapse: collapse;
	padding: 6px 23px;
	margin: 170px 10px 105px 440px;
	text-align: center;
}
table, tr{
		border: 1px solid black;


}

.heart {
  width: 100px;
  height: 100px;
  position: absolute;
  left: 93%;
  top: 22%;
  transform: translate(-50%, -50%);
  background: url("resources/img/heart.png") repeat;  
  
  cursor: pointer;
 
}
.heart-blast {
  background-position: -2800px 0;
  transition: background 1s steps(28);
  
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
	<table>
			<thead>
				<tr>
				    <th>즐겨찾기 번호</th>
		
			
					<th>게시판 제목</th>
					<th>글제목</th>
					<th>작성자</th>
					<th>찜</th>
				</tr>
				</thead>			
				<tbody id="likelistTable">
			</tbody>
	</table>
	<div id="paging" >
	</div>
</body>
<script>

var obj = {};		
obj.type="get";
obj.dataType="json";
obj.error=function(e){console.log(e)};
var showPageNum = 1

/* 즐겨찾기 리스트 */
$(document).ready(function() {
	 likelistCall(showPageNum);
});


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
		content += "<td><a href='funddetail?idx="+item.board_idx+"&call=detail' style='color: blue'>"+ item.board_title +"</a></td>";
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