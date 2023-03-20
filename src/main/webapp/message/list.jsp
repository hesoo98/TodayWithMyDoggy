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
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style>

	.wrapper{
	  margin: 30px 100px;
	}

	
	.is-read{
	  color: gray;
	}


</style>

</head>
<body>
	<%
	
	MessageDao dao=new MessageDao();
	
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
	<table class="table table-hover" style="width: 700px;">
	<span>총 <%=dao.getUnreadCount(id) %>개의 읽지 않은 쪽지가 있습니다.</span>
	  
	  <tr>
	    <td width="50"><input type="checkbox"></td>
	    <td width="50">번호</td>
	    <td width="150">보낸사람</td>
	    <td width="300">내용</td>
	    <td width="200">보낸날짜</td>
	  </tr>
	  
	  <%for(MessageDto dto:list){%>
	  <tr>
	    <td><input type="checkbox"></td>
	    <td><%=dto.getNum() %></td>
	    <td><%=dto.getSender() %></td>
	    <td><%=dto.getContent() %></td>
	    <td><%=dto.getWriteday() %></td>
	    
		<%} %>
		</tr>
		</table>
</body>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</html>