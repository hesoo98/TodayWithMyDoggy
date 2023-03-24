<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");

	MemberDao dao = new MemberDao();
	dao.deleteUser(num);
	//System.out.println("삭제들어옴");
	response.sendRedirect("../../index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=" + currentPage);
%>