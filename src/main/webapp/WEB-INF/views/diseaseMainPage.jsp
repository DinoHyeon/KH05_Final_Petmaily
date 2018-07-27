<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>질병메인</title>
<style>
h3 {
	padding: 20px 600px 5px 740px;
}

#inputSearchList {
	padding: 10px 590px;
}

#keywordSearchList {
	padding: 3% 3%;
	position: absolute;
	top: 20%;
	left: 20%;
}

fieldset {
	width: 375px;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 7px 15px;
	padding-bottom: 20px;
	border-right: none;
	border-left: none;
	border-top: none;
	border-bottom: none;
}

#keywordSearch {
	position: absolute;
	width: 145px;
	height: 55px;
	top: 105%;
	left: 44%;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 900;
	color: white;
	cursor: pointer;
}

#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 95%;
	background: white;
}

#aaa {
	position: absolute;
	left: 45%;
	top: 3%;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 100%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

#searchArea {
	position: absolute;
	top: 12%;
	left: 19%;
	margin: 1.5% 1.5%;
}

#contentFrame input[type='button'] {
	width: 120px;
	height: 85px;
	background-color: #A9CB73;
	border-color: #28977B;
	border-style: solid;
	font-weight: 900;
	color: white;
	cursor: pointer;
}

#searchArea select {
	width: 250px; /* 원하는 너비설정 */
	padding: .8em .5em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 50%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
	left: 30%;
}

#searchArea input[type='text'] {
	position: absolute;
	width: 60%;
	top: 14%;
	left: 101%;
	height: 80%;
}

#search {
	position: absolute;
	width: 75px;
	height: 34px;
	top: 12%;
	left: 163%;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 900;
	color: white;
	cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="contentFrame">
		<h2 id="aaa">질병 검색</h2>
		<form id="inputSearchList" action="diseaseSearchListPage"
			method="post">
			<div id="searchArea">
				<select name="animal">
					<option>품종선택</option>
					<option value="Dog">개</option>
					<option value="Cat">고양이</option>
				</select> <select name="selectSearch">
					<option>검색분류</option>
					<option value="symptom">증상</option>
					<option value="disease">질병</option>
				</select> <input type="text" name="inputSearch" placeholder="검색어를 입력 하세요" />
				<input type="submit" id="search" value="검색" />
			</div>
		</form>

		<form id="keywordSearchList" action="diseaseKeywordListPage"
			method="post">
			<table>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key1"
						value="기침" /></td>
					<td><input type="button" onclick="keyword(this)" id="key2"
						value="구토" /></td>
					<td><input type="button" onclick="keyword(this)" id="key3"
						value="무기력" /></td>
					<td><input type="button" onclick="keyword(this)" id="key4"
						value="발열" /></td>
					<td><input type="button" onclick="keyword(this)" id="key5"
						value="혈뇨" /></td>
				</tr>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key6"
						value="설사" /></td>
					<td><input type="button" onclick="keyword(this)" id="key7"
						value="졸림" /></td>
					<td><input type="button" onclick="keyword(this)" id="key8"
						value="탈모" /></td>
					<td><input type="button" onclick="keyword(this)" id="key9"
						value="침울" /></td>
					<td><input type="button" onclick="keyword(this)" id="key10"
						value="떨림" /></td>
				</tr>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key11"
						value="방귀" /></td>
					<td><input type="button" onclick="keyword(this)" id="key12"
						value="오한" /></td>
					<td><input type="button" onclick="keyword(this)" id="key13"
						value="생기없음" /></td>
					<td><input type="button" onclick="keyword(this)" id="key14"
						value="식욕과다" /></td>
					<td><input type="button" onclick="keyword(this)" id="key15"
						value="과호흡" /></td>
				</tr>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key16"
						value="경련" /></td>
					<td><input type="button" onclick="keyword(this)" id="key17"
						value="복부팽만" /></td>
					<td><input type="button" onclick="keyword(this)" id="key18"
						value="무모증" /></td>
					<td><input type="button" onclick="keyword(this)" id="key19"
						value="식욕부진" /></td>
					<td><input type="button" onclick="keyword(this)" id="key20"
						value="염증" /></td>
				</tr>
			</table>
			<input type="hidden" id="arrKey" name="arrKey" /> <input
				type="submit" id="keywordSearch" value="키워드 검색" />
		</form>
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
	
		function keyword(now){
			var selectCondition = document.getElementById(now.id);
			var clickKey = now.style.background;
			
			if(clickKey == ''){
    			selectCondition.style.background = 'gray';
    			alert(now.value+"이 선택되었습니다.");
    			keyArr.push(now.value);
    		} else{
    			selectCondition.style.background = '';
    			alert(now.value+"이 선택 취소되었습니다.");
    			
    			if(keyArr.indexOf(now.value)+1){
    				for (i=0; i<keyArr.length; i++) {
    					if(keyArr[i] == now.value){
    						keyArr.splice(i, 1);
    					}
    				}
    			}
    		}
			console.log(keyArr);
			
			$("#arrKey").val(keyArr);
		}
	</script>
</html>










