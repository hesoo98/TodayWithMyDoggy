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
  	  width: 500px;
  	  margin-left: 300px;
  	  margin-top: 20px;	
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
	}
	
	#comment-box{
	  margin: 10px; 20px;
	  border: 1px solid gray;
	}

</style>

</head>

<%

//num에 해당하는 data 받기
String num=request.getParameter("num");
DogTalkingBoardDao dao=new DogTalkingBoardDao();
DogTalkingBoardDto dto=dao.getData(num);

%>

<body>
	<div class="wrapper">
	
	  <div class="wrapper-subject">
	  <h2><%=dto.getSubject() %></h2>
	  <h4><%=dto.getNickname() %></h4>
	  <span class="gray-font"><%=dto.getWriteday() %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
	  </div>
	  
	  <div class="wrapper-content">
	    <%=dto.getContent() %>
	  </div>
	  
	  <div class="wrapper-comment">
	    <span id="likes" style="cursor: pointer;" onclick="updateLikes()" num=<%=dto.getNum() %>>likes</span>
	    <span> <%=dto.getLikes() %></span>
	    <span id="comment" style="cursor: pointer;"> 댓글 0</span>
	    <div id="comment-box">
	    <%
	    String loginok=(String)session.getAttribute("loginok");
	    
	    //로그인했다면 댓글 입력창
	    if(loginok!=null){%>
			<jsp:include page="answer.jsp"/>
	    <%}
	    %>
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
					  alert("왜안되니?")
				  }
				  
			  })
		
	  }
	  
	  //댓글
	  $(function(){
	  
		  //댓글창 안보이게
		  $("#comment-box").hide();
			  
		  //댓글 누르면 보이게
		  $("#comment").click(function(){
			  $("#comment-box").toggle();
			  
		  })
		  
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