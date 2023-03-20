<%@page import="board.notification.NotificationDao"%>
<%@page import="board.notification.NotificationDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style>
		
		.container {
		   width: 800px;
		}
	</style>
	<%
		String num = request.getParameter("num");
		NotificationDao dao = new NotificationDao();
		NotificationDto dto = dao.getData(num);
	%>
</head>
<body>
   <article>
      <div class="container">
         <h2>공지사항 글쓰기 폼</h2>
         <br>
         <form method="post" action="notification/updateaction.jsp">
         	<!-- num을 hidden으로 updateaction.jsp로 넘겨준다 -->
         	<input type="hidden" name="num" value="<%=dto.getNum()%>">
         	
            <div class="subject">
               <div>제목</div>
               <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요" value="<%=dto.getTitle()%>">
            </div>
            <br>
            <div class="content">
               <div>내용</div>
               <textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요"><%=dto.getContent()%></textarea>
            </div>
            <button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>
         </form>
      </div>
   </article>
</body>
</html>