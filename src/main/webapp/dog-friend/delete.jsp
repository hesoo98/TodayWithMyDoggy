<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
    String num=request.getParameter("num");
    
    DogFriendBoardDao dao=new DogFriendBoardDao();
    dao.deleteBoard(num);
    
    response.sendRedirect("../index.jsp?main=dog-friend/board.jsp");
    %>