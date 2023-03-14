<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
DogTalkingBoardDto dto=new DogTalkingBoardDto();
String num=request.getParameter("num");
%>

	<form id="answerform" method="post" action="dog-talking/answeraction.jsp">
	  <input type="hidden" value="<%=num %>" name="num">
	  <textarea rows="2" cols="70" name="answer" placeholder="댓글을 입력하세요"></textarea>
	  <input type="submit" value="쓰기">
	</form>
</body>
</html>