<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.notification.NotificationDto"%>
<%@page import="java.util.List"%>
<%@page import="board.notification.NotificationDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
body {
  padding-top: 70px;
  padding-bottom: 30px;
}

.container {
   width: 800px;
}

.content {

}
</style>


</head>
<body>
<%
	//아이디 
	//String myid = (String)session.getAttribute("myid");
	//로그인상태인지?
	String loginok = (String)session.getAttribute("loginok");
	
	String isAdmin = (String)session.getAttribute("isAdmin");
%>

   <article>
      <div class="container" role="main">
         <h2>공지사항 리스트</h2>
         
         <div>
         <%
         	if(loginok != null && isAdmin.equals("1")) {
         		%>
         		<button type="button" class="btn btn-sm btn-primary" onclick="location.href='index.jsp?main=notification/notificationform.jsp'">글쓰기</button>	
         		<%
         	}
         %>
            
         </div>
      </div>
   </article>
   
	<table class="table table-bordered" style="width:1000px;">
	<%
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
	NotificationDao dao = new NotificationDao();
	List<NotificationDto> list = dao.getAllNotifications();
	%>
		<caption><b>전체공지사항목록</b></caption>
	   	<tr>
	   		<td>num</td>
	   		<td>제목</td>
	   		<td>내용</td>
	   		<td>작성일</td>
	   	</tr>
	   	<%
	   	for(NotificationDto dto: list){
	   		%>
   		<tr>
   			<td><%=dto.getNum() %></td>
   			<td> <a href="index.jsp?main=notification/notificationdetail.jsp?num=<%=dto.getNum()%>">  <%=dto.getTitle() %></a></td>
   			<td><%=dto.getContent() %></td>
   			<td style="width: 200px;"><%=sdf.format(dto.getWriteday()) %></td>
   		</tr>
	   		<%
	   	}
	   	%>
	</table>
</body>
</html>