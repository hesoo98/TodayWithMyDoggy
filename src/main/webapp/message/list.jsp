<%@page import="member.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="message.MessageDto"%>
<%@page import="java.util.List"%>
<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="css/page.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style>

	.wrapper{
	  margin: 30px 100px;
	  display: flex;
	  justify-content: space-between;
	}

	
	.is-read{
	  color: gray;
	}
	
	.detail{
	  width: 300px;
	  margin-left: 30px;
	}
	
	.content{
	  cursor: pointer;
	}
	
	.span-btn{
	  margin: 0px 2px;
	  cursor: pointer;
	}
	
	.btns-left{
	  float: left;
	}
	
	.btns-right{
	  float: right;
	}
	
	input[type="checkbox"]{
		border:2px solid #F47C7C;
	}
	
	input[type="checkbox"]:checked{
		background-color: red;
	} 
	
	.blue-color{
		background-color:#d9e4f4 ;
	}
	
	.subject{
	text-align: left;
	text-overflow: ellipsis;  /* 말줄임 적용 */
	width: 240px;
	white-space: nowrap;
	overflow: hidden;
}

</style>

</head>
<body>
	<%
	
	MessageDao dao=new MessageDao();
	MemberDao memdao=new MemberDao();
	
	//로그인, 세션아이디 체크 (id=receiver인 메시지만 불러오기)
	String loginok=(String)session.getAttribute("loginok");
	String id=(String)session.getAttribute("myid");

	int totalCount;
	int totalPage;//총페이지수
	int startPage;//각블럭의 시작페이지
	int endPage;//각블럭의 끝페이지
	int start; //각페이지의 시작번호
	int perPage=10; //한페이지에 보여질 글의 갯수
	int perBlock=5; //한블럭당 보여지는 페이지개수
	int currentPage; //현재페이지
	
	//총개수
	totalCount=dao.getMyCount(id);
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

	List<MessageDto> list=dao.showAllMessage(start, perPage, id);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	%>
	
	<div class="container wrapper">
	<div>
	<span>총 <span id="cnt"></span>개의 읽지 않은 쪽지가 있습니다.</span>
	<table class="table" style="width: 600px;">
	  <tr>
	    <td width="50"><input type="checkbox" class="alldelcheck"></td>
	    <td width="150">보낸사람</td>
	    <td width="250">내용</td>
	    <td width="200">보낸날짜</td>
	  </tr>
	  
	  <%for(MessageDto dto:list){%>
	  <tr>
	    <td><input type="checkbox" class="chk-del" value="<%=dto.getNum()%>"></td>
	    <td>
	    <span>
	    <%=dto.getSender() %>(<%=memdao.getNickname(dto.getSender()) %>)</span>
	    </td>
	    
	    <td class="subject">
	    <span class="link-detail">
	    <input type="hidden" name="num" id="num" value="<%=dto.getNum()%>">
	    
	    <% //isread 체크
	    if(dto.getIsRead()==1){ //읽은 글%>
	      <span class="content is-read"><%=dto.getContent() %></span>
	    <%}else{ //안읽은 글%>
	      <span class="content"><%=dto.getContent() %></span>
	    <%}
	    %>
	    </span>
	    </td>
	    
	    <td><%=sdf.format(dto.getWriteday()) %></td>
	    </tr>
	    
	    <!-- 답장 Modal -->
		<div class="modal fade" id="exampleModal">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <h5 class="modal-title" id="exampleModalLabel">답장하기</h5>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
   		  
		<div class="modal-body">
		<form action="message/writemessageaction.jsp" method="post">
		<input type="hidden" name="num" value="<%=dto.getNum()%>">
		<input type="hidden" name="receiver" value="<%=dto.getSender()%>">
		  
		<textarea rows="10" style="width:100%;" name="content" placeholder="답장 내용을 입력하세요"
		required="required"></textarea>
	  
	 	<div class="modal-footer">
	   	<button type="button" class="btn btn-default border border-secondary" data-dismiss="modal">취소</button>
	   	<button type="submit" class="btn btn-default border border-secondary" onclick="alert('답장이 전송되었습니다.')">답장하기</button>
		</div>
    	
	    </form>
   	  	</div>
   		 </div>
  		</div>
		</div>
			
	  <%} %>
	</table>
	<button type="button" id="btn-del" class="btn btn-default">전체삭제</button>
	
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
	
	</div>
	
	<div class="detail"></div>
	
	</div>
	
	<script type="text/javascript">
	
	$(".detail").hide();
	
	$("#cnt").html(<%=dao.getUnreadCount(id)%>);
	
	//디테일페이지 나타나게
	$(".link-detail").click(function(){
		
		var num=$(this).find("#num").val();
		
		$(".detail").show();
		$(this).children().addClass("is-read");

		$.ajax({
			type:"get",
			url:"message/detailajax.jsp",
			dataType:"json",
			data:{"num":num},
			success: function(res){
				
				var s="";
				s+="<div class='btns-left'><span>쪽지 상세</span></div>";
				s+="<div class='btns-right'><span class='span-btn' data-toggle='modal' data-target='#exampleModal'>답장</span>";
				s+="<span class='span-btn' onclick='delMessage("+res.num+")'>삭제</span></div>";
				s+="<table class='table'>";
				s+="<tr><td>보낸사람</td><td>"+res.sender+"</td></tr>";
				s+="<tr><td>내용</td><td>"+res.content+"</td></tr>";
				s+="</table>";
				
				$("#cnt").html(res.cnt);
				$(".detail").html(s);
			}
		})
		
	})
	
	//디테일페이지에서 쪽지 하나 삭제
	function delMessage(n){
		
		var a=confirm("받은 쪽지를 삭제하시겠습니까?");
		var num=n;
		
		if(a){
			//location.href="message/delete.jsp";
			$.ajax({
				type:"get",
				url:"message/delete.jsp",
				data:{"num":num},
				dataType:"html",
				success: function(res){
					alert("정상적으로 삭제되었습니다.");
					location.reload();
				}
			})
		}else{
			return false;
		}
		
	}
	//전체 체크 클릭시 체크값 얻어서 모든 체크값에 전달
	$(".alldelcheck").click(function(){
		var chk=$(this).is(":checked");
		
		//전체체크값을 글 앞의 체크에 일괄 전달
		$(".chk-del").prop("checked",chk);
	})
	
	// 전체삭제
	$("#btn-del").click(function(){
		
		//체크된 길이
		var len=$(".chk-del:checked").length;
		//alert(len);
		
		if(len==0) alert("최소 한 개 이상의 글을 선택해주세요.");
		else {
			var a=confirm(len+"개의 글을 삭제합니다.");

			var n="";
			$(".chk-del:checked").each(function(idx){
				n+=$(this).val()+",";
			})
			
			n=n.substring(0, n.length-1);
			
			//삭제파일로 전송
			location.href="message/deleteall.jsp?nums="+n;
		}
		
	})
	
	
	</script>
	
</body>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</html>