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
//세션으로부터 아이디 얻기
String myid=(String)session.getAttribute("myid");
//db에서 아이디에 해당하는 닉네임 얻기
MemberDao dao=new MemberDao();
String nickname=dao.getNickname(myid);

%>
	<div>
		<b><%=nickname %>님 환영합니다</b>
		
		<button type="button" onclick="location.href='mypage/userMyPage.jsp'">마이페이지</button>
		<button type="button" onclick="location.href='login/logoutaction.jsp'">로그아웃</button>
	</div>
</body>
</html>