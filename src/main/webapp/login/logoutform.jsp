<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link rel="stylesheet" href="login/logout.css">
    
    <style type="text/css">
    .welcome{
    font-size: 2em;
    }
    
    .abc{
    color:red;
    }
    </style>
</head>


<body>
<%
//세션으로부터 아이디 얻기
MemberDao dao=new MemberDao();
String myid=(String)session.getAttribute("myid");
String num=dao.getNum(myid);
String isAdmin = dao.getAuth(myid);
String loginok = (String) session.getAttribute("loginok");
MemberDto dto=dao.getMemeber(myid);
DogProfileDao ddao=new DogProfileDao();
DogProfileDto ddto=ddao.getMyMainDog(num);


//db에서 아이디에 해당하는 닉네임 얻기
String nickname=dao.getNickname(myid);
session.setAttribute("isAdmin", isAdmin);

%>
	<div style="text-align: center">
		<b class="welcome"><%=nickname %>님, 방문을 환영합니다!</b><br>
		<%
		if(loginok!=null && isAdmin.equals("1")){%>
			<button type="button" onclick="location.href='index.jsp?main=mypage/adminMyPage.jsp'" class="btn btn-default btn-sm">관리자페이지 바로가기</button>
		<%}else{%>
			<span class="abc"></span><br>
			<button type="button" onclick="location.href='index.jsp?main=mypage/userMyPage.jsp'" class=" btn btn-default btn-sm">마이페이지 바로가기</button>
		<%}
		
		%>
		
		
<div class="dog">
  <div class="heart heart--1"></div>
  <div class="heart heart--2"></div>
  <div class="heart heart--3"></div>
  <div class="heart heart--4"></div>
  <div class="head">
      <div class="year year--left"></div>
      <div class="year year--right"></div>
      <div class="nose"></div>  
    <div class="face">
      <div class="eye eye--left"></div>
      <div class="eye eye--right"></div>
      <div class="mouth"></div>
    </div>
  </div>
  <div class="body">
    <div class="cheast"></div>
    <div class="back"></div>
    <div class="legs">
      <div class="legs__front legs__front--left"></div>
      <div class="legs__front legs__front--right"></div>
      <div class="legs__back legs__back--left"></div>
      <div class="legs__back legs__back--right"></div>
    </div>
    <div class="tail"></div>
  </div>
</div>
	</div>
	
	<script type="text/javascript">
	if(<%=ddto.getMainDog()%> === 0 && ("<%=dto.getAddr()%>" === "없음" || "<%=dto.getHp()%>"==="010-0000-0000")){
		$(".abc").text("대표 강아지와 상세 정보를 설정해주세요.");
	}else if("<%=dto.getAddr()%>" === "없음" || "<%=dto.getHp()%>"==="010-0000-0000"){
		$(".abc").text("상세 정보를 설정해주세요.");
	}else if(<%=ddto.getMainDog()%> === 0){
		$(".abc").text("대표 강아지를 설정해주세요.");
	}
	
	</script>
</body>
</html>