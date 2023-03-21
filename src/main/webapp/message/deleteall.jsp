<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%
    
    String nums=request.getParameter("nums");
    
    //읽어온 nums를 ,를 기준으로 분리 ->배열
    String [] num=nums.split(",");
    
    //배열의 개수만큼 delete한 후
    MessageDao dao=new MessageDao();

    for(String n:num){
    	dao.deleteMessage(n);
    }
    
    response.sendRedirect("../index.jsp?main=message/list.jsp");
    
    %>