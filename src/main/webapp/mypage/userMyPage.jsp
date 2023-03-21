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
			border:1px solid gray;
			border-radius: 200px;
			width:200px;
			height:200px;
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
	<div class="container" style="border:3px solid #FFCD00; border-radius: 30px; margin-top: 50px;">
		
		<div class="" style="width:800px;margin:0 auto;">
			<p style="font-size:2.5rem; margin-bottom:20px;">마이 페이지</p>
			<p style="font-size:2rem;">나의 프로필</p>
			<div class="row" style="margin-bottom: 50px;" id="myprofile">
				<div class="col-6">
					<p>닉네임</p>
					<p><%=memberDto.getNickname() %></p>
					<p>아이디</p>
					<p><%=memberDto.getId() %></p>
					<p>핸드폰</p>
					<p><%=memberDto.getHp() %></p>
				</div>
				<div class="col">
					<button type="button" class="btn btn-warning btn-lg" style="float:right;" onclick="location.href='index.jsp?main=mypage/userProfileUpdateForm.jsp'">나의 프로필 수정</button>
					<p>주소</p>
					<p><%=memberDto.getAddr() %></p>
					<p>이메일</p>
					<p><%=memberDto.getEmail() %></p>
					<p>생성일</p>
					<p><%=sdf.format(memberDto.getCreateDay()) %></p>
				</div>
			</div>
			
		<%if (isMainDog == 1) {
			DogProfileDto dto = dogDao.getMyMainDog(member_num);%>
			<p style="font-family: ''; font-size:2rem">대표 강아지 프로필</p>
			<div class="row">
				<div class="col-6" style="margin:0 auto;">
					<img class="mx-auto d-block"src="/TodayWithMyDoggy/mypage/dogImg/<%=dto.getPhoto()%>" id="dogprofile">
				</div>
				<div class="col">
					<button type="button" class="btn btn-warning btn-lg" style="float:right;" onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
					<p>강아지이름 : <%=dto.getName() %></p>
					<p>강아지성별 : <%=dto.getGender() %></p>
					<p>강아지크기 : <%=dto.getDogSize() %></p>
					<p>강아지생일 : <%=dto.getBirthday() %></p>
					<p>강아지사진 : <%=dto.getPhoto() %></p>
				</div>
			</div>
						
		<%} else {%>
			<p style="font-family: 'Dovemayo_gothic'; font-size:2.5rem">대표 강아지 프로필</p>
			<div class="row">
				<div class="col-6 rectangle" style="margin:0 auto;">
					<img class="mx-auto d-block"src="" id="dogprofile">
				</div>
				<div class="col rectangle">
					<button type="button" class="btn btn-warning" style="float:right;" onclick="location.href='index.jsp?main=mypage/dogMorePage.jsp'">강아지 더보기</button>
					<b>대표 강아지가 없어요</b>
				</div>
			</div>
		<%}%>

			<div class="" style="height: 400px; margin-top: 50px;">
				<div>
					<p>나의 질문</p>
					<button type="button" class="btn btn-warning float-right" onclick="location.href='index.jsp?main=mypage/myQuestionList.jsp'">더보기</button>
				</div>
				<table class="table table-hover">
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>날짜</td>
						<td>답변 유무</td>
					</tr>
					
					
				<%if( myQList.size() < 5) { 
					for(QnaBoardDto q : myQList){
						//답변여부 확인
					    QnaAnswerDao adao=new QnaAnswerDao();
					    QnaAnswerDto adto=adao.getAnswer(q.getNum());
						%>
					<tr>
						<td><%=q.getNum() %></td>
						<td><a href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>"><%=q.getTitle() %></a></td>
						<td><%=q.getWriteday() %></td>
				
					<% if(adto.getIdx()==null){%>
					    <td>대기중</td>
				    <%}else{%>
				    	<td>답변완료</td>
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
						<td><%=myQList.get(i).getNum() %></td>
						<td><a href="index.jsp?main=qna/detail.jsp?num=<%=myQList.get(i).getNum()%>"><%=myQList.get(i).getTitle() %></a></td>
						<td><%=myQList.get(i).getWriteday() %></td>
				
					<% if(adto.getIdx()==null){%>
					    <td>대기중</td>
				    <%}else{%>
				    	<td>답변완료</td>
				    <%}%>
					</tr>
					
					<%}
					}%>
				</table>
				
			</div>
			<div class="row" style="height: 300px; margin-top: 50px; margin-bottom: 100px;">
				<div class="col rectangle">나의 좋아요</div>
			</div>
		</div>
	</div>
</body>
</html>