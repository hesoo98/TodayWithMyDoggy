<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
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
 request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String hp = request.getParameter("hp");
     
MemberDao dao = new MemberDao();
MemberDto dto= dao.getMemeber(id);
 String pwd = dao.getPassword(id); //비밀번호를 디비에서 가져옴..실패시 널
%>

<form name="idsearch" method="post">
      <%
       if (pwd != "" && dto.getHp().equals(hp)) {
      %>
     
      <div class = "container">
      	<div class = "found-success">
	      <div class ="found-id">회원님의 비밀번호는 <%=pwd%> 입니다.</div>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onclick="location.href='index.jsp?main=login/loginform.jsp'"/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      등록된 정보가 없습니다
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnback" value="다시 찾기" onclick="history.back()"/>
 		    <input type="button" id="btnjoin" value="회원가입" onclick="location.href='index.jsp?main=signup/terms.jsp'"/>
       	</div>
       </div>
       
       <%
  }
 %> 
      </form>
</body>
</html>