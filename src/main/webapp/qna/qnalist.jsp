<%@page import="java.text.SimpleDateFormat"%>
<%@page import="answer.qna.QnaAnswerDto"%>
<%@page import="answer.qna.QnaAnswerDao"%>
<%@page import="member.MemberDao"%>
<%@page import="board.qna.QnaBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

	.wrapper-top{
		float: right;
		margin: 10px 10px;
	}
	

	input:focus{
		outline: none;
	}
	
	.a-tag{
		color: black;
	}
	
	.a-tag:hover{
		color: black;
	}
	
	.my-qna{
		color: gold;
	}
	
	.disabled{
		color: gray;
	}
	
	/* 페이지 */

.pagination{
  padding: 30px 0;
}

.pagination ul{
  margin: 0;
  padding: 0;
  list-style-type: none;
}

.pagination a{
  display: inline-block;
  padding: 10px 18px;
  color: #222;
}

.p1 a{
  width: 40px;
  height: 40px;
  line-height: 40px;
  padding: 0;
  text-align: center;
}

.p1 li.active{
	background-color: #fce694;
	border-radius: 100%;
	color: #fff;
}

td:not(.table-title), tr{
	text-align: center;
}

.table-title{
	text-align: left;
	text-overflow: ellipsis;  /* 말줄임 적용 */
	width: 240px;
	white-space: nowrap;
	overflow: hidden;
}

</style>

</head>

<%
QnaBoardDao dao=new QnaBoardDao();
QnaBoardDto dto=new QnaBoardDto();

//검색 word 찾기
String word=request.getParameter("word");

int totalCount;
int totalPage;//총페이지수
int startPage;//각블럭의 시작페이지
int endPage;//각블럭의 끝페이지
int start; //각페이지의 시작번호
int perPage=10; //한페이지에 보여질 글의 갯수
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
List<QnaBoardDto> list=dao.showAllQna(start, perPage, word);

SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");

//로그인여부 체크
String loginok=(String)session.getAttribute("loginok");
//관리자여부 체크
String isAdmin=(String)session.getAttribute("isAdmin");
//세션아이디
String myid=(String)session.getAttribute("myid");

%>

<body>

	<div class="wrapper container">
	
	<div class="wrapper-top">
		 
	<%
	// 상단 안내 부분
	if(loginok!=null && isAdmin.equals("0")){  //로그인 상태+일반회원이면 글쓰기 버튼 %> 
		<span class="my-qna">내가 작성한 글은 노란색으로 표시됩니다.</span>
		<button class="btn btn-warning" onclick="location.href='index.jsp?main=qna/write.jsp'">문의하기</button>
	<%}else if(loginok!=null && isAdmin.equals("1")){  //관리자 %>
		<span class="alert alert-warning">관리자님 안녕하세요</span>
	<%}else{%>
		<span class="alert alert-warning">로그인하셔야 문의가 가능합니다.</span>
	<%}
	%>
	</div>
	
	<table class="table">
	  <tr>
	    <td width="50">번호</td>
	    <td width="100">작성자</td>
	    <td width="250">제목</td>
	    <td width="150">날짜</td>
	    <td width="100">답변</td>
	  </tr>
	  
	  <%
		//내용
		
		for(QnaBoardDto q:list){
		
			//닉네임설정
			MemberDao mdao=new MemberDao();
			String nickname=mdao.getNickname(q.getId());
			//비밀글확인
			String flag=dao.isSecret(q.getNum());
			
		%>
		  <tr>
		    <td><%=q.getNum() %></td>
		    <td><%=nickname %></td>
		    
		    <!-- 제목 -->
			<td class="table-title">
		    <%
		    //비밀글 체크
		    if(flag.equals("1")){ 
		    	
		    	//비밀글
		    	if(loginok!=null && myid.equals(q.getId())){ //본인-> 링크 + 열린자물쇠%>
	    		<a class="a-tag my-qna" href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>">
	    		<i class="fa-solid fa-lock-open"></i>
			    <%=q.getTitle() %>
		 		</a>
			 		
		    	<%}else if(isAdmin.equals("1")){ //관리자-> 링크 + 닫힌자물쇠 %>
		    	<a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>">
	    		<i class="fa-solid fa-lock"></i>
			    <%=q.getTitle() %>
		 		</a>
		    	
		    	<%}else{ //그 외-> 링크x + 닫힌자물쇠 %>
				    <i class="fa-solid fa-lock"></i>
				    <span class="disabled"><%=q.getTitle() %></span>
		    	<%}
		    	
		    }else{ 
		    	
		    	//공개글
		    	if(loginok!=null && myid.equals(q.getId())){ //내가쓴 공개글%>
		    	<a class="a-tag my-qna" href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>">
			    <%=q.getTitle() %>
			  	</a>
		    	<%}else{%>
		    	<a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>">
			    <%=q.getTitle() %>
			  	</a>
		    	<%}%>
		   <%}
		    %>
			  
		    </td>
		    
		    <td><%=sdf.format(q.getWriteday()) %></td>
		    
		    <%
		    //답변여부 확인
		    QnaAnswerDao adao=new QnaAnswerDao();
		    QnaAnswerDto adto=adao.getAnswer(q.getNum());
		    
		    if(adto.getIdx()==null){%>
			    <td>
			    <button type="button" style="height: 30px; line-height: 15px;" class="btn border-secondary" disabled>대기중</button>
			    </td>
		    <%}else{%>
		    	<td>
		    	<button type="button" style="height: 30px; line-height: 15px;" class="btn border-secondary" disabled>답변완료</button>
		    	</td>
		    	
		    <%}
		    %>
		  </tr>
		<%}
	  %>
	  
	</table>
	</div>
	
	<!-- 페이징 출력 -->
	<div style="display: flex; justify-content: center;">
		<ul class="pagination p1">
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
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</html>