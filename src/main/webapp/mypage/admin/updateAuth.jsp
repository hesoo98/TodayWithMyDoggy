<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	//관리자 임명시 유저의 강아지 프로필 다 날리고 // 이건 나중에 구현
	// auth = 1로 설정
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	MemberDao dao = new MemberDao();
	
	dao.updateAuth(num);
	
	response.sendRedirect("../../index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=" + currentPage);
%>