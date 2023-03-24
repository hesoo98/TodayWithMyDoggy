<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.notification.NotificationDto"%>
<%@page import="board.notification.NotificationDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style type="text/css">
	</style>
</head>
<body>
<%
	NotificationDao dao = new NotificationDao();
	String num = request.getParameter("num");
	
	// 클릭한 제목의 데이터 가져오기
	NotificationDto dto = dao.getData(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// 관리자 계정인지?
	String isAdmin = (String)session.getAttribute("isAdmin");

%>
<div class="container">
	<div class="main row" style="width: 100%; margin-top: 50px;">
		<input type="hidden" id="num" value="<%=num %>">
		<table class="table">
			<tr>
				<td><b><%=dto.getTitle()%></b></td>
			</tr>
			<tr>
				<td>
					<b>작성자: 관리자</b><br>
					<span class="day"><%=sdf.format(dto.getWriteday())%></span>
				</td>
			</tr>
			
			<tr>
				<td>
					<%=dto.getContent() %>
				</td>
			</tr>

			<tr>
				<td align="right">
				<!-- 이 부분은 관리자 계정일때만 보여야 함 -->
				
				<%if(isAdmin.equals("1")) { %>
					<button type="button" class="btn btn-light btn-sm" onclick="location.href='index.jsp?main=notification/updateform.jsp?num=<%=dto.getNum()%>'"><span class="glyphicon glyphicon-edit"></span>수정</button>
					<button type="button" class="btn btn-light btn-sm" onclick="funcdel()"><span class="glyphicon glyphicon-remove"></span>삭제</button>
					<button type="button" class="btn btn-light btn-sm" onclick="location.href='index.jsp?main=notification/notificationlist.jsp'"><span class="glyphicon glyphicon-list"></span>목록</button>
				<%} else if(isAdmin.equals("0")) {%>
				
				<%}%>
				</td>
			</tr>
		</table>
	</div>
</div>	
	
	
<script type="text/javascript">
	function funcdel(){
		var a = confirm("삭제하려면 확인버튼을 눌러주세요.");
		if(a) {
			location.href = "notification/delete.jsp?num=" + <%=dto.getNum()%>;
		}
	}
</script>
</body>
</html>