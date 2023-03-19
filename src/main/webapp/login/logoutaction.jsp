<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
<%
//loginok 세션제거
	session.removeAttribute("loginok");
	
//loginmain 이동
	response.sendRedirect("../index.jsp?main=login/loginmain.jsp");
%>
</body>
</html>