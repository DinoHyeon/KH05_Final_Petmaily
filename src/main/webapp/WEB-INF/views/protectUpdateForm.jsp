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
         top: 11.4%;
         width: 15%;
         height: 150%;
         background: black;
      }
      
   
#attachArea{
float:left;
padding:1%;
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
      #conDiv #editable {
         border: 1px solid gray;
         height: 250px;
         height: 500px;
         padding: 5px;
         overflow: auto;
         text-align: left;
      }
      /* 글 테이블 */
      #detailTable{
         top:14%;
         left:11%;
         width: 1000px;
         margin: 0px 5px 5px 5px;
         border-collapse: collapse;
         padding: 5px 10px;
         position:absolute;
      }
      #detailTable input[type='text']{
         width:100%;
         height:30px;
      }
      #detailTable textarea{
         width:100%;
         resize:none;
         margin:0;
      }
      #detailTable td{
         text-align: center;
         border: 1px solid white;
         border-collapse: collapse;
         padding: 2px 2px;
         margin: 0px;
      }
      #detailTable th{
         border: 1px solid white;
         border-collapse: collapse;
         padding: 5px 10px;
         background-color: #28977B;
         color: white;
      }
      #detailTable input[type='button'] {
          height:40px;
            width:120px;
            background-color: #28977B;
            border-color:#28977B;
            border-style:solid;
            font-weight: 600;
            color: white;
            cursor: pointer;
      }
      /* 업로드 테이블 */
      #uploadTable{
         position: absolute;
         top:65%;
         left: 11%;
         border: 1px solid gray;
         width: 1000px;
         height: 150px;
         margin: 50px 5px 100px 5px;
         border-collapse: collapse;
         padding: 5px 10px;
      }
      #uploadTable tr,td{
         font-weight:600;
         font-family:"나눔고딕 보통";
         border:1px solid gray;
         text-align:center;
      }
      #uploadTable input[type='button']{
         width:60px;
         height: 30px;
         font-family:"나눔고딕 보통";
         background-color: #28977B;
         border-color:#28977B;
         border-style:solid;
         font-weight: 600;
         color: white;
         cursor: pointer;
      }
      
#fileUpBtn {
   margin-left: 300px;
}

#attach img {
   width: 80px;
   height: 80px;
}
   #detailTable select { 
         width: 150px; /* 원하는 너비설정 */ 
         padding: .8em .5em; /* 여백으로 높이 설정 */ 
         font-family: inherit; /* 폰트 상속 */ 
         background: url(resources/arrowIcon.jpg) no-repeat 95% 50%; /* 네이티브 화살표 대체 */
         border: 1px solid #999; border-radius: 0px; /* iOS 둥근모서리 제거 */ 
         -webkit-appearance: none; /* 네이티브 외형 감추기 */ 
         -moz-appearance: none; 
         appearance: none; 
         left:30%;
      }
      

</style>
</head>
<body>
</body>
<script>
	var fullLoc = "${protectDetail.protect_loc}"; //지역 값 전체 받아오기
	var locArr = fullLoc.split(' '); //locArr[0] :시    locArr[1] : 구
	var mainPhoto;
	
	$(document).ready(function(){	
	  selectBoxChk($("#sido"),locArr[0]);
	  getSigungu();//option 있는상태에서 내가 비교할 값 찾기
	  selectBoxChk($("#animal"),"${protectDetail.animal_idx}");
	  getAnimalType();
	});
	
	 function selectBoxChk(selectBox,data) {
		 selectBox.find("option").each(function(index){
	         if( $(this).html() == data ){
	        	 $(this).prop("selected", true);
	         }
	         
	      });
	   }

	
	var fileMap = {};
	var fileCnt = "${size}";//첨부파일 유무 확인
	
	<c:forEach items="${files}" var = "protectList">
	if("${protectList.mainPhoto}"=="대표이미지"){
		mainPhoto = "${protectList.photo_newName}"
	}
	fileMap["${protectList.photo_newName}"] = "${protectList.photo_oriName}";
</c:forEach>
	
	//파일이 있으면 fileMap 에 있는 값으로 링크를 생성
	if(fileCnt >0){
		//object 에서 키추출 -> 키에 따른 값을 추출
		//키를 이용해 값을 하나씩 뽑아내기
		var content = "";
		Object.keys(fileMap).forEach(function(item) {
			content += "<img width='15px' src='resources/upload/"+item+"'/>";
			if(mainPhoto==item){
				content += "<input type='radio' name='main' value='"+item+"' checked>";
			}else{
				content += "<input type='radio' name='main' value='"+item+"'>";
			}
			
		});
		$("#attach").append(content);
		
	}else{
		$("#attach").html("첨부된 파일이 없습니다.");
	}

	//지역
	function getSigungu() {
		console.log();
		$.ajax({
			"url" : "./getSigungu",
			"type" : "get",
			"data" : {"sidoCode" : $("#sido option:selected").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					if(item.sigundoName==locArr[1]){
						content += "<option value="+item.sigundoName+" selected>";
					}else{
						content += "<option value="+item.sigundoName+">";
					}
					content += item.sigundoName;
					content += "</option>";
				})
				$("#sigundo").empty();
				$("#sigundo").append(content);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
	//동물종&품종 값 가져오기
	function getAnimalType() {
		$.ajax({
			"url" : "./getAnimalType",
			"type" : "get",
			"data" : {"animalCode" : $("#animal option:selected").val()},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					if(item.animalType=="${protectDetail.animal_type}"){
						content += "<option value="+item.animalType+" selected>";
					}else{
						content += "<option value="+item.animalType+">";
					}
					content += item.animalType;
					content += "</option>";
				})
				$("#animalType").empty();
				$("#animalType").append(content);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
	
	
	
	
	//파일 업로드 창
	function fileUp() {
		var myWin = window.open("./puploadForm", "파일 업로드", "width=300, height=150");
	}
	
	//사진 삭제 - ajax
	function pDel(elem) {
		var fileName = elem.id.split("/")[2];
		$.ajax({
			url : "./pFileDel",
			type : "get",
			data : {
				"fileName" : fileName
			},
			success : function(data) {
				console.log(data);
				if (data.success == 1) {
					
					$(elem).prev().remove();//content 파일 삭제
					$(elem).remove();//버튼 삭제
					document.getElementById(fileName).remove(); //해당파일 삭제
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	// (첨부파일 보기란)이미지에 삭제 버튼 붙이기		
	$("#attach img").each(
			function(index, value) {
				var delBtn = "<input id='" + $(this).attr("src")
						+ "' type='button' value='삭제' onclick='pDel(this)'>";
				$(this).after(delBtn);
			});
	
	//취소
	$("#back").click(function(){
		location.href="./protectList";
	});
	
	/* 사진 체크 */
	function pcheckphoto() {
		var photoChk;
	      $.ajax({
	         url:"./pcheckphoto",
	         type:"get",
	         async: false,
	         success:function(data){
	            photoChk = data;
	         },
	         error:function(e){
	            console.log(e);
	         }
	      });
	      
	      return photoChk;
	      
	   }
	
	//수정
	$("#btn_Update").click(function(){
		if($("#bTitle").val()==""){
			$("#bTitle").focus();
			alert("제목을 입력해 주세요.");
		}else if($("#sido option:selected").html()=="선택"){
			$("#sido").focus();
			alert("지역을 선택해 주세요.");
		}else if(!mcheckphoto()){
			alert("파일을 등록해주세요.");
		}else if(!$("input:radio[name='main']").is(":checked")){
			$("input:radio[name='main']").focus();
			alert("대표이미지를 선택해 주세요.");
		}else{
			$("#editable input[type='button']").remove();//삭제 버튼 제거
			$("input[name='mainPhoto']").val($("input:radio[name='main']:checked").val());
			$("#attach input[type='radio']").remove();//체크박스 버튼 제거
			$("#contentForm").val($("#editable").html());//div 내용을 hidden 에 담기
			$("#location").val($("#sido option:selected").html());//지역 내용 담기
			$("#selectAnimal").val($("#animal option:selected").html());//동물 내용 담기
			$("#sendForm").submit();
		}
	});
	
</script>
</html>