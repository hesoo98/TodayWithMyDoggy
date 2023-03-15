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

<%

//num에 해당하는 data 받기
String num=request.getParameter("num");
DogTalkingBoardDao dao=new DogTalkingBoardDao();
DogTalkingBoardDto dto=dao.getData(num);

//format
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>

<body>
	<div class="wrapper">
	
	  <div class="wrapper-subject">
	  <h2><%=dto.getSubject() %></h2>
	  
	  <h4><span style="background-color : pink; border-radius: 15px; font-size: 15px; margin-right: 5px;">프사</span><%=dto.getNickname() %>
	  
	  <%
	  //강아지 정보 불러오기
	  
	  %>
	  
	  <span style="font-size: 12px;">멍멍(11) 중성 대전 어쩌구</span>
	  </h4>
	  
	  <span class="gray-font"><%=sdf.format(dto.getWriteday()) %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
	  </div>
	  
	  <hr class="line">
	  
	  <div class="wrapper-content">
	    <%=dto.getContent() %>
	  </div>
	  
	  <hr class="line">
	  
	  <div class="wrapper-comment">
	    <span id="likes" style="cursor: pointer;" onclick="updateLikes()" num=<%=dto.getNum() %>>likes</span>
	    <span> <%=dto.getLikes() %></span>
	    
	    <!-- 댓글 -->
	    <%
	    DogTalkingAnswerDao adao=new DogTalkingAnswerDao();
	    String board_num=dto.getNum();
	    List<DogTalkingAnswerDto> list=adao.showAnswers(board_num);
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
	        for(DogTalkingAnswerDto adto:list){%>
	        
	          <span class="comment writer"><%=adto.getNickname() %></span>
	          <span class="comment writeday"><%=sdf.format(adto.getWriteday()) %></span>
	          
				<%
				  // 내댓글 표시 + 댓글 수정,삭제버튼
			 	  String id=(String)session.getAttribute("myid");
				  MemberDao mdao=new MemberDao();
				  String nickname=mdao.getNickname(id);
				  
				  if(loginok!=null && adto.getNickname().equals(nickname)){%>
					  <span id="my-comment" style="float: left;">내댓글</span>
					  
	          <div id="btn-box">
			      <a id="btn-comment-mod" idx="<%=adto.getIdx() %>">수정</a>
			      <a id="btn-comment-del" idx="<%=adto.getIdx() %>" href="dog-talking/deleteanswer.jsp?idx=<%=adto.getIdx()%>">삭제</a>
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
			  alert(num);
			  
			  $.ajax({
				  
				  type:"get",
				  url:"dog-talking/likes.jsp",
				  dataType:"json",
				  data:{"num":num},
				  success: function(res){
					  alert("왜안되니?");;;;;;;;;;
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
		  
	         $(this).parent().parent().find("#gu-an").hide();
	         $("span.updateAn").show();
		  
	  })
	  
	  
	  </script>
	  
	  <%

		//myid session
		String id=(String)session.getAttribute("myid");
	    MemberDao mdao=new MemberDao();
	    String nickname=mdao.getNickname(id);
	    
	    //currentpage
	    String currentPage=request.getParameter("currentPage");
	  
	    if(nickname.equals(dto.getNickname())){%>
	  		<button type="button" onclick="location.href='../index.jsp?main=dog-talking/#####.jsp?num=<%=dto.getNum()%>'">수정</button>
	  		<button type="button" onclick="location.href='../index.jsp?main=dog-talking/delete.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>'">삭제</button>	    	
	    <%}
	  %>
	  <button type="button" onclick="history.back()">뒤로가기</button>
	</div>
</body>
</html>