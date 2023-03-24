<%@page import="member.MemberDto"%>
<%@page import="javax.script.ScriptContext"%>
<%@page import="member.MemberDao"%>
<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@page import="board.dogFriend.DogFriendBoardDto"%>
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
<link rel="stylesheet" href="css/page.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>Insert title here</title>

<style type="text/css">
.sublink{
color:black;
}

.sublink:hover{
color:black;
text-decoration:none;
}
a#MOVE_TOP_BTN {
    position: fixed;
    right: 10%;
    bottom: 50px;
    z-index: 999;
    color: black;
}

td:not(.table-title), tr{
	text-align: center;
}
</style>
    <script type="text/javascript">
   
    $(function(){
    	$("#togglecheckbutton").click(function(){
    		   var element = $("#togglecheck");
    		    var visibility = element.css("visibility");
    		    if (visibility === "visible") {
    		        element.css("visibility", "hidden");
    		    } else {
    		        element.css("visibility", "visible");
    		    }
    	})
        
        $("#MOVE_TOP_BTN").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
    	
    	//전체체크클릭시 체크값 얻어서 모든 체크값에 전달
    	$(".alldelcheck").click(function(){
    		var chk=$(this).is(":checked");
    		//console.log(chk);
    		//전체 체크값을 글 앞의 체크에 일괄 전달
    		$(".alldel").prop("checked",chk);
    	})
    	
    	//삭제버튼 클릭시 삭제
    	$("#btndel").click(function(){
    		//체크된 길이
    		var len=$(".alldel:checked").length;
    		//alert(len);
    		if(len==0){
    			alert("최소 한 개 이상의 글을 선택해주세요.");
    		}else{
    			var a=confirm(len+"개의 글을 삭제하려면 [확인]을 눌러주세요.");
    			
    			//체크된 곳의 value값..아까 넣어둔 num 얻기
    			var n="";
    			$(".alldel:checked").each(function(idx){
    				n+=$(this).val()+",";
    			})
    			
    			//마지막 컴마 값 삭제
    			n=n.substring(0,n.length-1);
    			//alert(n);
    			
    			//삭제파일로 전송
    			location.href="dog-friend/alldelete.jsp?nums="+n;
    		}
    		
    		$(document).ready(function () {

    				// 2. 버튼 클릭하면 원하는 위치로 이동
    				$('.go-top').click(function (event) {
    					event.preventDefault();
    					$('html, body').animate({ scrollTop: 0 }, 300);
    				});

    			});
    		
    	})
    	const checkboxes = document.querySelectorAll('input[name="category"]');
    	const posts = document.querySelectorAll('.post');

    	function filterPosts() {
    	  const checkedCategories = Array.from(checkboxes)
    	    .filter(checkbox => checkbox.checked)
    	    .map(checkbox => checkbox.value);
    	  posts.forEach(post => {
    	    if (checkedCategories.length === 0 || checkedCategories.includes(post.classList[1])) {
    	      post.style.display = '';
    	    } else {
    	      post.style.display = 'none';
    	    }
    	  });
    	}

    	checkboxes.forEach(checkbox => checkbox.addEventListener('change', filterPosts));
    })
	

    </script>
</head>
<body>

   <%
    DogFriendBoardDao dao=new DogFriendBoardDao();
   
   int totalCount;
   int totalPage;//총페이지수
   int startPage;//각블럭의 시작페이지
   int endPage;//각블럭의 끝페이지
   int start; //각페이지의 시작번호
   int perPage=100; //한페이지에 보여질 글의 갯수
   int perBlock=100; //한블럭당 보여지는 페이지개수
   int currentPage; //현재페이지
   int no;
   
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
   List<DogFriendBoardDto> list=dao.getList(start, perPage);
   
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   no=totalCount-(currentPage-1)*perPage;
   
   String isAdmin = (String) session.getAttribute("isAdmin");
   MemberDao mdao=new MemberDao();
   String myid=(String)session.getAttribute("myid");
   MemberDto mdto=mdao.getMemeber(myid);
	
   
   %>
	
	
   <div style=" margin: 20px 200px 20px 200px; width: 800px;" id="abc" >
     <span> | 같이 걸어요 | </span><br>
     <b>총 <%=totalCount %>개의 글이 있습니다</b>
     <button id="togglecheckbutton" class="btn btn-default btn-sm">지역 보기</button>
    <form id="togglecheck" style="visibility: hidden">
      <input type="checkbox" id="checkbox1" name="category" value="강원">
      <label for="checkbox1">강원</label>
      <input type="checkbox" id="checkbox2" name="category" value="경기">
      <label for="checkbox2">경기</label>
      <input type="checkbox" id="checkbox3" name="category" value="경남">
      <label for="checkbox3">경남</label>
      <input type="checkbox" id="checkbox4" name="category" value="경북">
      <label for="checkbox4">경북</label>
      <input type="checkbox" id="checkbox5" name="category" value="광주">
      <label for="checkbox5">광주</label>
      <input type="checkbox" id="checkbox6" name="category" value="대구">
      <label for="checkbox6">대구</label>
      <input type="checkbox" id="checkbox7" name="category" value="대전">
      <label for="checkbox7">대전</label>
      <input type="checkbox" id="checkbox8" name="category" value="부산">
      <label for="checkbox8">부산</label>
      <input type="checkbox" id="checkbox9" name="category" value="서울">
      <label for="checkbox9">서울</label><br>
      <input type="checkbox" id="checkbox10" name="category" value="세종">
      <label for="checkbox10">세종</label>
      <input type="checkbox" id="checkbox11" name="category" value="울산">
      <label for="checkbox11">울산</label>
      <input type="checkbox" id="checkbox12" name="category" value="인천">
      <label for="checkbox12">인천</label>
      <input type="checkbox" id="checkbox13" name="category" value="전남">
      <label for="checkbox13">전남</label>
      <input type="checkbox" id="checkbox14" name="category" value="전북">
      <label for="checkbox14">전북</label>
      <input type="checkbox" id="checkbox15" name="category" value="제주">
      <label for="checkbox15">제주</label>
      <input type="checkbox" id="checkbox16" name="category" value="충남">
      <label for="checkbox16">충남</label>
      <input type="checkbox" id="checkbox17" name="category" value="충북">
      <label for="checkbox17">충북</label>
      
    </form>
    
   <table style="width: 800px; table-layout: fixed;" class="table" id="sort" >
   <tr>
   	<td width="100" style="text-align: left">번호</td>
   	<td width="100">지역</td>
   	<td width="200">제목</td>
   	<td width="100">작성자</td>
   	<td width="200">작성일</td>
   	<td width="100">조회수</td>
   </tr>

		<%
		if(totalCount==0){
			%>
			<tr>
				<td colspan="5" align="center">
					<h3>등록된 게시글이 없습니다.</h3>
				</td>
			</tr>
			<%
		}else{
			for(DogFriendBoardDto dto:list){
				  String board_num=dto.getNum();
				  MemberDto memDto=mdao.getMemeber(dto.getId());
				  
				%>
				
				
				<tr id="posts" class="post <%=memDto.getAddr()%>" style="width:800px;">
					<td align="center" width="100" style="text-align: left">
						<input type="checkbox" class="alldel" value="<%=dto.getNum()%>">
						&nbsp;&nbsp;
						<%=no-- %>
					</td>
					<td width="100">
						<%-- 테이블에서 가져온 id로 dto넣기 --%>
						<%=memDto.getAddr()%>
					</td>
					
					<td class="table-title" width="100" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; text-align: left">
						<a class="sublink" href="index.jsp?main=dog-friend/detail.jsp?num=<%=dto.getNum() %>&currentPage=<%=currentPage%>">
						<%=dto.getSubject() %></a>

					</td>
					
					<td width="100" style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;"><%=mdao.getNickname(dto.getId()) %></td>
					<td width="200"><%=sdf.format(dto.getWriteday()) %></td>
					<td width="100"><%=dto.getReadCount() %></td>
					
				</tr>
				<%
			}
		}
		%>
		
     <%
     
     //로그인 한 유저만 글쓰기 버튼 및 관리자만 삭제 가능하게 설정    
     String loginok=(String)session.getAttribute("loginok");
     if(loginok!=null && isAdmin.equals("1")){%>
	 <tr>
		<td colspan="6">
 		<input type="checkbox" class="alldelcheck">전체선택
			<button type="button" class="btn btn-default btn-sm" style="float:right"
			id="btndel"><span class="glyphicon glyphicon-trash"></span>삭제</button>
		<button type="button" class="btn btn-default btn-sm" style="float:right"
		onclick="location.href='index.jsp?main=dog-friend/write.jsp'"><span class="glyphicon glyphicon-pencil" ></span>글쓰기</button>
			
		</td>
	</tr>
 		<%} else if (loginok!=null){%>
     	<tr>
			<td colspan="6">
					<button type="button" class="btn btn-default btn-sm" style="float:right"
					onclick="location.href='index.jsp?main=dog-friend/write.jsp'"><span class="glyphicon glyphicon-pencil" ></span>글쓰기</button>
	
	
			</td>
		</tr>
     <%}else if(loginok==null){%>
  			<tr>
  				<td colspan="6">
    	 		<div style="float:left"><input type="checkbox" class="alldelcheck"> 전체선택</div>
					<button type="button" class="btn btn-default btn-sm" style="float:right"
					onclick="alert('로그인 후 이용해주세요')"><span class="glyphicon glyphicon-pencil" ></span>글쓰기</button>
				</td>
			</tr>
     <%}%>
     
   </table>
   </div>
   <div>
   <a id="MOVE_TOP_BTN"  href="#">TOP</a>
   </div>
</body>
</html>