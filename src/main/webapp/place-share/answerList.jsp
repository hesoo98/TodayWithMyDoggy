<%@page import="answer.placeShare.PlaceShareAnswerDto"%>
<%@page import="java.util.List"%>
<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
String boardnum = request.getParameter("boardnum");
PlaceShareAnswerDao dao = new PlaceShareAnswerDao();
List<PlaceShareAnswerDto> list = dao.getAllAnswers(boardnum);
%>