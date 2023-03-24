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
			border-radius: 200px;
			width:150px;
			height:150px;
			margin:0 auto;
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
	<div class="container main">
		<p> | 강아지 정보 더보기 | </p>
		<div style="width:800px;margin:0 auto;">
			<div class="firstLine">
				<div style="margin-bottom: 50px;">
					<button type="button" class="btn btn-light btn-sm" onclick="location.href='index.jsp?main=mypage/addMyDogForm.jsp'">새 강아지프로필 추가</button>
					<button type="button" class="btn btn-light btn-sm" onclick="location.href='index.jsp?main=mypage/selectMainDog.jsp'">대표 강아지 변경</button>
				</div>
				
				<%if(isMainDog == 0){%>
					<b>대표강아지가 없어요!</b>
				<%} else { 
					DogProfileDto dto = dogDao.getMyMainDog(member_num);
				%>
				<div class="row" style="">
					<div class="col-5" style="margin:0 auto;">
						<div class="col" style="position: absolute;">
							<i class="fa-solid fa-crown fa-2x" style="text-align: center;"></i>
						</div>
						<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
					</div>
					<div class="col" style="padding-top: 20px;">
						<button style="float: right;" class="btn btn-sm btn-light" onclick="location.href='index.jsp?main=mypage/updateDogProfile.jsp?idx=<%=dto.getIdx()%>'">강아지 프로필 수정</button>
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
						
					</div>
					
				</div>
					
				<%} %>
			
			</div>
			<div class="secondLine">
		
			<%for (DogProfileDto dto: myNotMainDogList){
				if (dto.getMainDog() == 0) {%>
					
				<div class="row" style="margin-top:75px;margin-bottom: 75px; ">
					<div class="col-5" style="margin:0 auto;">
						<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
					</div>
					<div class="col" style="padding-top: 20px;">
						<button style="float: right;" class="btn btn-sm btn-light" onclick="location.href='index.jsp?main=mypage/updateDogProfile.jsp?idx=<%=dto.getIdx()%>'">강아지 프로필 수정</button>
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
						
					</div>
				</div>
				
				<%}
			}%>
			</div>
		</div>
	</div>
</body>
</html>