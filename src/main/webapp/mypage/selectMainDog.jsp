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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style type="text/css">
	
		.profileBox {
			border:5px solid yellow;
		}
		.rectangle {
			width:65%;
			float:left;
			border:1px solid black;
			margin : 10px;
			
		}
		.selectBox {
			width:30%;
			float:left;
			border:1px solid pink;
			margin-top: 10px;	
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

	<div class="container main" style="border:1px solid red;">
		<h1>나의 강아지들 프로필</h1>
		<div class="profileBox">
	
		<%for (DogProfileDto dto: myDogList){%>
			<div class="rectangle">
				<p>강아지이름 : <%=dto.getName() %></p>
				<p>강아지성별 : <%=dto.getGender() %></p>
				<p>강아지크기 : <%=dto.getDogSize() %></p>
				<p>강아지생일 : <%=dto.getBirthday() %></p>
				<p>강아지사진 : <%=dto.getPhoto() %></p>
				<img src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" width="100" height="100">
			</div>
			<div class="selectBox">
				<%if(dto.getMainDog() == 1) {%>
					<p>대표 강아지</p>
					<span class="glyphicon glyphicon-king"></span>
				<%} else {%>
					<p>일반 강아지</p>
					<button onclick="location.href='index.jsp?main=mypage/selectMainDogAction.jsp?idx=<%=dto.getIdx()%>'">이 강아지를 대표강아지로 설정</button>
					<%-- ?num=<%=member_num%>&idx=<%=dto.getIdx()%> --%>
				<%} %>
			</div>
			<%
		}%>
		</div>
	</div>
</body>
</html>