<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
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
	String realPath=getServletContext().getRealPath("/mypage/dogImg");
	
	//로그인한 사용자 아이디 가져와서 사용자 member_num(시퀀스)값 추출.
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
		<h1>유저마이페이지</h1>
		<%
		if (isMainDog == 1) {  
			DogProfileDto dto = dogDao.getMyMainDog(member_num);%>
			<div class="firstLine">
				<div class="rectangle">	
					<img src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
				</div>
				<div class="rectangle">
					<button style="float:right;" onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
		
						<p>강아지이름 : <%=dto.getName() %></p>
						<p>강아지성별 : <%=dto.getGender() %></p>
						<p>강아지크기 : <%=dto.getDogSize() %></p>
						<p>강아지생일 : <%=dto.getBirthday() %></p>
						<p>강아지사진 : <%=dto.getPhoto() %></p>
				</div>
			</div>
					<%	
		} else {%>
			<div class="firstLine">
				<div class="rectangle">	
					<img src="" id="dogprofile">
				</div>
				<div class="rectangle">
					<button style="float:right;" onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
					<b>대표 강아지가 없어요</b>
				</div>
			</div>
			<%
		}
		%>

		<div class="secondLine">
			<div class="rectangle">나의 활동</div>
			<div class="rectangle">나의 좋아요</div>
		</div>
	</div>
</body>
</html>