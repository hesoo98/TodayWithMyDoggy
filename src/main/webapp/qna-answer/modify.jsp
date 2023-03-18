<%@page import="answer.qna.QnaAnswerDao"%>
<%@page import="answer.qna.QnaAnswerDto"%>
<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
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
String idx=request.getParameter("idx");

QnaBoardDao dao=new QnaBoardDao();
QnaBoardDto dto=dao.getData(num);

QnaAnswerDao adao=new QnaAnswerDao();
QnaAnswerDto adto=adao.getAnswer(num);
%>

<body>
   <div class="container wrapper">
   <form action="qna-answer/modifyaction.jsp" method="post">
   <span>문의 내용</span>
   <table class="table table-bordered" style="width: 800px;">
   
       <input type="hidden" name="num" value="<%=num%>">
       <input type="hidden" name="idx" value="<%=idx%>">
       <tr>
       	<td width="100">제목</td>
       	<td><%=dto.getTitle() %></td>
       </tr>
       
       <tr>
       	<td width="100">내용</td>
       	<td><%=dto.getContent() %></td>
       </tr>
       
       <tr>
       	<td>답변하기</td>
       	<td colspan="2">
       	<textarea name="content" placeholder="답변을 입력하세요" style="width: 100%; height: 300px;"><%=adto.getContent() %></textarea>
       	</td>
       </tr>
       
       <tr>
         <td colspan="2" align="center">
           <button type="submit">수정하기</button>
         </td>
       </tr>
       
   </table>
   </form>
   </div>
</body>
</html>