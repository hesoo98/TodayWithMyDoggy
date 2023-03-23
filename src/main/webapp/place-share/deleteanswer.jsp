<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%

String idx=request.getParameter("idx");

PlaceShareAnswerDao dao=new PlaceShareAnswerDao();
dao.deleteAnswer(idx);

%>