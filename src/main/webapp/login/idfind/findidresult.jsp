<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.found{
		width: 100%;
		height: 100%;
		border: 1px solid gray;
		border-radius: 10px;  			
		padding: 20px 50px;
	}
	
	input[type="text"]{
		outline: none;
		border: none;
		width: 200px;
		border-bottom: 1px solid lightgray;
	}
	
	input[type="text"]:focus{
		border-bottom-color: black;
	}

</style>

</head>
<body>

<%
 request.setCharacterEncoding("UTF-8");
String hp = request.getParameter("hp");
     
MemberDao dao = new MemberDao();
 String memberid = dao.getId(hp); //아이디를 디비에서 가져옴..실패시 널
 System.out.println(memberid);
%>

  <form name="idsearch" method="post">
  <input type="hidden" name="hp" value="<%=hp %>">
      <%
       if (memberid != "") {
      %>
      
      <div class = "container">
      	<div class = "found">
	      <div class ="found-id">회원님의 아이디는 <b><%=memberid%></b> 입니다.</div>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onclick="location.href='index.jsp?main=login/loginform.jsp'"/>
       	</div>
       </div>
      <%
	  } else{
	 %>
        <div class = "container">
      	<div class = "found">
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