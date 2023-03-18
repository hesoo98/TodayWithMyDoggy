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

	.wrapper{
		width: 700px;
		margin: 50px 20px;
	}
	
	.a-tag{
		color: black;
	}
	
	.a-tag:hover{
		color: black;
	}
	
	.disabled{
		color: gray;
	}
	

</style>

</head>

<%

//로그인여부 체크
String loginok=(String)session.getAttribute("loginok");
//관리자여부 체크
String isAdmin=(String)session.getAttribute("isAdmin");
//세션아이디
String myid=(String)session.getAttribute("myid");

%>

<body>

	<div class="wrapper container">
	
	<%
	// 상단 안내 부분
	if(loginok!=null && isAdmin.equals("0")){  //로그인 상태+일반회원이면 글쓰기 버튼 %> 
		<button class="btn btn-warning" onclick="location.href='index.jsp?main=qna/write.jsp'">문의하기</button>
	<%}else if(loginok!=null && isAdmin.equals("1")){  //관리자 %>
		<span class="alert alert-warning">관리자님 안녕하세요</span>
	<%}else{%>
		<span class="alert alert-warning">로그인하셔야 문의가 가능합니다.</span>
	<%}
	%>
	
	<table class="table table-hover">
	  <tr>
	    <td width="50">번호</td>
	    <td width="100">작성자</td>
	    <td width="200">제목</td>
	    <td width="50">조회수</td>
	    <td width="50">답변</td>
	  </tr>
	  
	  <%
		//내용
		QnaBoardDao dao=new QnaBoardDao();
		List<QnaBoardDto> list=dao.showAllQna();
		
		for(QnaBoardDto dto:list){
		
			//닉네임설정
			MemberDao mdao=new MemberDao();
			String nickname=mdao.getNickname(dto.getId());
			//비밀글확인
			String flag=dao.isSecret(dto.getNum());
			
		%>
		  <tr>
		    <td><%=dto.getNum() %></td>
		    <td><%=nickname %></td>
		    
		    <!-- 제목 -->
			<td>
		    <%
		    //비밀글 체크
		    if(flag.equals("1")){ 
		    	
		    	//비밀글
		    	if(myid.equals(dto.getId())){ //본인-> 링크 + 열린자물쇠%>
	    		<a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=dto.getNum()%>">
	    		<i class="fa-solid fa-lock-open"></i>
			    <%=dto.getTitle() %>
		 		</a>
			 		
		    	<%}else if(isAdmin.equals("1")){ //관리자-> 링크 + 닫힌자물쇠 %>
		    	<a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=dto.getNum()%>">
	    		<i class="fa-solid fa-lock"></i>
			    <%=dto.getTitle() %>
		 		</a>
		    	
		    	<%}else{ //그 외-> 링크x + 닫힌자물쇠 %>
				    <i class="fa-solid fa-lock"></i>
				    <span class="disabled"><%=dto.getTitle() %></span>
		    	<%}
		    	
		    }else{ //공개글%>
		    	<a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=dto.getNum()%>">
			    <%=dto.getTitle() %>
			  	</a>
		   <%}
		    %>
			  
		    </td>
		    
		    <td><%=dto.getReadcount() %></td>
		    <td>대기중</td>
		  </tr>
		<%}
	  %>
	  
	  
	</table>
	</div>
</body>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</html>