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

	body{
	  overflow: hidden;
	}
	
	.camera{
	  font-size: 15px;
	  font-weight:200;
	}
	
	.camera-mod{
	  top:120px;
	  left:70px;
	}
	
	/* 모달창의 배경을 만든다 */
	.modal__background{
	  position: fixed;
	  top:0; left: 0; bottom: 0; right: 0;
	  background: rgba(0, 0, 0, 0.5);
	}
	 
	/* 모달창 영역을 꾸민다 */
	.modal__box{
	  position: absolute;
	  top: calc(30vh - 100px); left: 250px;
	  background-color: white;
	  display: flex; justify-content: center;
	  align-items: center;
	  border-radius: 10px;
	  width: 700px;
	  height: 400px;
	  padding-top: 30px;
	}
	
	/* 모달창 내부 */
	#top{
	  width: 100%;
	  background-color: rgba(0, 0, 0, 0.2);
	  position: absolute;
	  left:0px;
	  top:-10px;
	  text-align: right;
	}
	
	#showimg{
	  width: 200px;
	  height: 200px;
	  position: relative;
	  left: 100px;
	}

	textarea {
	  margin-left: 200px;
	  border-radius: 4px;
	  border: none;
	  color: #311b92;
	  width: 300px; height: 300px;
	  position: relative;
	  right:50px;
	}
	
	
		
</style>

</head>

	<script type="text/javascript">
	
   	  $(function(){

      //trigger 이벤트 강제 호출 
      $("span.camera").click(function(){
         $("#photo").trigger("click");
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

<div id="modal" class="modal__background" style="display: hidden;" tabindex="0">
  <div class="modal__box">
    
	  <h4 id="top">입력창<button type="button" onclick="history.back()"><span class="glyphicon glyphicon-remove"></span></button></h4>
	<form action="dog-talking/writeaction.jsp" method="post" enctype="multipart/form-data">
	<table style="top:150px;">
	  <tr>
	    <td>
	    	<!-- 이미지 미리보기 -->
	        <img id="showimg" alt="사진을 넣어주세요">
	  		<input type="file" name="photo" id="photo" style="visibility: hidden;" onchange="readURL(this)" required> 
	    </td>
	    <td>
		    <div id="content">
		      <textarea name="content" placeholder="내용을 입력하세요" required></textarea>
		    </div>
	    </td>
	  </tr>
	  <tr>
	    <td>
	      <div>
	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-camera camera"> 사진첨부</span>
	      </div>
	    </td>
	    <td align="center">
		  <button type="submit" id="submit">저장</button>
	    </td>
	  </tr>
	</table>
	  
	</form>
    
  </div>
</div>
         
</body>
</html>