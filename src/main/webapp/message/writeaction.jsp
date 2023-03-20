<%@page import="message.MessageDto"%>
<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    
    String boardNum=request.getParameter("num");
    String content=request.getParameter("content");
    String sender=(String)session.getAttribute("myid");
    
    MessageDto dto=new MessageDto();
    dto.setBoardNum(boardNum);
    dto.setSender(sender);
    dto.setContent(content);
    
    MessageDao dao=new MessageDao();
    dao.insertMessage(dto);
    
    response.sendRedirect("../index.jsp?main=dog-friend/detail.jsp?num="+boardNum);
    %>