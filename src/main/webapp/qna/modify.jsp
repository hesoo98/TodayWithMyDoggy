<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
	
%>


<body>
   
   <div class="container wrapper">
   <form action="qna/modifyaction.jsp" method="post">
   <table class="table table-bordered" style="width: 800px;">
   <span>수정하기</span>
   	   <input type="text" name="num" value="<%=dto.getNum()%>">
       <tr>
       	<td>제목</td>
       	<td><input type="text" name="title" value="<%=dto.getTitle() %>"
       	 placeholder="제목을 입력하세요" style="width: 100%;"></td>
       </tr>
       
       <tr>
       	<td>내용</td>
       	<td colspan="2">
       	<textarea name="content" placeholder="내용을 입력하세요" style="width: 100%; height: 300px;">
       	<%=dto.getContent() %>
       	</textarea>
       	</td>
       </tr>
       
       <tr>
         <td colspan="3" align="center">
           <button type="submit" class="btn btn-warning btn-sm">수정하기</button>
         </td>
       </tr>
       
   </table>
   </form>
   </div>
   
</body>
</html>