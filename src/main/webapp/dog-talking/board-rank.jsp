<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="dog-talking/board.css">
<link rel="canonical"
	href="https://getbootstrap.kr/docs/5.1/examples/album/">

<!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<!-- Favicons -->
<link rel="apple-touch-icon"
	href="/docs/5.1/assets/img/favicons/apple-touch-icon.png"
	sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png"
	sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png"
	sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon"
	href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg"
	color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">

<meta name="theme-color" content="#7952b3">

<style>

.crown{
	color: #d9e4f4 ;
	size:0.8em;
}

</style>
<%
//프로젝트 경로구하기
	String root=request.getContextPath();

DogTalkingBoardDao dao=new DogTalkingBoardDao();

List<DogTalkingBoardDto> list=dao.getRankList();

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

</head>
<body>

	<script type="text/javascript">
	
	$(function(){
		
		let today=new Date();
		let month=today.getMonth()+1;
		
		const getWeekNumber = (dateFrom = new Date()) => {
			  // 해당 날짜 (일)
			  const currentDate = dateFrom.getDate();
			  
			  // 이번 달 1일로 지정
			  const startOfMonth = new Date(dateFrom.setDate(1));
			  
			  // 이번 달 1일이 무슨 요일인지 확인
			  const weekDay = startOfMonth.getDay(); // 0: Sun ~ 6: Sat
			  
			  // ((요일 - 1) + 해당 날짜) / 7일로 나누기 = N 주차
			  result= parseInt(((weekDay - 1) + currentDate) / 7) + 1;
			  
			  if(result==1){
				  return "첫";
			  }else if(result==2){
				  return "둘";
			  }else if(result==3){
				  return "셋";
			  }else if(result==4){
				  return "넷";
			  }else{
				  return "마지막";
			  }
			}

		$("#month").text(month);
		$("#week").text(getWeekNumber(today));
		
	})
	
	</script>

	<div class="album pb-5 bt-2">
		<div class="container">
		<br>
		<span style="display: flex; justify-content: center;"><span id="month"></span>월&nbsp;<span id="week"></span>째주의 인기강아지</span>
		<br>
					<div style="font-size: 13px; text-align:right; margin-left: 180px; color: gray;
					cursor: pointer;">더보기</div>
		
			<div
				class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-md-4 g-4">
				<%
				for (DogTalkingBoardDto dto : list) {
					String boardNum = dto.getNum();

					String boardId = dto.getId();

					MemberDao memberdao = new MemberDao();
					MemberDto memberdto = memberdao.getMemeber(boardId);

					String memberId = memberdto.getId();
					String memberNum = memberdao.getNum(memberId);

					DogProfileDao proDao = new DogProfileDao();
					DogProfileDto proDto = proDao.getMainDogInfo(memberNum);
					String proPhoto = proDto.getPhoto();

					DogTalkingAnswerDao answerDao=new DogTalkingAnswerDao();
					
					int totalAnswerCnt = answerDao.getTotalAnswerCount(boardNum);
				%>
				<div class="col">
				<i class="fa-solid fa-crown fa-lg crown"></i>
					<div class="card border-light mb-10" width="100%"
						style="border-radius: 10%;">
						<div class="card-img" id="img" style="border-radius: 12%;">
							<input type="hidden" id="num" name="num"
								value="<%=dto.getNum()%>"> 
								
							<img class="img" id="cardImg"
							class="bd-placeholder-img card-img-top"
							style="border-radius: 7%" width="600px;"
							src="dog-talking-photo/<%=dto.getPhoto()%>"
							height="200px;" xmlns="http://www.w3.org/2000/svg" role="img"
							aria-label="Placeholder: Thumbnail"
							preserveAspectRatio="xMidYMid slice" focusable="false"
							onclick="location.href='<%=root%>/index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum() %>'">
						</div>
						<div class="card-body">
							<span class="card-subject"
								style="font-size: 12px; cursor: pointer;"
								onclick="location.href='index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum()%>'"><%=dto.getContent()%></span>
							<div class="d-flex justify-content-between align-items-center">
								<div class="img-box"
									style="width: 25px; height: 25px; border-radius: 70%; overflow: hidden; float: left; margin-right: 2px;">
									
									<%if(proDto.getIdx()==null){%>
					
									<div style="background-color:#d9e4f4;
									text-align: center;line-height: 25px;">
										<%=memberdao.getNickname(memberId) %>
									</div>
								
									<%}else{%>
										
											<img src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>"
												id="profile-img" style="width: 100%; height: 100%">
									<%}
									%>
									
								</div>
								<div
									style="float: left; padding-top: 5px; font-size: 10px; color: gray">
									<%=memberdto.getNickname()%> &emsp;&emsp; 
									<i class="fa-solid fa-paw"></i><%=dto.getReadCount()%>
									&nbsp;<i class="fa-regular fa-heart"></i><%=totalAnswerCnt%>
								</div>
								<br>

							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>

		</div>
	</div>
		
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js"
	crossorigin="anonymous"></script>
	
</body>
</html>
