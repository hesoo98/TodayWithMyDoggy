<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/form.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</head>

	<script type="text/javascript">
	
   	  $(function(){

      //trigger 이벤트 강제 호출 
      $("span.camera").click(function(){
         $("#input-photo").trigger("click");
      });

      //esc로 모달 닫기
      $(document).keydown(function(e){
      	//keyCode 구 브라우저, which 현재 브라우저
          var code = e.keyCode || e.which;
       
          if (code == 27) { // 27은 ESC 키번호
              history.back();
          }
      });
      
   });
   
    //이미지 미리보기   
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
            reader.onload = function (e) {
            //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $('#showimg').attr('src', e.target.result);
            }                   
            reader.readAsDataURL(input.files[0]);
            //File내용을 읽어 dataURL형식의 문자열로 저장
        }
        
    }
    </script>

<body>

<%
String num=request.getParameter("num");
String currentPage=request.getParameter("currentPage");

DogTalkingBoardDao dao=new DogTalkingBoardDao();
DogTalkingBoardDto dto=dao.getData(num);

%>


<div id="modal" class="modal__background" style="display: hidden;">
  <div class="modal__box">
    
	<h4 id="top">수정하기<i id="btn-close" onclick="history.back()" class="fa-solid fa-circle-xmark"></i></h4>
	<form action="dog-talking/modifyaction.jsp" method="post" enctype="multipart/form-data">
	<table style="top:150px;">
	<input type="hidden" name="num" value="<%=dto.getNum()%>">
	  <tr>
	    <td>
	    	<!-- 이미지 미리보기 -->
	        <img id="showimg" src="<%=dto.getPhoto()==null?"":"dog-talking-photo/"+dto.getPhoto()%>">
	  		<input type="file" name="photo" id="photo" style="visibility: hidden;" onchange="readURL(this)"> 
	    </td>
	    <td>
		    <div id="content">
		      <textarea name="content" placeholder="내용을 입력하세요" required><%=dto.getContent() %></textarea>
		    </div>
	    </td>
	  </tr>
	  <tr>
	    <td>
	      <div>
	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="camera">
	      <i class="fa-solid fa-camera-rotate icon"></i>사진수정</span>
	      </div>
	    </td>
	    <td align="center">
		  <button type="submit" class="btn btn-warning">수정</button>
	    </td>
	  </tr>
	</table>
	  
	</form>
    
  </div>
</div>
         
</body>
</html>