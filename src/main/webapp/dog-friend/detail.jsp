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
	
	.wrapper-content{
	  height: 300px;
	}
	
	.wrapper-comment{
	  margin-bottom: 20px;
	  width: 80% auto;
	}
	
	.line{
	  width: 90% auto;
	  margin: 50px 0px;
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
	
	
</style>

</head>

<body>

<%
	
	DogFriendBoardDao dao=new DogFriendBoardDao();
	MemberDao mdao=new MemberDao();
	String num=request.getParameter("num");
	String currentPage=request.getParameter("currentPage");
	
	//조회수 1 증가
	dao.updateReadCount(num);
	
	//dto 가져오기
	DogFriendBoardDto dto=dao.getData(num);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>

	<div style="margin:30px 30px;">
	<input type="hidden" id="num" value="<%=num%>">
		<table class="table table-bordered" style="width: 500px;">
			<h3><b><%=dto.getSubject() %></b></h3>
			<tr>
				<td>
					<b>작성자 : <%=mdao.getNickname(dto.getId())%></b><br>
					<span><%=dto.getWriteday() %></span>
	  	<span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
				</td>
			</tr>
			
			<tr>
				<td>
					<%=dto.getContent() %>
								 <div class="wrapper-comment">
	    <span id="likes" style="cursor: pointer;" onclick="updateLikes()" num=<%=dto.getNum() %>>likes</span>
	    <span> <%=dto.getLikes() %></span>
	    
	    <!-- 댓글 -->
	    <%
	    DogFriendAnswerDao adao=new DogFriendAnswerDao();
	    String board_num=dto.getNum();
	    List<DogFriendAnswerDto> list=adao.showAnswers(board_num);
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
	        for(DogFriendAnswerDto adto:list){%>
	        
	          <span class="comment writer"><%=mdao.getNickname(dto.getId()) %></span>
	          <span class="comment writeday"><%=sdf.format(adto.getWriteday()) %></span>
	          
				<%
				  // 내댓글 표시 + 댓글 수정,삭제버튼
			 	  String id=(String)session.getAttribute("myid");
				  String nickname=mdao.getNickname(adto.getId());
				  
				  if(loginok!=null && mdao.getNickname(adto.getId()).equals(nickname)){%>
					  <span id="my-comment" style="float: left;">내댓글</span>
					  
	          <div id="btn-box">
			      <a id="btn-comment-mod" idx="<%=adto.getIdx() %>">수정</a>
			      <a id="btn-comment-del" idx="<%=adto.getIdx() %>" href="dog-friend/deleteanswer.jsp?idx=<%=adto.getIdx()%>">삭제</a>
	          </div>
				  <%}
				%>
	          <br>
	          <span id="gu-an" class="comment content"><%=adto.getContent() %></span>
	          
	          <!-- 수정창 hidden -->
	          <br>
	          <!--<input class="mod-form" type="text" value="<%=adto.getContent()%>">  -->
	          
	          <!-- 영돈 -->
	          <span class="updateAn">
              <textarea><%=adto.getContent().replace("\n", "<br>")%></textarea>
              <button class="btn btn-warning wd" value="<%=adto.getIdx()%>" 
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