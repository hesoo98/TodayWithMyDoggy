<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    
    <style type="text/css">
    .welcome{
    font-size: 2em;
    }
    </style>
</head>
<body>
<%
//세션으로부터 아이디 얻기
MemberDao dao=new MemberDao();
String myid=(String)session.getAttribute("myid");
String isAdmin = dao.getAuth(myid);
String loginok = (String) session.getAttribute("loginok");

//db에서 아이디에 해당하는 닉네임 얻기
String nickname=dao.getNickname(myid);
session.setAttribute("isAdmin", isAdmin);
%>
	<div style="text-align: center">
		<b class="welcome"><%=nickname %>님 방문을 환영합니다</b><br><br><br>
		<%
		if(loginok!=null && isAdmin.equals("1")){%>
			<button type="button" onclick="location.href='index.jsp?main=mypage/adminMyPage.jsp'" class="btn btn-default btn-sm">관리자페이지</button>
		<%}else{%>
			
			<button type="button" onclick="location.href='index.jsp?main=mypage/userMyPage.jsp'" class="btn btn-default btn-sm">마이페이지</button>
		<%}
		%>
		
	</div>
</body>
</html>