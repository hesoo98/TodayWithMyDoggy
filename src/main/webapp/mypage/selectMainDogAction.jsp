<%@page import="member.MemberDao"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	// 멤버의 num 구하기
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	String member_num = memberDao.getNum(id);
	
	//나의 모든 강아지들을 일반 강아지로 변경하고
	DogProfileDao dogDao = new DogProfileDao();
	dogDao.allChangeNomalDog(member_num);
	
	//선택한 강아지만 대표강아지로 설정
	String idx = request.getParameter("idx");
	dogDao.selectMainDog(idx);
	
	//response.sendRedirect("../index.jsp?main=mypage/userMyPage.jsp");//작동안함.
%>
<script>
	location.href = document.referrer;
</script>

