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
		#dogprofile {
			border-radius: 200px;
			width:150px;
			height:150px;
			margin:0 auto;
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

	<div class="container" >
		<p> | 대표 강아지 선택 | </p>
		<div style="width: 950px;">
		<%for (DogProfileDto dto: myDogList) {%>
			<div class="box">
				<div class="row" style="margin:0px auto; margin-bottom: 50px;  width: 800px;">
					<div class="col-5 left_info">
						<div class="col crown_image" style="position: absolute;">
							<%if(dto.getMainDog() == 1) {%>
							<!-- 대표 강아지 -->
							<i class="fa-solid fa-crown fa-2x" style="text-align: center;"></i>
							<%} else {%>
							
							<%}%>
						</div>
						<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
					</div>
					<div class="col right_info" style="padding-top: 30px;">
						<div style="margin-left: 80px;">
							<span>이름 : <%=dto.getName() %></span><br>
							<span>성별 : </span>
							<% if(dto.getGender().equals("암")) { %>
								<i class="fa-solid fa-venus"></i>
							<%} else if(dto.getGender().equals("수")) {%>
								<i class="fa-solid fa-mars"></i>
							<%} else {%>
								<i class="fa-solid fa-venus-mars"></i>
							<%}%>
							<br>
							<span>크기 : <%=dto.getDogSize() %></span><br>
							<span>생일 : <%=dto.getBirthday() %></span><br>
							
							
							<%if(dto.getMainDog() == 1) {%>
							<!-- 대표 강아지 -->
							
							<%} else {%>
							<!-- 일반 강아지 -->
							<button
								type="button" class="btn btn-light btn-sm"
								style="position: absolute; right:0;"
								onclick="location.href='mypage/selectMainDogAction.jsp?idx=<%=dto.getIdx()%>'">대표강아지로 설정</button>
						<%}%>
						</div>
					
					</div>
				</div>
			</div>
		<%}%>
		</div>
	</div>
</body>
</html>