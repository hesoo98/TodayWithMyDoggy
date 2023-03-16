<%@page import="member.MemberDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

  #list-cnt{
    margin-left: 10px;
  }

</style>

</head>
<body>

	<%
    DogTalkingBoardDao dao=new DogTalkingBoardDao();
	DogTalkingBoardDto ddto=new DogTalkingBoardDto();
	
	int totalCount;
	int totalPage;//총페이지수
	int startPage;//각블럭의 시작페이지
	int endPage;//각블럭의 끝페이지
	int start; //각페이지의 시작번호
	int perPage=5; //한페이지에 보여질 글의 갯수
	int perBlock=5; //한블럭당 보여지는 페이지개수
	int currentPage; //현재페이지
	
	//총개수
	totalCount=dao.getTotalCount();
	//현재페이지번호 읽기(단 null 일때는 1페이지로 설정)
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
	currentPage=Integer.parseInt(request.getParameter("currentPage"));
	
	//총 페이지 갯수
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	
	//각블럭의 시작페이지..현재페이지가 3(s:1,e:5) 6(s:6 e:10)
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
	
	//총페이지가 8. (6~10...endpage를 8로 수정해주어야 한다)
	if(endPage>totalPage)
		endPage=totalPage;
	
	//각페이지에서 불러올 시작번호
	start=(currentPage-1)*perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<DogTalkingBoardDto> list=dao.getList(start, perPage);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	%>
	
	<div class="container">
	
	  <b id="list-cnt">총 <%=totalCount %>개의 게시글이 있습니다</b>
	  <%
	  
	  //로그인 한 유저만 글쓰기 버튼	  
	  String loginok=(String)session.getAttribute("loginok");
	  
	  if (loginok!=null){%>
		  <button type="button" onclick="location.href='index-form.jsp?main=dog-talking/write.jsp'">글쓰기</button>
	  <%}
	  %>
	  <br><br>
	
	<table class="table table-hover" style="width: 700px;">
	  <tr>
	    <td width="50">번호</td>
	    <td width="300">내용</td>
	    <td width="150">작성자</td>
	    <td width="200">작성일</td>
	    <td width="50">조회수</td>
	  </tr>
	  
	  <jsp:include page="../dog-talking/board-rank.jsp"></jsp:include>
	  
	  <%
	  
	  //본문
	  for(DogTalkingBoardDto dto:list){
	  
		  //게시글 옆 댓글 수 표시
		  DogTalkingAnswerDao adao=new DogTalkingAnswerDao();
		  String board_num=dto.getNum();
		  List<DogTalkingAnswerDto> alist=adao.showAnswers(board_num);
	  
	  %>
		  
		  <tr>
		    <td><%=dto.getNum() %></td>
		    <td>
		      <a href="index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>">
		      <%=dto.getContent() %>
		      </a>
		      [<%=alist.size() %>]
		    </td>
		    
		    <%//닉네임찾기
			  MemberDao mdao=new MemberDao();
			  String nickname=mdao.getNickname(dto.getId());
		    %>
		    <td><%=nickname %></td>
		    <td><%=sdf.format(dto.getWriteday()) %></td>
		    <td><%=dto.getReadCount()%></td>
		  </tr>
		  
	  <%}
	  
	  
	  %>
	</table>
	
	</div>
	
	<!-- 페이징 출력 -->
	<div style="width: 500px; text-align: center;">
		<ul class="pagination">
			<%
			//이전
			if (startPage > 1) {
			%>
			<li><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=startPage - 1%>">이전</a>
			</li>
			<%
			}
			for (int pp = startPage; pp <= endPage; pp++) {
			if (pp == currentPage) {
			%>
			<li class="active"><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=pp%>"><%=pp%></a>
			</li>
			<%
			} else {
			%>

			<li><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=pp%>"><%=pp%></a></li>
			<%
			}
			}
			//다음
			if (endPage < totalPage) {
			%>
			<li><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=endPage + 1%>">다음</a></li>
			<%
			}
			%>
		</ul>
	</div>
</body>
</html>