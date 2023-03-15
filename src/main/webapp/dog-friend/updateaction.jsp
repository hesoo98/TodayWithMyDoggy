<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@page import="board.dogFriend.DogFriendBoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

DogFriendBoardDto dto=new DogFriendBoardDto();
String myid=(String)session.getAttribute("myid");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

String num=request.getParameter("num");
String currentPage=request.getParameter("currentPage");

DogFriendBoardDao dao=new DogFriendBoardDao();

//dto에 저장
dto.setNickname(myid);
dto.setSubject(subject);
dto.setContent(content);
dto.setNum(num);

//dao선언
dao.updateBoard(dto);

//이동
response.sendRedirect("../index.jsp?main=dog-friend/board.jsp?num="+num+"&currentPage="+currentPage);
%>