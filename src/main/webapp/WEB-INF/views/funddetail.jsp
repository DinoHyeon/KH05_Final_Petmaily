<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table, th, td {
   border: 1px solid black;
   border-collapse: collapse;
   padding: 6px 15px;
   text-align: center;
}

#buttonarea{
    position: absolute;
    top : 44%;
    left : 38%;
}
</style>
</head>
<body>
<jsp:include page="mainFrame.jsp"/>
   <h1>${dto.board_title }</h1>
   <hr />
   <table>
      <tr>
         <td>글번호</td>
         <td>${dto.board_idx }</td>
      </tr>
      <tr>
         <th>조회수</th>
         <td>${dto.board_hit}</td>
      </tr>
      <tr>
         <th>작성자</th>
         <td>${dto.board_writer }</td>
      </tr>
      <tr>
         <th>제 목</th>
         <td>${dto.board_title }</td>
      </tr>
      <tr>
         <th>내 용</th>
         <td>${dto.board_content}</td>
      </tr>

      
</table>

      <div id ="buttonarea">
      <input type="button" onclick="fundList()" value="리스트"/>
      <input type="button" onclick="fundedit()" value="수정"/>
      <input type="button" onclick="funddelete()" value="삭제"/>
      </div>
  
</body>
<script>
   var msg = "${msg}";

   function fundList(){
      location.href="./fundMain";
   }
   function funddelete(){
      var del = confirm("해당 글을 삭제하시겠습니까?");
      if(del){
      location.href="./funddelete?idx=${dto.board_idx}";
      }
   }
   function fundedit(){
      location.href="./fundupdateForm?idx=${dto.board_idx}&call=fundupdateForm";
      
   }

 
   var fileMap = {};
   var fileCnt = "${size}";//첨부파일 유무 확인

   <c:forEach items="${files}" var = "list">
   fileMap["${list.photo_newName}"] = "${list.photo_oriName}";
   </c:forEach>
   console.log("fileMap", fileMap);

   //파일이 있으면 fileMap 에 있는 값으로 링크를 생성
   if (fileCnt > 0) {
      //object 에서 키추출 -> 키에 따른 값을 추출
      //console.log(Object.keys(fileMap));
      //키를 이용해 값을 하나씩 뽑아내기
      //array.forEach(function(item){});
      var content = "";
      Object.keys(fileMap).forEach(
            function(item) {
               content += "    <a href='./download?file=" + item + "'>"
                     + "<img width='15px' src='resources/icon.png'/>"
                     + fileMap[item] + "</a>";

            });
      $("#attach").append(content);

   } else {
      $("#attach").html("첨부된 파일이 없습니다.");
   }
</script>
</html>