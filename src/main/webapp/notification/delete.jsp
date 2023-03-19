<%@page import="board.notification.NotificationDao"%>
<%@page import="board.notification.NotificationDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String num = request.getParameter("num");
	
	NotificationDao dao = new NotificationDao();
	dao.deleteNotification(num);
	
	////TodayWithMyDoggy/mypage/dogImg/
	response.sendRedirect("../index.jsp?main=notification/notificationlist.jsp");
%>