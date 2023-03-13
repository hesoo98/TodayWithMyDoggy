<%@page import="board.notification.NotificationDao"%>
<%@page import="board.notification.NotificationDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	NotificationDao dao = new NotificationDao();
	NotificationDto dto = new NotificationDto();
	
	dto.setContent(content);
	dto.setTitle(title);
	
	dao.insertNotification(dto);
	
	//공지사항 리스트로 이동
	response.sendRedirect("../index.jsp?main=notification/notificationlist.jsp");
%>