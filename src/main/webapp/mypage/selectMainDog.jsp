<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="java.util.List"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		.profileBox {
			border:5px solid yellow;
			margin : 10px;
		}
		
		.rectangle {
			border:1px solid black;
		}
		
		.selectBox {
			border:1px solid pink;
		}
	</style>
	
</head>
<body>
<%
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	String member_num = memberDao.getNum(id);
		
	int isMainDog = 0;//사용자가 대표강아지가 있는지 없는지 판별하는 변수, 있으면 1 없으면 0
	
	DogProfileDao dogDao = new DogProfileDao();
	//int dogCnt = dogDao.getTotalDogCount(); //모든사용자들의 총 강아지 마리수.
	List<DogProfileDto> myDogList = dogDao.getMyDogList(member_num);//현재 로그인한 사용자의 강아지 리스트.(다른사람강아지 포함x)
	List<DogProfileDto> myNotMainDogList = dogDao.getMyNotMainDogList(member_num); // 대표가 아닌 강아지들 리스트
	//내 강아지들 중에 대표 강아지가 있는지 없는지 판별 하는 반복문.
	for (DogProfileDto dto: myDogList){
		if(dto.getMainDog() == 1) {
			isMainDog = 1;
		}
	}
%>

	<div class="container" style="border:1px solid red;">
		<h1>대표 강아지 선택 페이지</h1>
		
		
		<div class="row profilebox" style="width:800px;margin:0 auto;">
		<%for (DogProfileDto dto: myDogList) {%>
			<div class="col-7 rectangle">
				<div class="row">
					<div class="col-4">
						<img src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" width="100" height="100">
					</div>
					<div class="col">
						<p>강아지이름 : <%=dto.getName() %></p>
						<p>강아지성별 : <%=dto.getGender() %></p>
						<p>강아지크기 : <%=dto.getDogSize() %></p>
						<p>강아지생일 : <%=dto.getBirthday() %></p>
						<p>강아지사진 : <%=dto.getPhoto() %></p>
					</div>
				</div>
			</div>
			<div class="col selectBox">
				<%if(dto.getMainDog() == 1) {%>
					<!-- 대표 강아지 -->
					<i class="fa-solid fa-crown fa-3x" style="text-align: center;"></i>
				<%} else {%>
					<!-- 일반 강아지 -->
					<button type="button" class="btn btn-warning btn-lg"
					onclick="location.href='index.jsp?main=mypage/selectMainDogAction.jsp?idx=<%=dto.getIdx()%>'">이 강아지를 대표강아지로 설정</button>
				<%} %>
			</div>
			<%
		}%>
		</div>
	</div>
</body>
</html>