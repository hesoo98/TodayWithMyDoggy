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

		}
	</style>
</head>
<body>
<%
	DogProfileDao dao = new DogProfileDao();
	int dogCnt = dao.getTotalDogCount();
%>
	<div class="container main" style="border:1px solid red;">
		<h1>유저마이페이지</h1>
	
		<div class="firstLine">
			<div class="rectangle"><img src="https://via.placeholder.com/200x200" width="200" height="200" id="dogprofile" style="border-radius: 200px;"></div>
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