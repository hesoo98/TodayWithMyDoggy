<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@page import="answer.placeShare.PlaceShareAnswerDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");

String content = request.getParameter("content");
System.out.println(content);

PlaceShareAnswerDto dto = new PlaceShareAnswerDto();
dto.setContent(content);

PlaceShareAnswerDao dao = new PlaceShareAnswerDao();
dao.updateAnswer(dto);
%>