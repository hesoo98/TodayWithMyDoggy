<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	
	// auth = 1로 설정
	String num = request.getParameter("num");//member num
	//관리자 임명시 유저의 강아지 프로필 다 날리고
	DogProfileDao dogDao = new DogProfileDao();
	DogProfileDto dogDto = new DogProfileDto();
	
	dogDao.deleteUserDog(num);
	
	
	
	String currentPage = request.getParameter("currentPage");
	MemberDao dao = new MemberDao();
	
	dao.updateAuth(num);
	
	response.sendRedirect("../../index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=" + currentPage);
%>