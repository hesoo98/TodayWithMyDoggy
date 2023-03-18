<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	
	String boradNum = request.getParameter("num");
	PlaceShareBoardDao dao = new PlaceShareBoardDao();
	dao.deleteBoard(boradNum);
	
	response.sendRedirect("../index.jsp?main=place-share/boardList.jsp");
%>