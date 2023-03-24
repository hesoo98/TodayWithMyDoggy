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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<title>Insert title here</title>

<style type="text/css">
.sublink {
	color: black;
}

.sublink:hover {
	color: black;
	text-decoration: none;
}

a#MOVE_TOP_BTN {
	position: fixed;
	right: 10%;
	bottom: 50px;
	z-index: 999;
	color: black;
}

td:not(.table-title), tr {
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
    			 
    			   // 1. 특정 위치에서 부터 버튼 나타고, 사라지게..효과는 fade로
    			    $(window).scroll(function () {
    					if ($(this).scrollTop() > 200) {
    						$('.go-top').fadeIn(200);
    					} else {
    						$('.go-top').fadeOut(200);
    					}
    				});

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
	DogFriendBoardDao dao = new DogFriendBoardDao();

	//각페이지에서 필요한 게시글 가져오기
	List<DogFriendBoardDto> list = dao.getBoardList();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	String isAdmin = (String) session.getAttribute("isAdmin");
	MemberDao mdao = new MemberDao();
	String myid = (String) session.getAttribute("myid");
	MemberDto mdto = mdao.getMemeber(myid);
	%>

	<div style="width: 700px;" id="abc">
		<table style="width: 500px; table-layout: fixed;" class="table"
			id="sort">
			<tr>
				<td width="100">지역</td>
				<td width="200">제목</td>
				<td width="100">작성자</td>
			</tr>

			<%
			int i=1;
			for (DogFriendBoardDto dto : list) {
				if(i==8) {
					break;
				}
				String board_num = dto.getNum();
				MemberDto memDto = mdao.getMemeber(dto.getId());
			%>


			<tr id="posts" class="post <%=memDto.getAddr()%>"
				style="width: 800px;">
				<td width="100">
					<%-- 테이블에서 가져온 id로 dto넣기 --%> <%=memDto.getAddr()%>
				</td>

				<td class="table-title" width="100"
					style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
					<a class="sublink"
					href="index.jsp?main=dog-friend/detail.jsp?num=<%=dto.getNum()%>">
						<%=dto.getSubject()%></a>

				</td>

				<td width="100"
					style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"><%=mdao.getNickname(dto.getId())%></td>

			</tr>
			<%
			i++;
			}
			%>
		</table>
	</div>
	<div>
		<a id="MOVE_TOP_BTN" href="#">TOP</a>
	</div>
</body>
</html>