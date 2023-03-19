<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="java.util.List"%>
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
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    

<style type="text/css">

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
	  
	  <!-- 프사 누르면 이동 -->
	  <a id="a-tag" href="../index.jsp?main=mypage/userMyPage.jsp?num=#">
	    <h4>
	      <img src="dog-talking-photo/04.png" style="width: 20px;">
	      <span style="background-color : pink; border-radius: 15px; font-size: 15px; margin-right: 5px;">프사</span><%=nickname %>
	    </h4>
	  </a>
	  
	  <!-- 펫정보 -->
	  <%
	    //writer_num
	    String writerNum=mdao.getNum(dto.getId());
	    DogProfileDao pdao=new DogProfileDao();
	    DogProfileDto pdto=pdao.getMainDogInfo(writerNum);
	    String loginok=(String)session.getAttribute("loginok");
	    if(pdto.getIdx()==null){%>
	    (멍멍)
	    <%}else{%>
	    <span style="font-size: 12px;"><%=pdto.getName() %> ( <%=pdto.getGender() %>|<%=pdto.getDogSize() %> )</span>
	    <%} %>
	  
	  <!-- 날짜, 조회수, 좋아요 밑 내용, 좋아요 클릭함수-->
	  <span class="gray-font"><%=sdf.format(dto.getWriteday()) %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %></span>
	  <hr>
	  </div>
		<%=dto.getContent() %>
		</td>
		</tr>
		<!-- 로그인되어있을때만 수정삭제 가능 -->
		<%if(loginok!=null && id.equals(nickname) || id.equals("admin")){
			%>
			<div>
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
			</div>
			
		<%}else{
		%>
			<div>
			<tr>
				<td>
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/board.jsp?currentPage=<%=currentPage%>'">
					<span></span>목록</button>
				</td>
			</tr>
			</div>
			<% }%>
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
	</script>
</body>
</html>