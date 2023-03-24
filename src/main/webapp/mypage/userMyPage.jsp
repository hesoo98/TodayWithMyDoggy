<%@page import="answer.qna.QnaAnswerDto"%>
<%@page import="answer.qna.QnaAnswerDao"%>
<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		@font-face {
		    font-family: 'Dovemayo_gothic';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		.rectangle {
			border:1px solid black;
		}
		
		#dogprofile {
			border-radius: 200px;
			width:150px;
			height:150px;
			margin:0 auto;
		}
		div > p {
			font-size: 2rem;
		}
		
	</style>
</head>
<body>
<%
	String realPath=getServletContext().getRealPath("/mypage/dogImg");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//로그인한 사용자 아이디 가져와서 사용자 member_num(시퀀스)값 추출.
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMemeber(id);
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

	QnaBoardDao qnaDao = new QnaBoardDao();
	List<QnaBoardDto> myQList = qnaDao.getMyBoardList(id);
%>
<div style="" class="">
	<div class="container" style="width: 880px;">
		<div class="row" style="padding-top:50px; height: 350px;" id="myprofile_maindog">
			<div class="col-5" style="">
				<p style="margin-left:50px; margin-bottom: 30px;font-size: 1.5rem;"><%=memberDto.getNickname() %>님의 프로필</p>
				<div style="margin-left:50px; margin-bottom: 20px;">
					<i class="fa-solid fa-id-card"></i>
					<span>아이디 : <%=memberDto.getId() %></span><br>
					<i class="fa-solid fa-phone"></i>
					<span><%=memberDto.getHp() %></span><br>
					<i class="fa-solid fa-map-location-dot"></i>
					<span><%=memberDto.getAddr() %></span><br>
					<i class="fa-solid fa-envelope"></i>
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=memberDto.getEmail() %></span><br>
					<i class="fa-solid fa-calendar-days"></i>
					<span><%=sdf.format(memberDto.getCreateDay()) %>에 생성함.</span><br><br>
				</div>
				<button type="button"
							class="btn btn-light btn-sm"
							style="position:absolute; bottom: 0; right: 0;"
							onclick="location.href='index.jsp?main=mypage/userProfileUpdateForm.jsp'">나의 프로필 수정</button>
			</div>
			<div class="col-7" style="">
				<!-- 대표강아지 프로필 칸 -->
				<%if (isMainDog == 1) {
					// 사용자가 대표 강아지가 있을 경우
					DogProfileDto dto = dogDao.getMyMainDog(member_num);%>
				<p style="margin-left:50px; margin-bottom: 30px; font-size: 1.5rem;">대표 강아지 프로필</p>
				<div style="margin: 0 auto;" class="row">
					<div style="margin-left: 30px;">
						<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
					</div>
					<div style="margin-left: 70px; margin-top: 25px;" class="">
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
				<button type="button" 
						class="btn btn-light btn-sm"
						style="position:absolute; bottom: 0; right: 100px;"
						onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
				
				<%} else {%>
				<!-- 사용자가 대표 강아지가 없는 경우 -->
				<p style="margin-left:50px; font-size:1.5rem; margin-bottom: 30px;">대표 강아지 프로필</p>
				<div class="row">
					<div style="margin-left:30px;">
						<img class="" src="/TodayWithMyDoggy/mypage/dogImg/dogImgNotFound.png" id="dogprofile">
					</div>
					<div style="margin-left:50px;">
						<button type="button" 
							class="btn btn-light btn-sm"
							style="position:absolute; bottom: 0; right: 100px;"
							onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
						<b>대표 강아지가 없어요</b>
					</div>
				</div>
				<%}%>
			</div>
		</div>
		
		

		<div style="height: 400px; margin-top: 50px;">
			<div style="margin-bottom: 20px;">
				<p style="margin-left:50px; font-size: 1.5rem; display: inline;">나의 질문</p>
				
			</div>
			<table class="table" style="width: 800px; margin: 0 auto;">
				<tr>
					<td align="center" width="60">번호</td>
					<td width="500">제목</td>
					<td align="center">날짜</td>
					<td align="center">답변 유무</td>
				</tr>
				
				
			<%if( myQList.size() < 5) { 
				for(QnaBoardDto q : myQList){
					//답변여부 확인
				    QnaAnswerDao adao=new QnaAnswerDao();
				    QnaAnswerDto adto=adao.getAnswer(q.getNum());
					%>
				<tr>
					<td align="center"><%=q.getNum() %></td>
					<td><a style="color:black;"href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>"><%=q.getTitle() %></a></td>
					<td><%=sdf.format(q.getWriteday())%></td>
			
				<% if(adto.getIdx()==null){%>
				    <td align="center">대기중</td>
			    <%}else{%>
			    	<td align="center">답변완료</td>
			    <%}%>
				</tr>
				
					
				<%}%>
			<%} else { %>
				
				<%for(int i = 0 ; i < 5; i ++) { 
					//답변여부 확인
				    QnaAnswerDao adao=new QnaAnswerDao();
				    QnaAnswerDto adto=adao.getAnswer(myQList.get(i).getNum());
				%>
				<tr>
					<td align="center"><%=myQList.get(i).getNum() %></td>
					<td><a style="color: black;" href="index.jsp?main=qna/detail.jsp?num=<%=myQList.get(i).getNum()%>"><%=myQList.get(i).getTitle() %></a></td>
					<td><%=sdf.format(myQList.get(i).getWriteday()) %></td>
			
				<% if(adto.getIdx()==null){%>
				    <td align="center">대기중</td>
			    <%}else{%>
			    	<td align="center">답변완료</td>
			    <%}%>
				</tr>
				
				<%}
				}%>
				
				<tr>
					<td colspan="4" align="right">
						<button type="button"
						class="btn btn-light btn-sm"
						onclick="location.href='index.jsp?main=mypage/myQuestionList.jsp'">더보기</button>
					</td>
				
				</tr>
				
			</table>
			
		</div>
	</div>
</div>
</body>
</html>