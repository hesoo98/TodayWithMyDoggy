<%@page import="answer.placeShare.PlaceShareAnswerDto"%>
<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");

String boardnum = request.getParameter("boardnum");
String myid = (String)session.getAttribute("myid");
String content = request.getParameter("content");
String currentPage = request.getParameter("currentPage");

PlaceShareAnswerDto dto = new PlaceShareAnswerDto();
dto.setBoardNum(boardnum);
dto.setId(myid);
dto.setContent(content);

PlaceShareAnswerDao dao = new PlaceShareAnswerDao();
dao.insertAnswer(dto);
%>