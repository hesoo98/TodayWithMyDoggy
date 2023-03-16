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
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		.rectangle {
			border:1px solid black;
		}
		
		.button {
			border: 1px solid green;
		}
		
		.main{
			padding: 10px;
		}
		
		#dogprofile {
			border:1px solid gray;
			border-radius: 200px;
			width:200px;
			height:200px;
			margin:0 auto;
		}
		div.p {
		font-size: 3.5rem;
		}
	</style>
</head>
<body>
<%
	String realPath=getServletContext().getRealPath("/mypage/dogImg");
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	String member_num = memberDao.getNum(id);
		
	int isMainDog = 0;//사용자가 대표강아지가 있는지 없는지 판별하는 변수, 있으면 1 없으면 0
	
	DogProfileDao dogDao = new DogProfileDao();
	List<DogProfileDto> myDogList = dogDao.getMyDogList(member_num);				// 현재 로그인한 사용자의 모든 강아지 리스트.(다른사람강아지 포함x)
	List<DogProfileDto> myNotMainDogList = dogDao.getMyNotMainDogList(member_num);	// 현재 로그인한 사용자의 대표가 아닌 강아지들 리스트
	
	//내 강아지들 중에 대표 강아지가 있는지 없는지 판별 하는 반복문.
	for (DogProfileDto dto: myDogList){
		if(dto.getMainDog() == 1) {
			isMainDog = 1;
		}
	}
%>
	<div class="container main" style="border:1px solid red;">
		<h1>강아지 정보 더보기</h1>
	<div class="" style="width:800px;margin:0 auto;">
		<div class="firstLine">
			<div class="rectangle mx-auto d-block">
				<button type="button" class="btn btn-warning btn-lg" onclick="location.href='index.jsp?main=mypage/addMyDogForm.jsp'">새 강아지프로필 추가</button>
				<button type="button" class="btn btn-warning btn-lg" onclick="location.href='index.jsp?main=mypage/selectMainDog.jsp'">대표 강아지 변경</button>
			</div>
			
			<%if(isMainDog == 0){%>
				<b>대표강아지가 없어요!</b>
			<%} else { 
				DogProfileDto dto = dogDao.getMyMainDog(member_num);
			%>
			<div class="row">
				<div class="col-6 rectangle" style="margin:0 auto;">
					<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
				</div>
				<div class="col rectangle">
					<p>강아지이름 : <%=dto.getName() %></p>
					<p>강아지성별 : <%=dto.getGender() %></p>
					<p>강아지크기 : <%=dto.getDogSize() %></p>
					<p>강아지생일 : <%=dto.getBirthday() %></p>
					<p>강아지사진 : <%=dto.getPhoto() %></p>
				</div>
				<div class="col">
					<i class="fa-solid fa-crown fa-3x" style="text-align: center;"></i>
				</div>
			</div>
				
			<%} %>
		
		</div>
		<div class="secondLine">
	
		<%for (DogProfileDto dto: myNotMainDogList){
			if (dto.getMainDog() == 0) {%>
				
			<div class="row" style="margin-top:50px;">
				<div class="col-6 rectangle" style="margin:0 auto;">
					<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
				</div>
				<div class="col rectangle">
					<p>강아지이름 : <%=dto.getName() %></p>
					<p>강아지성별 : <%=dto.getGender() %></p>
					<p>강아지크기 : <%=dto.getDogSize() %></p>
					<p>강아지생일 : <%=dto.getBirthday() %></p>
					<p>강아지사진 : <%=dto.getPhoto() %></p>
				</div>
			</div>
				
			<%}
		}%>
		
		</div>
		</div>
	</div>
</body>
</html>