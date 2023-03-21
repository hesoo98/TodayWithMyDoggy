<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    
</head>
<body>
<%
//세션에 저장된 loginok 읽기
	String loginok=(String)session.getAttribute("loginok");
	if(loginok!=null){ //로그아웃상태
		%>

		
		<jsp:include page="logoutform.jsp"/>
		<%
	}else{
		%>
		로그아웃됨
		<%
	}
%>
</body>
</html>