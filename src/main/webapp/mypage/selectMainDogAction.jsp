<%@page import="member.MemberDao"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	//프로젝트 경로 구하기
	String root = request.getContextPath();
	//대표 강아지로 설정버튼 누르면~
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	String member_num = memberDao.getNum(id);
	
	String idx = request.getParameter("idx");
	DogProfileDao dogDao = new DogProfileDao();
	List<DogProfileDto> myDogList = dogDao.getMyDogList(member_num);
	
	//나의 모든 강아지들을 일반 강아지로 변경하고
	dogDao.allChangeNomalDog(member_num);
	
	//선택한 강아지만 대표강아지로 설정
	dogDao.selectMainDog(idx);
	
	//System.out.println(root);
	//"../index.jsp?main=mypage/dogMorePage.jsp"
	//root + "/mypage/dogMorePage.jsp"
	//root + "src/webapp/mypage/dogMorePage.jsp"
	//response.sendRedirect("../index.jsp?main=mypage/userMyPage.jsp");
%>
<script>
	location.href = document.referrer;
</script>

