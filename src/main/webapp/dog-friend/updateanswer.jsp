<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="dao" class="answer.dogFriend.DogFriendAnswerDao"/>
<jsp:useBean id="dto" class="answer.dogFriend.DogFriendAnswerDto"/>
<jsp:setProperty property="*" name="dto"/>
<%
dao.updateAnswer(dto);

%>
