<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
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
<%
	//로그인한 사용자 아이디 가져와서 사용자 num값 추출.
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	String num = memberDao.getNum(id);
		
	int isMainDog = 0;//사용자가 대표강아지가 있는지 없는지 있으면 1 없으면 0
	
	DogProfileDao dogDao = new DogProfileDao();
	//int dogCnt = dogDao.getTotalDogCount(); //모든사용자들의 총 강아지 마리수.
	List<DogProfileDto> myDogList = dogDao.getMyDogList(num);//현재 로그인한 사용자의 강아지 리스트.(다른사람강아지 포함x)
	
	for (DogProfileDto dto: myDogList){
		if(dto.getMainDog() == 1) {
			isMainDog = 1;
		}
	}

%>
	<div class="container main" style="border:1px solid red;">
		<h1>강아지 정보 더보기</h1>
	
		<div class="firstLine">
			<div class="rectangle">
				<div class="button addNewProfile" onclick="location.href='index.jsp?main=mypage/addMyDogForm.jsp'">새 강아지프로필 추가</div>
				<div class="button changeMainDog">대표 강아지 변경</div>
			</div>
			<div class="rectangle">
				<%if(isMainDog == 0){%>
					<b>대표강아지가 없어요!</b>
				<%}%>
			</div>
		</div>
		<div class="secondLine">
	
		<%for (DogProfileDto dto: myDogList){
			if (dto.getMainDog() == 0) {%>
				
			<div class="rectangle">
				<p>강아지이름 : <%=dto.getName() %></p>
				<p>강아지성별 : <%=dto.getGender() %></p>
				<p>강아지크기 : <%=dto.getDogSize() %></p>
				<p>강아지생일 : <%=dto.getBirthday() %></p>
				<p>강아지사진 : <%=dto.getPhoto() %></p>
			</div>	
				
			<%}
		}%>
		
		</div>
	</div>
</body>
</html>