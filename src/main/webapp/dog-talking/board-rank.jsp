<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

.container {
	width: 1200px;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.top{
	display: flex;
	justify-content: center;
}

.title{
	font-weight: 600;
	font-size: 2em;
}

.subtitle{
	margin-bottom: 20px;
}

.card-content {
	text-overflow: ellipsis;  /* 말줄임 적용 */
	display:inline-block;
	width: 220px;
	white-space: nowrap;
	overflow: hidden;
}

.card-img {
	width: 100%;
	overflow: hidden;
}

img {
	max-width: 100%;
	cursor: pointer;
	transition: transform .3s; /* Animation */
}
img:hover {
	transform: scale(1.1);
  -webkit-transform: scale(1.1); /* 크롬, 사파리 */
  -moz-transform: scale(1.1);  /* 파이어폭스 */
  -ms-transform: scale(1.1); /* IE */
  -o-transform: scale(1.1);  /* 오페라 */
}

.card{
	cursor: pointer;
}

.crown{
	color: gold;
}


</style>

<%

DogTalkingBoardDao dao = new DogTalkingBoardDao();
List<DogTalkingBoardDto> list = dao.getList();

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

</head>
<body>
	<div class="album py-5 bg-light">
		<div class="container">
			<span class="top title">이번주 인기멍멍이</span>
			<span class="top subtitle">일주일 간의 좋아요 순으로 집계됩니다</span>
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-md-4 g-4">

				<%
				for (DogTalkingBoardDto dto : list) {
				%>
				<div class="col">
					<i class="fa-solid fa-crown fa-lg crown"></i>
					<div class="card border-light mb-10" width="100%" style="border-radius: 10%;"
					onclick="location.href='index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum() %>'">
						<div class="card-img" id="img" style="border-radius: 12%; ">
							<input type="hidden" id="num" name="num" value="<%=dto.getNum() %>">
							<img class="img" class="bd-placeholder-img card-img-top" style="border-radius: 7%"  width="280px;"
								src="/TodayWithMyDoggy/dog-talking-photo/<%=dto.getPhoto()%>"
								height="230px;" xmlns="http://www.w3.org/2000/svg"
								role="img" aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
						</div>
						<div class="card-body">
							<p class="card-content"><%=dto.getContent()%></p>
							<div class="d-flex justify-content-between align-items-center">
								<%
								MemberDao mdao=new MemberDao();
								String nickname=mdao.getNickname(dto.getId()); //writernickname
								
							    String writerNum=mdao.getNum(dto.getId());
							    DogProfileDao pdao=new DogProfileDao();
							    DogProfileDto pdto=pdao.getMainDogInfo(writerNum); //강아지이름구하기
								%>
								<small class="text-muted"><%=nickname%>&nbsp;&nbsp;&nbsp;
								
								<% //강아지 정보 있을때만 강아지이름 출력
								if (pdto.getIdx()!=null){%>
									<img src="dog-talking-photo/<%=pdto.getPhoto() %>" width="30" height="30" style="border-radius: 20px;">
									<%=pdto.getName() %>
									<br>
								<%}else{%>
									<i class="fa-solid fa-bone"></i>
								<%}
								%>
								
									<div style="display: flex; justify-content: flex-end;">
									
									<%//댓글 있으면 댓글 수 , 없으면 조회수 출력
									DogTalkingAnswerDao adao=new DogTalkingAnswerDao();
									DogTalkingAnswerDto adto=new DogTalkingAnswerDto();
									List<DogTalkingAnswerDto> alist=adao.showAnswers(dto.getNum());
									
									if(alist.size()==0){%>
									<i class="fa-solid fa-paw"></i>
									조회수 <%=dto.getReadCount()%>
									<%}else{%>
									<i class="fa-solid fa-paw"></i>
									댓글 <%=alist.size()%>
									<%}
									%>
									<br>
									<i class="fa-solid fa-fire"></i>
									좋아요 <%=dto.getLikes()%></small>
									</div>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
				
			</div>
		</div>
		<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous"></script>
		<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	
</body>
</html>