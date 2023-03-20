<%@page import="message.MessageDao"%>
<%@page import="message.MessageDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
</head>

<%

String num=request.getParameter("num");

MessageDao dao=new MessageDao();
MessageDto dto=dao.showMessageDetail(num);

dao.updateRead(num);
%>

<body>
	<%=dto.getContent() %>
</body>
</html>