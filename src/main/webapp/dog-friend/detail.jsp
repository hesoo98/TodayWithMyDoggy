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

</style>
    
</head>

<body>
	  <script type="text/javascript">
	  $("span.likes").click(function(){
		  
			var num = $(this).attr("num");
			var tag=$(this);
			
			//alert(num);
			$.ajax({
				
				type:"get",
				dataType:"json",
				url:"dog-friend/likes.jsp",
				data:{"num":num},
				success:function(res){
					
					//alert(res.chu);
					tag.next().text(res.likes);
					
					tag.next().next().animate({"font-size":"20px"},1000,function(){
						
						//애니메이션이 끝난후 글꼴크기 0px
						$(this).css("font-size","0px")
					});
				}
				
				
			});
	  });
	  
	  </script>
<%
	
	DogFriendBoardDao dao=new DogFriendBoardDao();
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
			<caption><h3><b><%=dto.getSubject() %></b></h3></caption>
			<tr>
				<td>
					<b>작성자 : <%=dto.getNickname() %></b><br>
					<span><%=dto.getWriteday() %></span>
	  	<span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
				</td>
			</tr>
			
			<tr>
				<td>
					<%=dto.getContent() %>
					<br><br>
					<span class="likes" style="cursor: pointer;">likes <%=dto.getLikes() %></span><span> 댓글 0</span>
				</td>
				
			</tr>
			  

			
			<!-- 댓글 -->
			<tr>
				<td>
					<b class="acount">댓글 <span></span></b>
					<div class="alist">
						댓글 목록
					</div>
					
					<div class="aform form-inline">
						<input type="text" id="nickname" class="form-control" style="width: 100px;"
						placeholder="닉네임 입력">
						
						<input type="text" id="content" class="form-control" style="width: 300px;"
						placeholder="댓글 입력">
						
						<button type="button" id="btnanswer" class="btn btn-info">저장</button>
						
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
	</script>
</body>
</html>