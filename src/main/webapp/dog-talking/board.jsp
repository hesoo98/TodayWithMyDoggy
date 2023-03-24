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
<link rel="stylesheet" href="css/page.css">
<link rel="stylesheet" href="dog-talking/board.css">
<link rel="stylesheet" href="dog-talking/btn.css">

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

.line{
  width: 100% auto;
  margin: 100px 0px;
  height: 1px;
  background-color: #d9e4f4;
}

.pagination{
	padding-bottom: 300px;
}

</style>
<%
//프로젝트 경로구하기
	String root=request.getContextPath();

DogTalkingBoardDao dao=new DogTalkingBoardDao();

int totalCount;
int totalPage;//총페이지수
int startPage;//각블럭의 시작페이지
int endPage;//각블럭의 끝페이지
int start; //각페이지의 시작번호
int perPage=8; //한페이지에 보여질 글의 갯수
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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

</head>
<body>

	<div class="container2">

		<div style="text-align: center; font-size: 22px; opacity: 0.8; letter-spacing:3px; line-height:2;">
		사랑스러운 반려견과의 일상을 공유하고 인기강아지에 도전하세요</div>
		<span>인기강아지는 매주 좋아요 순으로 갱신됩니다</span>
		<br>
		
		 <%
		 
		 //로그인 한 유저만 글쓰기 버튼	  
		 String loginok=(String)session.getAttribute("loginok");
		 
		 if (loginok!=null){%>
		  <a class="button" style="cursor: pointer;" data-toggle="modal" data-target="#exampleModal">
			<div class="button__line"></div>
			<div class="button__line"></div> <span class="button__text" style="letter-spacing:3px;">글쓰러 가기</span>
			<div class="button__drow1"></div>
			<div class="button__drow2"></div>
		 </a>
		 <%}else{%>
			  <a class="button" href="index.jsp?main=login/loginform.jsp">
				<div class="button__line"></div>
				<div class="button__line"></div>
				<span class="button__text" style="letter-spacing:3px;">로그인 후 글을 남겨보세요
				</span>
				<div class="button__drow1"></div>
				<div class="button__drow2"></div>
			 </a>
		 <%}
		 %>
		 
	</div>
	
	<jsp:include page="/dog-talking/board-rank.jsp"/>
	<hr class="line">
	
		<!-- Modal -->
		<div class="modal fade" id="exampleModal">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <span class="modal-title" id="exampleModalLabel">새 글 작성</span>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
    		  
	   <div class="modal-body">
	   <form action="dog-talking/writeaction.jsp" method="post" enctype="multipart/form-data">
		<table class="table">
		  <tr>
	    	<td>
	    	<!-- 이미지 미리보기 -->
	        <img id="showimg" alt="사진 첨부" style="max-width: 200px; max-height:200px;">
	  		<input type="file" name="photo" id="photo" style="visibility: hidden;" onchange="readURL(this)" required> 
		    </td>
		    
		    <td>
		    <div id="content">
		      <textarea name="content" placeholder="내용을 입력하세요" required style="width: 200px; height: 200px;"></textarea>
		    </div>
	   		</td>
	  	</tr>
		<tr>
		  <td>
		    <div style="cursor: pointer;">
		    <span class="camera"><i class="fa-solid fa-camera-retro icon"></i> 사진첨부</span>
		    </div>
		  </td>
		  <td align="center">
		 	<button type="submit" class="btn btn-default border border-secondary" >저장</button>
		  </td>
		</tr>
	  </table>
	  
	</form>
   	  	</div>
   		 </div>
  		</div>
	</div>
	
	
	<script type="text/javascript">
	
   	  $(function(){

      //trigger 이벤트 강제 호출 
      $("span.camera").click(function(){
         $("#photo").trigger("click");
      });
      
      //esc로 모달 닫기
      $(document).keydown(function(e){
    		//keyCode 구 브라우저, which 현재 브라우저
    	    var code = e.keyCode || e.which;
    	 
    	    if (code == 27) { // 27은 ESC 키번호
    	        history.back();
    	    }
    	});
      
   });
   	 
   
    //이미지 미리보기   
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
            reader.onload = function (e) {
            //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $('#showimg').attr('src', e.target.result);
            }                   
            reader.readAsDataURL(input.files[0]);
            //File내용을 읽어 dataURL형식의 문자열로 저장
        }
        
    }
    
    </script>

	<div class="album pb-5 bt-2">
		<div class="container">
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
							onclick="location.href='<%=root%>/index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum() %>&currentPage=<%=currentPage%>'">
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
									&nbsp;<i class="fa-regular fa-comment-dots"></i><%=totalAnswerCnt%>
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
			
	<!-- 페이징 출력 -->
	<div style="display: flex; justify-content: center;">
		<ul class="pagination p1">
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
	<!-- 페이징 끝 -->
	
		</div>
	</div>
		
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js"
	crossorigin="anonymous"></script>
	
</body>
</html>
