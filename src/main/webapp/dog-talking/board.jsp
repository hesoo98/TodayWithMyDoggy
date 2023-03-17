<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript" src="js/layout.js"></script>
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
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
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

.container {
	width: 1200px;
	margin-bottom: 50px;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
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


  #list-cnt{
    margin-left: 10px;
  }

</style>

</head>
<body>

	<%
    DogTalkingBoardDao dao=new DogTalkingBoardDao();
	DogTalkingBoardDto ddto=new DogTalkingBoardDto();
	
	int totalCount;
	int totalPage;//총페이지수
	int startPage;//각블럭의 시작페이지
	int endPage;//각블럭의 끝페이지
	int start; //각페이지의 시작번호
	int perPage=12; //한페이지에 보여질 글의 갯수
	int perBlock=5; //한블럭당 보여지는 페이지개수
	int currentPage; //현재페이지
	
	//총개수
	totalCount=dao.getTotalCount();
	//현재페이지번호 읽기(단 null 일때는 1페이지로 설정)
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
	currentPage=Integer.parseInt(request.getParameter("currentPage"));
	
	//총 페이지 갯수
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	
	//각블럭의 시작페이지..현재페이지가 3(s:1,e:5) 6(s:6 e:10)
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
	
	//총페이지가 8. (6~10...endpage를 8로 수정해주어야 한다)
	if(endPage>totalPage)
		endPage=totalPage;
	
	//각페이지에서 불러올 시작번호
	start=(currentPage-1)*perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<DogTalkingBoardDto> list=dao.getList(start, perPage);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	%>
	
	<!-- 인기글보기 -->
	<jsp:include page="../dog-talking/board-rank.jsp"/>
	

	<div class="album py-5 bg-light">
	 
		<div class="container">
		
		 <b id="list-cnt">총 <%=totalCount %>개의 게시글이 있습니다</b>
		 <%
		 
		 //로그인 한 유저만 글쓰기 버튼	  
		 String loginok=(String)session.getAttribute("loginok");
		 
		 if (loginok!=null){%>
		  <button type="button" class="btn btn-warning" onclick="location.href='index-form.jsp?main=dog-talking/write.jsp'">글쓰기</button>
		 <%}
		 %>
		 <br><br>
		 
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-md-4 g-4">

				<%
				for (DogTalkingBoardDto dto : list) {
				%>
				<div class="col">
					<div class="card border-light mb-10" width="100%" style="border-radius: 10%;"
					onclick="location.href='index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum() %>'">
						<div class="card-img" id="img" style="border-radius: 12%; ">
							<input type="hidden" id="num" name="num" value="<%=dto.getNum() %>">
							<img class="img" class="bd-placeholder-img card-img-top" style="border-radius: 7%"  width="230px;"
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
								<i class="fa-solid fa-bone"></i>
								<%=pdto.getName() %>
								<br>
									<div style="display: flex; justify-content: flex-end;">
									<i class="fa-solid fa-paw"></i>
									<%=dto.getReadCount()%>명이 봤어요
									<br>
									<i class="fa-solid fa-fire"></i>
									<%=dto.getLikes()%>명이 좋아해요</small>
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
	
	<!-- 페이징 출력 -->
	<div style="display: flex; justify-content: center;">
		<ul class="pagination">
			<%
			//이전
			if (startPage > 1) {
			%>
			<li><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=startPage - 1%>">이전</a>
			</li>
			<%
			}
			for (int pp = startPage; pp <= endPage; pp++) {
			if (pp == currentPage) {
			%>
			<li class="active"><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=pp%>"><%=pp%></a>
			</li>
			<%
			} else {
			%>

			<li><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=pp%>"><%=pp%></a></li>
			<%
			}
			}
			//다음
			if (endPage < totalPage) {
			%>
			<li><a href="index.jsp?main=dog-talking/board.jsp?currentPage=<%=endPage + 1%>">다음</a></li>
			<%
			}
			%>
		</ul>
	</div>
	
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous"></script>
		<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	
</body>
</html>