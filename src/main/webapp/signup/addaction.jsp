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
String password=request.getParameter("password");
String hp=request.getParameter("hp1")+"-"+request.getParameter("hp2")+"-"+request.getParameter("hp3");
String addr=request.getParameter("address");
String email=request.getParameter("email1")+"@"+request.getParameter("email2");

MemberDto dto=new MemberDto();
dto.setNickname(nickname);
dto.setId(id);
dto.setPassword(password);
dto.setHp(hp);
dto.setAddr(addr);
dto.setEmail(email);

dao.addMember(dto);

response.sendRedirect("../index.jsp?main=signup/signupsuccess.jsp?id="+id);
%>