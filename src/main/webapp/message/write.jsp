<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
<title>Insert title here</title>

<style type="text/css">
	
	

</style>

</head>

<script type="text/javascript">

$(document).keydown(function(e){
	//keyCode 구 브라우저, which 현재 브라우저
    var code = e.keyCode || e.which;
 
    if (code == 27) { // 27은 ESC 키번호
        history.back();
    }
});

</script>

<body>
	
<!-- Modal -->
	<div class="modal fade" id="exampleModal">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <h5 class="modal-title" id="exampleModalLabel">답장하기</h5>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
    		  
	   <div class="modal-body">
	   <form action="message/writeaction.jsp" method="post">
	   <%-- <input type="hidden" name="num" value="<%=dto.getNum()%>">
	   <input type="hidden" name="receiver" value="<%=dto.getId()%>">
	   
	   	보내는 사람:<%=id %><br>
	   	받는 사람:<%=nickname %><br><br> --%>
	    <textarea rows="10" style="width:400px" name="content" placeholder="같이 산책하고 싶은 상대에게 쪽지를 보내보세요!"
	    required="required"></textarea>
    	  
      	<div class="modal-footer">
        	<button type="button" data-dismiss="modal">취소</button>
        	<button type="submit" >보내기</button>
    	</div>
    	
	   </form>
   	  	</div>
   		 </div>
  		</div>
	</div>
			
</body>
</html>