<%@page import="java.util.List"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style type="text/css">
		.rectangle {
			float:left;
			border:1px solid black;
			width: 400px;
			height: 300px;
		}
		.main{
			padding: 10px;
		}
		#dogprofile {
			border:1px solid gray;
			border-radius: 200px;
			width:200px;
			height:200px;
		}
	</style>
</head>
<body>
<%
	String num = (String)session.getAttribute("");
	DogProfileDao dao = new DogProfileDao();
	int dogCnt = dao.getTotalDogCount();
	List<DogProfileDto> myDogList = dao.getMyDogList(num);
	for (DogProfileDto dto: )
%>
	<div class="container main" style="border:1px solid red;">
		<h1>유저마이페이지</h1>
	
		<div class="firstLine">
			<div class="rectangle">
				<img src="" id="dogprofile">
			</div>
			<div class="rectangle">
				<button style="float:right;" onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
			<%if (dogCnt == 0) {%>
				<b>등록된 강아지가 없어요!</b>
			<%}%>
				
			</div>
		</div>
		<div class="secondLine">
			<div class="rectangle">나의 활동</div>
			<div class="rectangle">나의 좋아요</div>
		</div>
	</div>
</body>
</html>