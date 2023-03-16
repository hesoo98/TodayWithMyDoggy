<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style>
#board {
  padding-top: 70px;
  padding-bottom: 30px;
  width: 600px;
}


</style>
</head>
<body>
	   <div>
   <!-- 이미지 미리보기 -->
   <img id="showimg" style="position: absolute; left: 650px; top: 0px; max-width: 200px;">
   
      <form action="guest/addaction.jsp" method="post" enctype="multipart/form-data">
         <table style="width: 600px">
         <caption>
         <b>방명록 작성</b>
         <span class="glyphicon glyphicon-camera camera"></span>
         <input type="file" name="photo" id="photo" style="visibility: hidden;"
          onchange="readURL(this)"> 
          <!-- 파일 업로드 형식 가리려면 style="visibility: hidden; -->
         
         </caption>
         
         <tr height="100">
            <td width="500">
            <textarea style="width: 480px; height: 100px;" class="form-control" name="content" required ></textarea>
            </td>
            <td>
            <button type="submit" class="btn btn-default" style="width: 100px; height: 100px;">등록</button>
            </td>
         </tr>
         </table>
      </form>
   </div>
</body>
</html>