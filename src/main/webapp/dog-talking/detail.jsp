<%@page import="member.MemberDto"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="member.MemberDao"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

    .a-tag{
      color: black;
    }
    
    .a-tag:hover{
      color: black;
      text-decoration: none;
    }

	.wrapper{
	  width: 800px;  	  
  	  border: 1px lightgray solid;
  	  border-radius: 30px;
  	  padding: 60px 120px;
  	  margin: 30px 0px;
	}
	
	.wrapper-subject{
	  margin-bottom: 20px;	
	}
	
	.gray-font{
 	  color: gray;	
	}
	
	.wrapper-comment{
	  margin-bottom: 20px;
	  width: 100% auto;
	}
	
	.line{
	  width: 100% auto;
	  margin: 40px 0px;
	  height: .5px;
	  background-color: #d9e4f4;
	}
	
	.nickname{
	  font-size: 20px;
	  font-weight: 700;
	}
		
	.dog-photo{
	  width: 30px;
	  height: 30px;
	  border-radius: 30px;
	}
	
	#photo{
	  width: 200px;
	  height: 200px;
	}
	
	/* 댓글 */
	.comment, #comment-info{
	  opacity: 0.8;
	}
	
	.writer{
	  font-weight: 600;
	  font-size: 14px;
	}
	
	.writeday {
	  float: right;
	}
	
	.content{
	  margin-left: 5px;
	}
	
	.btn-box{
	  float: right;
	}
	
	#btn-comment-del{
	  padding-right: 10px;
	}
	
	#btn-comment-mod, #btn-comment-del{
	  cursor: pointer;
	}
	
	#my-comment{
	  color: gray;
	  font-size: 10px;
	  border-radius: 5px;
	  border: 1px solid gray;
	  width:35px;
	  text-align: center;
	}
	
	#comment-info{
	  font-size: 13px;
	  font-weight: 300;
	}
	
	#commenter-div{
	  float: left;
	}
	
	
</style>

</head>

<%
//num에 해당하는 data 받기
String num=request.getParameter("num");
String currentPage=request.getParameter("currentPage");

DogTalkingBoardDao dao=new DogTalkingBoardDao();
DogTalkingBoardDto dto=dao.getData(num);
MemberDao mdao=new MemberDao();

String id=(String)session.getAttribute("myid"); //sessionid
String sessionNickname=mdao.getNickname(id); //sessionnickname
String nickname=mdao.getNickname(dto.getId()); //writernickname


//format
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>

<body>
	<div class="wrapper">
	
	  <%
	  //조회수 1 증가
	  dao.updateReadCount(num);
	  %>
	  
	  <div class="wrapper-subject">
	  
	  <!-- pet info -->
	  <%
	    //writer_num
	    String writerNum=mdao.getNum(dto.getId());
	    DogProfileDao pdao=new DogProfileDao();
	    DogProfileDto pdto=pdao.getMainDogInfo(writerNum);%>
	    
	    <div style="cursor: pointer;" data-toggle="modal" data-target="#exampleModal2">
	    <input type="hidden" id="birthday" value="<%=pdto.getBirthday()%>">
	    <%// 프로필사진
	    if(pdto.getIdx()==null){%>
		<span class="dog-photo"><i class="fa-solid fa-dog fa-lg"></i></span>
		<span class="nickname"><%=nickname %></span>
	    <%}else{%>
		<img class="dog-photo" src="/TodayWithMyDoggy/mypage/dogImg/<%=pdto.getPhoto()%>">
	    <span class="nickname"><%=nickname %></span>
	    <br>
	    <span style="font-size: 12px;"><%=pdto.getName() %></span>
	    <%} %>
	    </div>
	    
   	  <!-- 프로필 모달 -->
	  <div class="modal fade" id="exampleModal2">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <h5 class="modal-title" id="exampleModalLabel2"><%=nickname %>의 멍멍이</h5>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
    		<%if(pdto.getName()==null){%>
    		<div class="modal-body">
    			<span >
    				강아지 프로필을 추가하지 않은 회원입니다.
    				쪽지로 인사해보세요!
    			</span>
			</div>
    		<%}else{
    			%> 
    	   		   <div class="modal-body">
   	   		   
	   	   		   <table class="table table-borderless">
	   	   		   	 <tr>
	   	   		   	 	<td rowspan="5"><img style="width:200px; height:200px; border-radius: 30px;" src="../TodayWithMyDoggy/mypage/dogImg/<%=pdto.getPhoto() %>"></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 이름 | <%=pdto.getName() %></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 성별 | <%=pdto.getGender() %></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 크기 | <%=pdto.getDogSize() %></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 생일 | <%=pdto.getBirthday() %> (<span id="age"></span>세)</td>
	   	   		   	 </tr>
	   	   		   </table>  
	   	   		   
    	    	  </div>
    		<%}%>
    		
	      	<div class="modal-footer">
	        	<button type="button" class="btn btn-light" data-dismiss="modal">확인</button>
	        	
				<!-- 쪽지함 만들기 -->
				<button type="button" class="btn btn-light"  data-dismiss="modal"
				 style="float: right" data-toggle="modal" data-target="#exampleModalMessage" class="btn btn-default btn" >
				쪽지
				</button>
		   	</div>
		    	
	   		 </div>
	  		</div>
		</div>
		<!-- 프로필모달 끝 -->
		
		<script type="text/javascript">
    		
    		//멍멍이 나이 계산
    				
			let today=new Date();
			let year=today.getYear()+1900;
			
			let birthyear=$("#birthday").val().substr(0,4);
			
			$("#age").text(year-parseInt(birthyear));
			
   		</script>
		
		<!-- 쪽지 Modal -->
		<div class="modal fade" id="exampleModalMessage">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <h5 class="modal-title" id="exampleModalLabel">쪽지 보내기</h5>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
    		  
	   <div class="modal-body">
	   <form action="dog-talking/writemessageaction.jsp" method="post">
	   <input type="hidden" name="num" value="<%=dto.getNum()%>">
	   <input type="hidden" name="receiver" value="<%=dto.getId()%>">
	   <input type="hidden" name="currentPage" value="<%=currentPage%>">
	   
	   	<span>[받는 사람] <%=nickname %></span>
	   	
	   	<br><br>
	    <textarea rows="10" style="width:100%;" name="content" placeholder="쪽지 내용을 입력해주세요."

	    required="required"></textarea>
    	  
      	<div class="modal-footer">
        	<button type="button" class="btn btn-default border border-secondary" data-dismiss="modal">취소</button>
        	<button type="submit" class="btn btn-default border border-secondary" >보내기</button>
    	</div>
    	
	   </form>
   	  	</div>
   		 </div>
  		</div>
	</div>
	<!-- 쪽지 Modal 끝 -->
		
	  <br>
	  <span class="gray-font"><%=sdf.format(dto.getWriteday()) %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
	  </div>
	  
	  <hr class="line">
	  
	  <div class="wrapper-content">
	    <img id="photo" src="dog-talking-photo/<%=dto.getPhoto()%>">
	    <br>
	    <%=dto.getContent().replace("\n", "<br>") %>
	  </div>
	  
	  <hr class="line">
	  
	  <div class="wrapper-comment">
	    <span id="likes" style="cursor: pointer;" onclick="updateLikes()" num=<%=dto.getNum() %>>
	    	<i class="fa-solid fa-heart"
			style="margin-left: 10px; margin-top: 5px; font-size: 16px; cursor: pointer; float: left;"
			id="heart"></i>
	    </span>
	    <span> <%=dto.getLikes() %> | </span>
	    
	    <!-- 댓글 -->
	    <%
	    DogTalkingAnswerDto adto=new DogTalkingAnswerDto();
	    DogTalkingAnswerDao adao=new DogTalkingAnswerDao();
	    String boardNum=dto.getNum();
	    List<DogTalkingAnswerDto> list=adao.showAnswers(boardNum);
		  
	    %>
	    <span id="comment" style="cursor: pointer;"> 댓글 <%=list.size() %></span>
	    <div id="comment-box" name="num" value="<%=dto.getNum() %>">
	    <%
	    String loginok=(String)session.getAttribute("loginok");
	    
	    //로그인했다면 댓글 입력창
	    if(loginok!=null){%>
			<jsp:include page="answer.jsp"/>
	    <%}
	    %>
	    
	      <!-- 댓글 보이는 부분 -->
	      <div id="comment-list">
	        <%
	        for(DogTalkingAnswerDto dogAnswer:list){%>
	        
	          <div id="commenter-div">
	          	 
	          	<%
	          	//댓글쓴사람 강아지정보 불러오기
			    String answerNum=mdao.getNum(dogAnswer.getId());
			    DogProfileDto answerPdto=pdao.getMainDogInfo(answerNum);
	          	%>
	          	 
	          	 <span class="comment writer"><%=mdao.getNickname(dogAnswer.getId()) %></span>
	          	 <% 
	          	if(answerPdto.getIdx()==null){%>
	    	    	<i class="fa-solid fa-bone"></i>
	    	    <%}else{%>
	    	    	<img style="width: 20px; height: 20px; border-radius: 20px;" 
	    	    	src="/TodayWithMyDoggy/mypage/dogImg/<%=answerPdto.getPhoto()%>">
	    	    	<span id="comment-info"><%=answerPdto.getName() %></span>
	    	    <%} %>
	             
	          </div>
	          <span class="comment writeday"><%=sdf.format(dogAnswer.getWriteday()) %></span>
	          
				<%
				  // 내댓글 표시 + 댓글 수정,삭제버튼
				  if(loginok!=null && sessionNickname.equals(mdao.getNickname(dogAnswer.getId()))){%>
					  <span id="my-comment" style="float: left;">&nbsp;내댓글</span>
					  
		          <div class="btn-box">
				      <a class="a-tag" id="btn-comment-mod" idx="<%=dogAnswer.getIdx() %>" href="">수정</a>
				      <a class="a-tag" id="btn-comment-del" idx="<%=dogAnswer.getIdx() %>" href="dog-talking/deleteanswer.jsp?idx=<%=adto.getIdx()%>">삭제</a>
		          </div>
				  <%}
				%>
	          <br>
	          <span id="gu-an" class="comment content"><%=dogAnswer.getContent() %></span>
	          
	          <!-- 수정창 hidden -->
	          <br>
	          <span class="form-comment-mod">
              <textarea><%=dogAnswer.getContent().replace("\n", "<br>")%></textarea>
              <button class="btn btn-default border border-secondary btn-xs" value="<%=dogAnswer.getIdx()%>">수정</button>
              </span>
	          
	          <hr>
	          
	       <% }
	        %>
	      </div>
	    </div>
	  </div>
	  
	  <script type="text/javascript">
	  
	  //좋아요 (미완성)
	  function updateLikes(){
		  var num=$("#likes").attr("num");
		  
		  <%
		  //로그인 한 사람만 좋아요 가능
		  if(loginok==null){%>
			  var a=confirm("로그인 하시겠습니까?");
			  
			  if (a) location.href="../index.jsp?main=login/loginform.jsp";
			  
		  <%}%>
			  $.ajax({
				  
				  type:"get",
				  url:"dog-talking/likes.jsp",
				  dataType:"json",
				  data:{"num":num},
				  success: function(res){
					  location.reload();
				  }
				  
			  })
	  }
	  
	  //댓글
	  $(function(){

		  //댓글 수정창 안보이게
		  $(".form-comment-mod").hide();
			  
		  //댓글 누르면 보이게
		  $("#comment").click(function(){
			  $("#comment-box").toggle();
			  
		  })
		  
	  })
	  
	  //댓글 삭제
	  $(document).on("click","#btn-comment-del",function(){
		  var idx=$(this).attr("idx");
		  
		  var a=confirm("댓글을 삭제하시려면 확인을 눌러주세요");
		  
		  if(a){
		  
			  $.ajax({
				  type:"get",
				  url:"dog-talking/deleteanswer.jsp",
				  dataType:"html",
				  data:{"idx":idx},
				  success:function(res){
					  location.reload();
				  }
			   })
			   
			} else {
				return false;
			}
	    })
	    
	  //댓글 수정
	  $(document).on("click","#btn-comment-mod",function(){
		 var idx=$(this).attr("idx");

		 $("#gu-an").hide();
		 $(this).parent().find(".form-comment-mod").show();
		
	  })
	  
	  </script>
	  <div class="btn-box">
	  <%

	    if(nickname.equals(sessionNickname)){%>
	  		<button class="btn btn-default btn-sm border border-secondary" type="button"
	  		  data-toggle="modal" data-target="#exampleModal">수정</button>
	  		<button class="btn btn-default btn-sm border border-secondary" type="button" id="btn-board-del">삭제</button>	    	
	    <%}
	  %>
	  
	  		 
		<!-- Modal 수정창 -->
		<div class="modal fade" id="exampleModal">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
   		 <div class="modal-header">
   		    <span class="modal-title" id="exampleModalLabel">수정 | 사진을 첨부하셔야 입력이 가능합니다.</span>
    		   <button type="button" class="close" data-dismiss="modal">
   		      <span aria-hidden="true">&times;</span>
   		    </button>
   		 </div>
    		  
	   <div class="modal-body">
	   <form action="dog-talking/modifyaction.jsp" method="post" enctype="multipart/form-data">
		<table class="table">
		<input type="hidden" name="num" value="<%=dto.getNum()%>">
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		  <tr>
	    	<td>
	    	<!-- 이미지 미리보기 -->
	        <img id="showimg" style="max-width: 200px; max-height:200px;"
	         src="<%=dto.getPhoto()==null?"":"dog-talking-photo/"+dto.getPhoto()%>">
	  		<input type="file" name="photo" value="<%=dto.getPhoto() %>" id="input-photo" style="visibility: hidden;" onchange="readURL(this)" required> 
		    </td>
		    
		    <td>
		    <div id="content">
		      <textarea name="content" placeholder="내용을 입력하세요" required style="width: 200px; height: 200px;"><%=dto.getContent() %></textarea>
		    </div>
	   		</td>
	  	</tr>
		<tr>
		  <td>
		    <span class="camera"><i class="fa-solid fa-camera-rotate icon"></i> 사진변경</span>
		  </td>
		  <td align="center">
		 	<button type="submit" class="btn btn-default border border-secondary">수정</button>
		  </td>
		</tr>
	  </table>
	  
	</form>
   	  	</div>
   		 </div>
  		</div>
	</div>
	
	
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
	
	  
	  <script type="text/javascript">
	  
	    //게시글 삭제
	  	$("#btn-board-del").click(function(){

			var a=confirm("게시글을 삭제하시겠습니까?");
			
			if(a){
				 location.href='dog-talking/delete.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>';
			}else{
				return false;
			}
	  	})
	    
	  
	  </script>
	  <button type="button" class="btn btn-default btn-sm border border-secondary"
	  onclick="location.href='index.jsp?main=dog-talking/board.jsp?currentPage=<%=currentPage%>'">목록</button>
	  </div>
	</div>
</body>
</html>