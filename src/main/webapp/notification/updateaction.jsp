<%@page import="board.notification.NotificationDto"%>
<%@page import="board.notification.NotificationDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	NotificationDao dao = new NotificationDao();
	NotificationDto dto = new NotificationDto();
	dto.setNum(num);
	dto.setContent(content);
	dto.setTitle(title);
	dao.updateNotification(dto);
	
	response.sendRedirect("../index.jsp?main=notification/notificationlist.jsp");
%>