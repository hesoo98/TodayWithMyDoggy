<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    
    String num=request.getParameter("num");
    
    MessageDao dao=new MessageDao();
    dao.deleteMessage(num);
    
    %>