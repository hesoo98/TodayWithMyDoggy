<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("myid");
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMemeber(id);
	
	String nickname = request.getParameter("nickname");
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String addr = request.getParameter("addr");
	
	memberDto.setNickname(nickname);
	memberDto.setHp(hp1+"-"+hp2+"-"+hp3);
	memberDto.setEmail(email1 + "@" + email2);
	memberDto.setAddr(addr);
	
	memberDao.updateMemberProfile(memberDto);
	response.sendRedirect("../../index.jsp?main=login/loginmain.jsp");
%>