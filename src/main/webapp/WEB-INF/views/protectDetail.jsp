<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 250%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

#conDiv {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 150%;
	background: white;
}
/* 타이틀 */
#conDiv h1 {
	left: 39%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}

#conDiv table, th, td {
	border: 1px solid gray;
	border-collapse: collapse;
	padding: 6px 15px;
	text-align: center;
}

#conDiv td {
	text-align: center;
}
/* 글 테이블 */
#detailTable {
	top: 14%;
	left: 11%;
	width: 1000px;
	margin: 0px 5px 5px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#detailTable input[type='text'] {
	width: 100%;
	height: 30px;
}

#detailTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#detailTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
	margin: 0px;
}

#detailTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#detailTable input[type='button'] {
	height: 40px;
	width: 120px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

.heart {
	width: 100px;
	height: 100px;
	transform: translate(111%, -18%);
	background: url(resources/img/heart.png) repeat;
	cursor: pointer;
}

#mlist, #modi, #del {
	width: 80px;
	height: 40px;
	font-family: "나눔고딕 보통";
	font-size: 20px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#favorite {
	position: absolute;
	top: 43.5%;
	left: 71.7%;
}

.heart-blast {
	background-position: -2800px 0;
	transition: background 1s steps(28);
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<!-- dialog가 될 div 영역! -->
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<!-- 내용시작 -->
	<div id="conDiv">
	<h1>보호게시판</h1>
		<div id="protectNonmemberChk" title="비회원">
			<div>
				<h1>비밀번호를 입력해주세요.</h1>
				<input id="pass" type="password">
			</div>
		</div>
		<table id="detailTable" style="border: 1px solid gray">
			<tr class="littleTr">
				<th style="width: 100px">작성자</th>
				<td><span id="writer"></span></td>
				<!-- 비회원이 작성한 글인 경우 아이피 처리때문에 span태그 사용했어~ -->

				<th style="width: 100px">작성일</th>
				<td>${protectDetail.board_regDate}</td>

			</tr>
			<tr class="littleTr">
				<th style="width: 100px">제 목</th>
				<td class="littleTd" style="width: 500px">${protectDetail.board_title}</td>
				<th style="width: 100px">조회수</th>
				<td>${protectDetail.board_hit}</td>
			</tr>

			<tr class="littleTr">
				<th style="width: 100px">동물종</th>
				<td class="littleTd">${protectDetail.animal_idx}</td>
				<th style="width: 100px">품종</th>
				<td class="littleTd">${protectDetail.animal_type}</td>


			</tr>
			<tr class="littleTr">
				<c:set var="loginId" value="${sessionScope.loginId}" />
				<c:if test="${!empty loginId}">
					<th style="width: 100px">위치</th>
					<td class="littleTd">${protectDetail.protect_loc}</td>
					<th style="width: 100px">즐겨찾기</th>
					<td class="littleTd"></td>
				</c:if>
				<c:if test="${empty loginId}">
					<th style="width: 100px">위치</th>
					<td class="littleTd" colspan="3">${protectDetail.protect_loc}</td>
				</c:if>
				
			</tr>
			<tr>
				<th colspan=4 style="width: 1000px; border: 1px solid gray;">내용</th>
			</tr>

			<tr>
				<td colspan=4 style="text-align: left; border: 1px solid gray;">${protectDetail.board_content}</td>

			</tr>
			<tr>
				<td colspan=4 style="text-align: right"><input type="button"
					id="mlist" onclick="protectList()" value="리스트" /> <input
					type="button" id="modi" onclick="protectNonmemberChk('modi')"
					value="수정" /> <input type="button" id="del"
					onclick="protectNonmemberChk('del')" value="삭제" /></td>
			</tr>
			<tbody>
				<tr>
			<td>	<jsp:include page="reply.jsp"/>
			</td>
			</tr>
			</tbody>
		</table>
	</div>

	<c:if test="${!empty loginId}">
		<div id="favorite" class="heart"></div>
	</c:if>



</body>
<script>
	var writer;
	var request;
	var favorite=0;
	var menuName = {'실종':'missingList', '보호':'protectList'};

	$(document).ready(function() {
		
		var content = "";
		for(var key in menuName){
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if(key=='보호'){
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id="+menuName[key]+">";
			content += key;
			content += "</div>";
		};	
		
		$("#sideMenu").empty();
		$("#sideMenu").append(content);

		favorite = "${favorite}";
		if(1==${favorite}){
			$("#favorite").toggleClass("heart-blast");
		}
		
		writer = "${protectDetail.board_writer}"
		//ip처리를 위해 usbstr메서드를 통해 비회원과 아이디 영역을 나눈다.
		var pre = writer.substr(0,3);
		var ip = writer.substr(4,15);
		var ipArr = ip.split(".");
		//비회원이 작성한 글이라면
		if(writer.indexOf("비회원")!=-1){
			//ip처리한 값을 span에 넣는다.
			$("#writer").html(pre+ipArr[0]+"."+ipArr[1]+".*.*");	
		}else{
			//아니라면 그냥 출력
			$("#writer").html(writer);
		}
		
		//dialog 플러그인 사용
		$( "#protectNonmemberChk" ).dialog({
			autoOpen: false,
	     	resizable: false,
		    height: "auto",
		    width: 400,
		    modal: true,
		    buttons: {
		    	"확인": function() {//확인 버튼을 클릭하면 PassChk(비밀번호 체크 )함수 실행
		    		PassChk();
		        },
		   }
		});
	});
	
	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href="./"+$(e).attr("id");
	};
	
	$("#favorite").on("click", function() {
		 $(this).toggleClass("heart-blast");
		 if(favorite!=1){
			 $.ajax({
					type : "get",
					url : "./favoriteRegist",
					data : {
						"idx": '${protectDetail.board_idx}',
						"id": '${sessionScope.login}'
					},
					success : function(data) {
						favorite=1;
					},
					error : function(e) {
						console.log(e);
					}
			});
		 }else{
			 $.ajax({
					type : "get",
					url : "./favoriteDel",
					data : {
						"idx": '${missingDetail.board_idx}',
						"id": '${sessionScope.login}'
					},
					success : function(data) {
						favorite=0;
					},
					error : function(e) {
						console.log(e);
					}
			});
		 } 
	 });
	
	
	//비회원 체크 후 비밀번호 확인
	function protectNonmemberChk(req) {
		request=req;
		 if(writer.indexOf("비회원")!=-1){
			$( "#protectNonmemberChk" ).dialog( "open" );
		}else{
			console.log(request);
			if(request=="modi"){
				protectUpdate();
				console.log(request);
			}if(request=="del"){
				protectDelete();
			}
		}
	}

	//리스트보기
	function protectList(){
		location.href="./protectList";
	}

	//수정하기
	function protectUpdate(){
		location.href="./protectUpdateForm?board_idx=${protectDetail.board_idx}";
	}
	
	//삭제
	function protectDelete(){
		var del = confirm("해당 글을 삭제하시겠습니까?");
		if(del){
			location.href="./protectDelete?board_idx=${protectDetail.board_idx}";
		}
	}
	
	//비밀번호 확인
	function PassChk() {
		$.ajax({
			type : "get",
			url : "./passChk",
			data : {
				/* 보내는 데이터는 현재 페이지를 구분할 수 있는 requestPage(메서드 하나로 처리하려고,,), 해당 글번호, 사용자가 입력한 비밀번호 */
				"requestPage": "보호",
				"idx": '${protectDetail.board_idx}',
				"pass": $("#pass").val()
			},
			success : function(data) {
				console.log(data);
				//리턴한 값이 true (=비밀번호 일치)라면
				if(data){
					//dialog창 닫고
					$("div#protectNonmemberChk.ui-dialog-content.ui-widget-content").dialog( "close" );
					//입력한 버튼의 id값에 따른 함수 처리
					if(request=='del'){
						protectDelete();
					}else{
						protectUpdate();
					}
				}else{
					//리턴 값이 false라면 경고창 출력
					alert("비밀번호가 일치하지않습니다.");
					$("#pass").val("");
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
</script>
</html>