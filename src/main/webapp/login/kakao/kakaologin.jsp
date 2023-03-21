<%@page import="java.util.jar.Attributes.Name"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

MemberDao dao=new MemberDao();
String nickname=request.getParameter("nickname");
String id=request.getParameter("id");
String email=request.getParameter("email");


String isAdmin = dao.getAuth(id);

MemberDto dto=new MemberDto();
dto.setNickname(nickname);
dto.setId(id);
dto.setHp("010-0000-0000");
dto.setAddr("주소를 선택하지 않았습니다.");
dto.setEmail(email);

if(dao.isIdCheck(dto.getId())==0){
dao.addMember(dto);
}

session.setMaxInactiveInterval(60*60*8);
session.setAttribute("loginok", "yes");
session.setAttribute("myid", dto.getId());
session.setAttribute("isAdmin", isAdmin);

response.sendRedirect("index.jsp?main=login/loginmain.jsp");

%>