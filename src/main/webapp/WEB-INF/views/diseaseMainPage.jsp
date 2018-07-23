<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>질병메인</title>
		<style>
			h3{
				padding: 20px 600px 5px 740px;
			}
		
			#inputSearchList{
				padding: 10px 590px;
			}
		
			#keywordSearchList{
				padding: 10px 370px;
			}
		
			fieldset{
				width: 375px;
			}
		
			table, th, td{
				border : 1px solid black;
				border-collapse : collapse;
				padding : 7px 15px;
				padding-bottom: 20px;
			
				border-right:none;
				border-left:none;
				border-top:none;
				border-bottom:none;
			}
		
			input[type='button']{
				width: 100pt;
				height: 30pt;
			}
			
			#keywordSearch{
				margin-top: 35px;
				margin-left: 330px;
				width: 20%;
				border : 3px solid black;
				border-collapse : collapse;
			}
		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<h3>질병 검색</h3>
		<hr>
		<form id="inputSearchList" action="diseaseSearchListPage" method="post">
			<fieldset>
				<select name="animal">
					<option>품종선택</option>
					<option value="Dog">개</option>
					<option value="Cat">고양이</option>
				</select> 
				<select name="selectSearch">
					<option>검색분류</option>
					<option value="symptom">증상</option>
					<option value="disease">질병</option>
				</select>
				<input type="text" name="inputSearch" placeholder="검색어를 입력 하세요" /> 
				<input type="submit" value="검색" />
			</fieldset>
		</form>
		
		<form id="keywordSearchList" action="diseaseKeywordListPage" method="post">
			<table>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key1" value="기침"/></td>
					<td><input type="button" onclick="keyword(this)" id="key2" value="구토"/></td>
					<td><input type="button" onclick="keyword(this)" id="key3" value="무기력"/></td>
					<td><input type="button" onclick="keyword(this)" id="key4" value="발열"/></td>
					<td><input type="button" onclick="keyword(this)" id="key5" value="혈뇨"/></td>
				</tr>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key6" value="설사"/></td>
					<td><input type="button" onclick="keyword(this)" id="key7" value="졸림"/></td>
					<td><input type="button" onclick="keyword(this)" id="key8" value="탈모"/></td>
					<td><input type="button" onclick="keyword(this)" id="key9" value="침울"/></td>
					<td><input type="button" onclick="keyword(this)" id="key10" value="떨림"/></td>
				</tr>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key11" value="방귀"/></td>
					<td><input type="button" onclick="keyword(this)" id="key12" value="오한"/></td>
					<td><input type="button" onclick="keyword(this)" id="key13" value="생기없음"/></td>
					<td><input type="button" onclick="keyword(this)" id="key14" value="식욕과다"/></td>
					<td><input type="button" onclick="keyword(this)" id="key15" value="과호흡"/></td>
				</tr>
				<tr>
					<td><input type="button" onclick="keyword(this)" id="key16" value="경련"/></td>
					<td><input type="button" onclick="keyword(this)" id="key17" value="복부팽만"/></td>
					<td><input type="button" onclick="keyword(this)" id="key18" value="무모증"/></td>
					<td><input type="button" onclick="keyword(this)" id="key19" value="식욕부진"/></td>
					<td><input type="button" onclick="keyword(this)" id="key20" value="염증"/></td>
				</tr>
			</table>
			<input type="hidden" id="arrKey" name="arrKey"/>
			<input type="submit" id="keywordSearch" value="키워드 검색" />
		</form>
	</body>
	<script>
		var keyArr = [];
		var i;
	
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










