<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">

	#photo-box{
	  border: 1px solid black;
	  width: 200px;
	  height: 200px;
	  text-align: center;
	  line-height: 200px;
	  position:absolute;
	  left:200px;
	}
	
	#showimg{
	  position:absolute;
	  left:200px;
	  width: 200px;
	  height: 200px;
	}
	
	.camera{
	  font-size: 15px;
	  font-weight:200;
	}
	
	.camera-mod{
	  top:120px;
	  left:70px;
	}

</style>

</head>

	<script type="text/javascript">
   $(function(){
      //수정창 숨김
      $(".camera-mod").hide();
      
      //trigger 이벤트 강제 호출 
      $("span.camera").click(function(){
         $("#photo").trigger("click");
      });
      $("span.camera-mod").click(function(){
    	  $("#photo-mod").trigger("click");
      })
      
   });
   
    //이미지 미리보기   
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
            reader.onload = function (e) {
            //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $('#showimg').attr('src', e.target.result);
            	$(".camera-mod").show();
            	$(".camera").hide();
            }                   
            reader.readAsDataURL(input.files[0]);
            //File내용을 읽어 dataURL형식의 문자열로 저장
        }
        
    }
    </script>

<body>
  <div class="container">
	<form action="dog-talking/answeraction.jsp" method="post" enctype="multipart/form-data">
	  <!-- 이미지 미리보기 -->
      <img id="showimg">
	  <div id="photo-box">
	    <span class="glyphicon glyphicon-camera camera"> 사진을 넣어주세요</span>
	    <span class="glyphicon glyphicon-camera camera-mod"> 사진 수정</span>
	  <input type="file" name="photo" id="photo" style="visibility: hidden;" onchange="readURL(this)" required> 
	  <input type="file" name="photo-mod" id="photo-mod" style="visibility: hidden;" onchange="readURL(this)"> 
	  </div>
	  <div id="content-box">
	    <div id="subject"><input type="text" placeholder="제목을 입력하세요" required></div>
	    <div id="content"><input type="text" placeholder="내용을 입력하세요" required></div>
	  </div>
	  <button type="submit">저장</button>
	</form>
  </div>

  
         
</body>
</html>