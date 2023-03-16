<%@page import="board.dogFriend.DogFriendBoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
DogFriendBoardDto dto=new DogFriendBoardDto();
String num=request.getParameter("num");
%>

	<form method="post" action="dog-friend/answeraction.jsp" style="margin-bottom: 50px;">
	  <input type="hidden" value="<%=num %>" name="num">
	  <div style="display: inline-flex ; margin: 20px 0px;">
	    <textarea cols="100" name="answer" placeholder="댓글을 입력하세요"></textarea>
	    <input type="submit" value="입력" style="height: 20px; align-items: center;">
	  </div>
	</form>
</body>
</html>