<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%

String idx=request.getParameter("idx");

DogTalkingAnswerDao dao=new DogTalkingAnswerDao();
dao.deleteAnswer(idx);

%>