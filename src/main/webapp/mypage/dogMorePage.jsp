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
		
		.button {
			border: 1px solid green;
		}
		
		.main{
			padding: 10px;
		}
		
		.addNewProfile {
			cursor: pointer;
		}
		
		.changeMainDog {
			cursor: pointer;
		}
	</style>
</head>
<body>
	<div class="container main" style="border:1px solid red;">
		<h1>강아지 정보 더보기</h1>
	
		<div class="firstLine">
			<div class="rectangle">
				<div class="button addNewProfile" onclick="location.href='index.jsp?main=mypage/addMyDogForm.jsp'">새 강아지프로필 추가</div>
				<div class="button changeMainDog">대표 강아지 변경</div>
			</div>
			<div class="rectangle">대표 강아지</div>
		</div>
		<div class="secondLine">
			<div class="rectangle">프로필2</div>
			<div class="rectangle">프로필3</div>
		</div>
	</div>
</body>
</html>