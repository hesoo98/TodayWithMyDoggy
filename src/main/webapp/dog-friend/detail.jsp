<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="answer.dogFriend.DogFriendAnswerDto"%>
<%@page import="java.util.List"%>
<%@page import="answer.dogFriend.DogFriendAnswerDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberDao"%>
<%@page import="board.dogFriend.DogFriendBoardDto"%>
<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    

<style type="text/css">

	/* 댓글 검정색으로 */
	#comment-list a{
	color: black;
	}
    #a-tag{
      color: black;
    }
    
    #a-tag:hover{
      color: black;
      text-decoration: none;
    }

	.wrapper{
  	  width: 800px auto;
  	  margin: 50px 160px;
  	  border: 1px lightgray solid;
  	  border-radius: 30px;
  	  padding: 40px 90px;
	}
	
	.wrapper-subject{
	  margin-bottom: 50px;	
	}
	
	.gray-font{
 	  color: gray;	
	}
	
	.wrapper-comment{
	  margin-bottom: 20px;
	  width: 80% auto;
	}
	
	.line{
	  width: 90% auto;
	  margin: 50px 0px;
	}
	
	#photo{
	  width: 200px;
	  height: 200px;
	}
	
	/* 댓글 */
	.comment{
	  opacity: 0.8;
	}
	
	.writer{
	  font-weight: 600;
	  font-size: 14px;
	  position: absolute;
	}
	
	.writeday {
	  float: right;
	}
	
	.content{
	  margin-left: 5px;
	}
	
	#btn-box{
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

	}
	
	#comment-info{
	  font-size: 10px;
	  font-weight: 300;
	}
	
	#commenter-div{
	  float: left;
	}
	
	
</style>

</head>

<body>

<%
	
	DogFriendBoardDao dao=new DogFriendBoardDao();
	MemberDao mdao=new MemberDao();
	String num=request.getParameter("num");
	String currentPage=request.getParameter("currentPage");
	DogFriendBoardDto dto=dao.getData(num);

String id=(String)session.getAttribute("myid"); //sessionid
String sessionNickname=mdao.getNickname(id); //sessionnickname
String nickname=mdao.getNickname(dto.getId()); //writernickname
	
	//조회수 1 증가
	dao.updateReadCount(num);
	
	//dto 가져오기
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>

	<div style="margin:30px 30px;">
	<input type="hidden" id="num" value="<%=num%>">
		<table class="table table-bordered" style="width: 500px;">
		<tr>
		<td>
			<h3><b><%=dto.getSubject() %></b></h3>
			
			 <div class="wrapper-subject">
	  
	  <a id="a-tag" href="../index.jsp?main=mypage/userMyPage.jsp?num=#">
	    <h4>
	      <img src="dog-talking-photo/04.png" style="width: 20px;">
	      <span style="background-color : pink; border-radius: 15px; font-size: 15px; margin-right: 5px;">프사</span><%=nickname %>
	    </h4>
	  </a>
	  
	  <!-- pet info -->
	  <%
	    //writer_num
	    String writerNum=mdao.getNum(dto.getId());
	    DogProfileDao pdao=new DogProfileDao();
	    DogProfileDto pdto=pdao.getMainDogInfo(writerNum);
	    
	    if(pdto.getIdx()==null){%>
	    (멍멍)
	    <%}else{%>
	    <span style="font-size: 12px;"><%=pdto.getName() %> ( <%=pdto.getGender() %>|<%=pdto.getDogSize() %> )</span>
	    <%} %>
	  
	  <span class="gray-font"><%=sdf.format(dto.getWriteday()) %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
	  <hr>
	  </div>
		<%=dto.getContent() %>
		<div class="wrapper-comment">
	    <span id="likes" style="cursor: pointer;" onclick="updateLikes()" num=<%=dto.getNum() %>>likes</span>
	    <span> <%=dto.getLikes() %></span>
	    
	    <!-- 댓글 -->
	    <%
	    DogFriendAnswerDto adto=new DogFriendAnswerDto();
	    DogFriendAnswerDao adao=new DogFriendAnswerDao();
	    String boardNum=dto.getNum();
	    List<DogFriendAnswerDto> list=adao.showAnswers(boardNum);
		  
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
	        for(DogFriendAnswerDto dogAnswer:list){%>
	        
	          <div id="commenter-div">
	          <!-- 이름부분 누르면 마이페이지로 이동 -->
	            <a href="index.jsp?main=mypage/userMyPage.jsp">
	          	 
	          	<%
	          	//댓글쓴사람 강아지정보 불러오기
			    String answerNum=mdao.getNum(dogAnswer.getId());
			    DogProfileDto answerPdto=pdao.getMainDogInfo(answerNum);
	          	%> 
	          	 
	          	 <span class="comment writer"><%=mdao.getNickname(dogAnswer.getId()) %>
	          	
	          	 <% 
	          	if(answerPdto.getIdx()==null){%>
	    	    (멍멍)
	    	    <%}else{%>
	    	    <span id="comment-info"><%=answerPdto.getName() %>(<%=answerPdto.getGender() %>|<%=answerPdto.getDogSize() %>|지역)</span>
	    	    <%} %>
	         
	            </a>
	          </div>
	          <br>
	          
	          <span class="comment writeday"><%=sdf.format(dogAnswer.getWriteday()) %></span>
	          
				<%
				  // 내댓글 표시 + 댓글 수정,삭제버튼
				  
				  if(loginok!=null && sessionNickname.equals(mdao.getNickname(dogAnswer.getId()))){%>
					  <span id="my-comment" style="float: left;">내댓글</span>
			
	          <div id="btn-box">
			      <a id="btn-comment-mod" idx="<%=dogAnswer.getIdx() %>" href="">수정</a>
			      <a id="btn-comment-del" idx="<%=dogAnswer.getIdx() %>" href="dog-talking/deleteanswer.jsp?idx=<%=adto.getIdx()%>">삭제</a>
	          </div>
				  <%}
				%>
				<!-- 겹치는것 방지를 위해 span 이쪽으로 옮김 -->
				</span>
	          <br>
	          <span id="gu-an" class="comment content"><%=dogAnswer.getContent() %></span>
	          
	          <!-- 수정창 hidden -->
	          <br>
	          <!--<input class="mod-form" type="text" value="<%=dogAnswer.getContent()%>">  -->
	          
	          <!-- 영돈 -->
	          <span class="updateAn">
              <textarea><%=dogAnswer.getContent().replace("\n", "<br>")%></textarea>
              <button class="btn btn-warning wd" value="<%=dogAnswer.getIdx()%>" 
              style="width: 100px">댓글수정</button>
              </span>
	          
                        
	          
	          <hr>
	          
	       <% }
	        %>
	      </div>
	    </div>
	  </div>

			
				</td>
			</tr>

			
			<tr>
			
				<td>
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/write.jsp'">
					<span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
					
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/update.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>'">
					<span class="glyphicon glyphicon-edit"></span>수정</button>
					
					<button type="button" class="btn btn-default"
					onclick="funcdel(<%=num%>,<%=currentPage%>)">
					<span class="glyphicon glyphicon-remove"></span>삭제</button>
					
					
					
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/board.jsp?currentPage=<%=currentPage%>'">
					<span></span>목록</button>
				</td>
			</tr>
		</table>
		
		
	</div>

	<script type="text/javascript">
		function funcdel(num,currentPage){
			//alert(num+","+currentPage);
			var a=confirm("삭제하려면 [확인]을 눌러주세요.");
			if(a){
				location.href="dog-friend/delete.jsp?num="+num+"&currentPage="+currentPage;
			}
		}
		
		  //좋아요 (미완성)
		  function updateLikes(){
			  var num=$("#likes").attr("num");
			  
			  <%
			  //로그인 한 사람만 좋아요 가능
			  if(loginok==null){%>
				  var a=alert("로그인 후 이용해주세요.");
				  return false;
				  
			  <%}%>
				  
				  $.ajax({
					  
					  type:"get",
					  url:"dog-friend/likes.jsp",
					  dataType:"json",
					  data:{"num":num},
					  success: function(res){
						  location.reload();
					  }
					  
				  })
		  }
		  
		  //댓글
		  $(function(){
			  
			  //댓글창 안보이게
			  //$("#comment-box").hide();

			  //댓글 수정창 안보이게
			  $("span.updateAn").hide();
				  
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
					  url:"dog-friend/deleteanswer.jsp",
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
			  
		         $(this).parent().parent().find("#gu-an").hide();
		         $("span.updateAn").show();
			  
		  })
	</script>
</body>
</html>