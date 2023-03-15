<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
<%
String id=request.getParameter("id");

MemberDao dao=new MemberDao();

String nickname=dao.getNickname(id);
%>

	<div>
		<b><%=nickname %>님의 가입을 환영합니다.</b>
		<br><br>
		
		<button type="button" class="btn btn-success" onclick="location.href='index.jsp?main=dog-friend/write.jsp'">로그인</button>
		<button type="button" class="btn btn-success" onclick="#">메인 페이지로</button>
	</div>
</body>
</html>