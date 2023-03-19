<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.notification.NotificationDto"%>
<%@page import="java.util.List"%>
<%@page import="board.notification.NotificationDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>공지사항 리스트</title>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style>
		.container {
			margin-top: 50px;
			margin-bottom: 100px;
		}
		.writeBtn {
			float:right;
			margin-bottom: 20px;
		}
		
		.rectangle {
			border:2px solid pink;
		}
		.tableWrapper {
			margin:0 auto;
		}
	</style>
</head>
<body>
<%
	//로그인 상태인지?
	String loginok = (String)session.getAttribute("loginok");
	// 관리자 계정인지?
	String isAdmin = (String)session.getAttribute("isAdmin");
%>

	<div class="container">
		<div>
			<div class="btnWrapper float-end">
			 <%
			 // 로그인이 되어있고, 관리자면 글쓰기 버튼 보이게.
			 if(loginok != null && isAdmin.equals("1")) {%>
				<button type="button" class="rectangle btn btn-lg btn-warning writeBtn" onclick="location.href='index.jsp?main=notification/notificationform.jsp'">글쓰기</button>
			<%}%>
			</div>
	      	<div class="tableWrapper">
				<table class="table table-hover">
					<%
					SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
					NotificationDao dao = new NotificationDao();
					List<NotificationDto> list = dao.getAllNotifications();
					%>
					
					<tr>
						<td width="50">번호</td>
						<td width="150">제목</td>
						<td width="400">내용</td>
						<td>작성일</td>
					</tr>
					<%
					for(NotificationDto dto: list){
						%>
					<tr>
						<td><%=dto.getNum() %></td>
						<td> <a href="index.jsp?main=notification/notificationdetail.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %></a></td>
						<td><%=dto.getContent() %></td>
						<td style="width: 200px;"><%=sdf.format(dto.getWriteday()) %></td>
					</tr>
					<%}%>
				</table>
			</div>
		</div>
    </div>
</body>
</html>