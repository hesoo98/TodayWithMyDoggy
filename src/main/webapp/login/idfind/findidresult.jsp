<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
      	<div class = "found-success">
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