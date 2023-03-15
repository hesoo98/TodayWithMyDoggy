<%@page import="answer.dogFriend.DogFriendAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String idx=request.getParameter("idx");

DogFriendAnswerDao dao=new DogFriendAnswerDao();
dao.deleteAnswer(idx);

%>