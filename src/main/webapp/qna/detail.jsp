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

//비밀글 여부
String secret="";
if(dto.getSecret().equals("1")){
	secret="비밀글";
}else{
	secret="공개글";
}

%>

<body>
	
   <div class="container wrapper">
   <table class="table table-bordered" style="width: 800px;">
   		<input type="hidden" name="num" value="<%=dto.getNum()%>">
       <tr>
       	<td width="100">제목</td>
       	<td><%=dto.getTitle() %></td>
       	<td>
       	<%=secret %>
       	</td>
       </tr>
       
       <tr>
       	<td width="100">내용</td>
       	<td colspan="2"><%=dto.getContent() %></td>
       </tr>
       
       <!-- 본인글 / 관리자 / 기본 -->
       <tr>
         <td colspan="3" align="center">
       	 <%
       	 if(myid.equals(dto.getId())){%>
	         <button type="button" onclick="location.href='index.jsp?main=qna/modify.jsp?num=<%=dto.getNum()%>'">수정</button>
	         <button type="button" onclick="delFunc()">삭제</button>
       	 <%}else if(isAdmin.equals("1")){%>
       		 <button type="button">답변하기</button>
       	 <%}
       	 %>
         <button type="button" onclick="location.href='index.jsp?main=qna/qnalist.jsp'">목록</button>
         </td>
       </tr>
       
   </table>
   </div>
   
   <script type="text/javascript">
   
   	function delFunc(){
   		
   		var a=confirm("문의글을 삭제하시겠습니까?");
   		
   		if(a){
   			location.href="qna/delete.jsp";
   		}else{
   			return false;
   		}
   	}
   
   </script>
   
</body>
</html>