<%@page import="answer.qna.QnaAnswerDto"%>
<%@page import="answer.qna.QnaAnswerDao"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@page import="board.qna.QnaBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
<style>

	.wrapper{
		margin: 100px 200px;
	}

</style>
</head>

<%
	String num=request.getParameter("num");
	
	QnaBoardDao dao=new QnaBoardDao();
	QnaBoardDto dto=dao.getData(num);
	
	//세션아이디
	String myid=(String)session.getAttribute("myid");
	//관리자여부
	String isAdmin=(String)session.getAttribute("isAdmin");
	
	//답변 불러오기
	QnaAnswerDao adao=new QnaAnswerDao();
	QnaAnswerDto adto=adao.getAnswer(num);

%>

<body>
	
   <div class="container wrapper">
   <table class="table table-bordered" style="width: 800px;">
       <tr>
       	<td width="100">제목</td>
       	<td><%=dto.getTitle() %></td>
       	<td>
       	<%
	      //비밀글 여부
	      if(dto.getSecret().equals("1")){%>
	      <span>비밀글</span>
	      <%}else{%>
	      <span>공개글</span>
	      <%}
       	%>
       	</td>
       </tr>
       
       <tr>
       	<td width="100">내용</td>
       	<td colspan="2"><%=dto.getContent().replace("\n", "<br>") %></td>
       </tr>
       
       <!-- 관리자 답변이 있으면 아래 내용 출력 -->
       <%
       if(adto.getIdx()!=null){%>
    	   
       <tr>
         <td rowspan="2">답변</td>
           <td colspan="2">관리자 : <%=adto.getAdminId() %></td>
       </tr>
       
       <tr>
         <td colspan="2">
           <%=adto.getContent().replace("\n", "<br>") %>
         </td>
       </tr>
       <%}
       %>
       
       <!-- 본인글 / 관리자 / 기본 -->
       <tr>
         <td colspan="3" align="center">
       	 <%
       	 if(myid.equals(dto.getId())){%>
	         <button type="button" onclick="location.href='index.jsp?main=qna/modify.jsp?num=<%=dto.getNum()%>'">수정</button>
	         <button type="button" onclick="delFunc()">삭제</button>
       	 <%}else if(isAdmin.equals("1") && adto.getIdx()==null){%>
       		 <button type="button" onclick="location.href='index.jsp?main=qna-answer/write.jsp?num=<%=dto.getNum()%>'">답변하기</button>
       	 <%}else if(isAdmin.equals("1") && adto.getIdx()!=null){%>
       		 <button type="button" onclick="location.href='index.jsp?main=qna-answer/modify.jsp?idx=<%=adto.getIdx()%>&num=<%=dto.getNum()%>'">답변수정</button>
       		 <button type="button" onclick="delAnswerFunc()">답변삭제</button>
       	 <%}
       	 %>
         <button type="button" onclick="location.href='index.jsp?main=qna/qnalist.jsp'">목록</button>
         </td>
       </tr>
       
   </table>
   </div>
   
   <script type="text/javascript">
   
   	function delFunc(){
   		
   		//작성자 글 삭제
   		var a=confirm("문의글을 삭제하시겠습니까?");
   		
   		if(a){
   			location.href="qna/delete.jsp?num=<%=dto.getNum()%>";
   		}else{
   			return false;
   		}
   		
   	}
   	
   	function delAnswerFunc(){

   		//관리자 답변 삭제
   		var a=confirm("관리자 답변을 삭제하시겠습니까?");
   		
   		if(a){
   			location.href="qna-answer/delete.jsp?idx=<%=adto.getIdx()%>";
   		}else{
   			return false;
   		}
   	}
   
   </script>
   
</body>
</html>