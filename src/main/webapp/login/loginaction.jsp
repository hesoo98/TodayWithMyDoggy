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
	String password=request.getParameter("password");
	String cbsave=request.getParameter("cbsave"); //체크 안하면 null, 체크하면 on
	
	MemberDao dao=new MemberDao();
	boolean b=dao.isIdPasswordCheck(id, password);
	String isAdmin = dao.getAuth(id);
	
	//아이디와 비번이 맞으면 3개의 세션 저장, 로그인메인 이동
	if(b){
		//세션유지시간(생략시 30분)
		session.setMaxInactiveInterval(60*60*8);
		session.setAttribute("loginok", "yes");
		session.setAttribute("myid", id);
		session.setAttribute("saveok", cbsave==null?null:"yes");
		session.setAttribute("isAdmin", isAdmin);
		
		//로그인 메인 이동
		response.sendRedirect("../index.jsp?main=mypage/userMyPage.jsp");
	}else{%>
		<script type="text/javascript">
		alert("아이디 또는 비밀번호가 맞지 않습니다.");
		history.back();
		</script>	
	<%}
%>
</body>
</html>