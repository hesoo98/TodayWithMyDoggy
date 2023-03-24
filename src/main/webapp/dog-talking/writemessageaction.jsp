<%@page import="message.MessageDto"%>
<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    
    String num=request.getParameter("num");
    String receiver=request.getParameter("receiver");
    String content=request.getParameter("content");
    String sender=(String)session.getAttribute("myid");
    
    MessageDto dto=new MessageDto();
    dto.setReceiver(receiver);
    dto.setSender(sender);
    dto.setContent(content);
    
    MessageDao dao=new MessageDao();
    dao.insertMessage(dto);
    
    response.sendRedirect("../index.jsp?main=dog-talking/detail.jsp?num="+num);
    %>