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

<%
//id session
String id=(String)session.getAttribute("myid");

//num에 해당하는 data 받기
String num=request.getParameter("num");
DogTalkingBoardDao dao=new DogTalkingBoardDao();
DogTalkingBoardDto dto=dao.getData(num);

//format
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>

<body>
	<div class="wrapper">
	

		  <%
		  MemberDao mdao=new MemberDao();
		  
		  //강아지 정보 불러오기
		  DogProfileDao ddao=new DogProfileDao();
		  
		  //writer
		  String writerNick=dto.getNickname();
		  //writer의 id
		  String writerId=mdao.getIdWithNickname(writerNick);
		  //id로 구한 멤버 num
		  String memberNum=mdao.getNum(writerId);
		  //글쓴 member의 pet info
		  DogProfileDto ddto=ddao.getPetInfo(memberNum);
		  MemberDto mdto=new MemberDto();
		  %>
		  
		  <div class="wrapper-subject">
		  <h2><%=dto.getSubject() %></h2>
		  
		  <a id="a-tag" href="../index.jsp?main=mypage/userMyPage.jsp?num=<%=memberNum%>">
		    <h4><img src="dog-talking-photo/04.png" style="width: 20px;"><span style="background-color : pink; border-radius: 15px; font-size: 15px; margin-right: 5px;">프사</span><%=dto.getNickname() %>
		  </a>
		  
		  <span style="font-size: 12px;"><%=ddto.getName() %>
		  (<%=ddto.getGender() %>|<%=ddto.getDogSize() %>|주소지<%=mdto.getAddr() %> )
		  
		  </span>

	  <div class="wrapper-subject">
	  <h2><%=dto.getSubject() %></h2>
	  
	  <h4><span style="background-color : pink; border-radius: 15px; font-size: 15px; margin-right: 5px;">프사</span><%=dto.getNickname() %>
	  
	  <%
	  
	  
	  MemberDao mdao=new MemberDao();
	  
	  //강아지 정보 불러오기
	  DogProfileDao ddao=new DogProfileDao();
	  
	  //writer
	  String writer_nick=dto.getNickname();
	  //writer의 멤버 num
	  String member_num=mdao.getNumWithNickname(writer_nick);
	  //글쓴 member의 pet info
	  DogProfileDto ddto=ddao.getPetInfo(member_num);
	  //조회수 1 증가
	  dao.updateReadCount(num);
	  %>
	  
	  <span style="font-size: 12px;"><%=ddto.getName() %>( <%=ddto.getGender() %>|<%=ddto.getDogSize() %> )</span>

	  </h4>
	  
	  <span class="gray-font"><%=sdf.format(dto.getWriteday()) %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %> 좋아요 <%=dto.getLikes() %></span>
	  </div>
	  
	  <hr class="line">
	  
	  <div class="wrapper-content">
	    <%=dto.getContent() %>
	    <%=dto.getPhoto() %>
	  </div>
	  
	  <hr class="line">
	  
	  <div class="wrapper-comment">
	    <span id="likes" style="cursor: pointer;" onclick="updateLikes()" num=<%=dto.getNum() %>>likes</span>
	    <span> <%=dto.getLikes() %></span>
	    
	    <!-- 댓글 -->
	    <%
	    DogTalkingAnswerDto adto=new DogTalkingAnswerDto();
	    DogTalkingAnswerDao adao=new DogTalkingAnswerDao();
	    String board_num=dto.getNum();
	    List<DogTalkingAnswerDto> list=adao.showAnswers(board_num);
	    
	  	  //댓글쓴사람의 강아지 정보 불러오기
		  
		  //answerwriter
		  String answerNick=adto.getNickname();
		  //writer의 id
		  String answerId=mdao.getIdWithNickname(answerNick);
		  //id로 구한 멤버 num
		  String answerWriterNum=mdao.getNum(answerId);
		  //댓글쓴 member의 pet info
		  DogProfileDto addto=ddao.getPetInfo(memberNum);
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
	          <!-- 이름부분 누르면 마이페이지로 이동 -->
	            <%
	            //for문 내부에서 댓글 쓴사람의 memberId -> num 구해서 mypage url
	            String answerWriterNumEach=mdao.getNum(mdao.getIdWithNickname(dogAnswer.getNickname()));
	            %>
	            <a href="../index.jsp?main=mypage/userMyPage.jsp?num=<%=answerWriterNumEach%>">
	          	  <span class="comment writer"><%=dogAnswer.getNickname() %></span>
	              <span id="comment-info">(<%=ddto.getGender() %>|<%=ddto.getDogSize() %>|주소지<%=mdto.getAddr() %> )</span>
	            </a>
	          </div>
	          
	          <span class="comment writeday"><%=sdf.format(dogAnswer.getWriteday()) %></span>
	          
				<%
				  // 내댓글 표시 + 댓글 수정,삭제버튼
				  
				  String nickname=mdao.getNickname(id);
				  
				  if(loginok!=null && dogAnswer.getNickname().equals(nickname)){%>
					  <span id="my-comment" style="float: left;">내댓글</span>
					  
	          <div id="btn-box">
			      <a id="btn-comment-mod" idx="<%=dogAnswer.getIdx() %>">수정</a>
			      <a id="btn-comment-del" idx="<%=dogAnswer.getIdx() %>" href="dog-talking/deleteanswer.jsp?idx=<%=adto.getIdx()%>">삭제</a>
	          </div>
				  <%}
				%>
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
;
	    String nickname=mdao.getNickname(id);
	    
	    //currentpage
	    String currentPage=request.getParameter("currentPage");
	  
	    if(nickname.equals(dto.getNickname())){%>
	  		<button type="button" onclick="location.href='../index.jsp?main=dog-talking/#####.jsp?num=<%=dto.getNum()%>'">수정</button>
	  		<button type="button" id="btn-board-del">삭제</button>	    	
	    <%}
	  %>
	  
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
	  <button type="button" onclick="history.back()">뒤로가기</button>
	</div>
</body>
</html>