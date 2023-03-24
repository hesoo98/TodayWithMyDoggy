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
<link rel="stylesheet" href="css/page.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript" src="js/layout.js"></script>
<link rel="stylesheet" href="css/ut/css.css">
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

<style>


</style>

</head>
<body>

	<%

	//프로젝트 경로구하기
	String root=request.getContextPath();

    DogTalkingBoardDao dao=new DogTalkingBoardDao();
	DogTalkingBoardDto ddto=new DogTalkingBoardDto();
	
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
	String word=request.getParameter("word");
	List<DogTalkingBoardDto> list=dao.getList(start, perPage);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	%>
	
	<!-- 인기글보기 -->
	<%-- <jsp:include page="../dog-talking/board-rank.jsp"/> --%>
	

	<div class="album py-5 bg-light">
	 
		<div class="container">
		
		<div class="wrapper-top">
		 <%
		 
		 //로그인 한 유저만 글쓰기 버튼	  
		 String loginok=(String)session.getAttribute("loginok");
		 
		 if (loginok!=null){%>
		  <button type="button" class="btn btn-default border border-secondary" data-toggle="modal" data-target="#exampleModal">글쓰기</button>
		 <%}
		 %>
		 
		<!-- Modal -->
		<div class="modal fade" id="exampleModal">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <span class="modal-title" id="exampleModalLabel">사진을 첨부하셔야 입력이 가능합니다.</span>
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
	        <img id="showimg" alt="사진을 넣어주세요" style="max-width: 200px; max-height:200px;">
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
		    <div>
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
	
		 
		 <!-- 검색 -->
		 <form action="<%=root %>/board.jsp" method="get" id="search-bar">
			<div
				class="p-1 bg-light rounded rounded-pill shadow-sm ml-5 mg-5 pr-4"
				style="padding-right: 150px; margin-left: 30px;">
				<div class="input-group">
					<div class="input-group-prepend">
						<button id="button-addon2" type="submit"
							class="btn btn-link text-warning">
							<i class="fa fa-search"></i>
						</button>
					</div>
					<input type="search" placeholder="내용으로 검색해보세요!"
						 name="word" 
						class="border-0 bg-light" style="width: 230px;">
					<%
					if(word!=null){%>
					<button type="button" onclick="history.back()">전체글보기</button>
					<%}
					%>
				</div>
			</div>
		 </form>
		 </div>
		 <br>
		 
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-md-4 g-4 main">

				<%
				for (DogTalkingBoardDto dto : list) {
				%>
				<div class="col">
					<div class="card border-light mb-10" width="100%" style="border-radius: 10%;"
					onclick="location.href='<%=root%>/index.jsp?main=dog-talking/detail.jsp?num=<%=dto.getNum() %>&currentPage=<%=currentPage%>'">
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
								<img src="/TodayWithMyDoggy/mypage/dogImg/<%=pdto.getPhoto() %>" alt="" width="30" height="30" style="border-radius: 20px;">
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
				<%
				}
				%>
				</div>
				
			</div>
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

	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous"></script>
		<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	
</body>
</html>