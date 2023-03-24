<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.notification.NotificationDto"%>
<%@page import="java.util.List"%>
<%@page import="board.notification.NotificationDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>공지사항 리스트</title>
	<link rel="stylesheet" href="css/page.css">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style>
		.container {
			margin-top: 50px;
		}
		.writeBtn {
			float:right;
			margin-bottom: 20px;
		}
		
		td:not(.table-title), tr{
			text-align: center;
		}
		
		.table-title{
			text-align: left;
			text-overflow: ellipsis;  /* 말줄임 적용 */
			width: 280px;
			white-space: nowrap;
			overflow: hidden;
		}
	
		
	</style>
</head>
<body>
<%
	//로그인 상태인지?
	String loginok = (String)session.getAttribute("loginok");
	// 관리자 계정인지?
	String isAdmin = (String)session.getAttribute("isAdmin");
	
	NotificationDao ndao = new NotificationDao();
	NotificationDto ndto = new NotificationDto();

	int totalCount;		// 총개수
	int totalPage;		// 총페이지수
	int startPage;		// 각블럭의 시작페이지
	int endPage;		// 각블럭의 끝페이지
	int start; 			// 각페이지의 시작번호
	int perPage=10; 	// 한페이지에 보여질 글의 갯수
	int perBlock=5; 	// 한블럭당 보여지는 페이지개수
	int currentPage; 	// 현재페이지

	// 총개수
	totalCount = ndao.getTotalCount();
	
	// 현재페이지번호 읽기(단 null 일때는 1페이지로 설정)
	if(request.getParameter("currentPage") == null){
		currentPage=1;
	}
	else {
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//총 페이지 갯수
	totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

	//각블럭의 시작페이지..현재페이지가 3(s:1,e:5) 6(s:6 e:10)
	startPage = (currentPage - 1) / perBlock * perBlock + 1;
	endPage = startPage + perBlock - 1;

	//총페이지가 8. (6~10...endpage를 8로 수정해주어야 한다)
	if(endPage > totalPage){
		endPage = totalPage;
	}
	//각페이지에서 불러올 시작번호
	start = (currentPage - 1) * perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<NotificationDto> list = ndao.selectPageingNotification(start, perPage);
%>

	<div class="container">
		<div>
			<div class="btnWrapper float-end">
			 <%
			 // 로그인이 되어있고, 관리자면 글쓰기 버튼 보이게.
			 if(loginok != null && isAdmin.equals("1")) {%>
			 	<span> | 공지사항 | </span>
				<button type="button" class="btn btn-light writeBtn btn-sm" onclick="location.href='index.jsp?main=notification/notificationform.jsp'">글쓰기</button>
			<%}%>
			</div>
	      	<div class="tableWrapper">
				<table class="table">
					<%
					SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
					NotificationDao dao = new NotificationDao();
					%>
					
					<tr>
						<td width="80">번호</td>
						<td width="300">제목</td>
						<td width="150">작성일</td>
					</tr>
					<%
					for(NotificationDto dto: list){
						%>
					<tr>
						<td><%=dto.getNum() %></td>
						<td class="table-title">
						<a style="color: black;" href="index.jsp?main=notification/notificationdetail.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %></a>
						</td>
						<td style="width: 200px;"><%=sdf.format(dto.getWriteday()) %></td>
					</tr>
					<%}%>
				</table>
			</div>
		</div>
		
		
		<!-- 페이징 출력 -->
		<div style="display: flex; justify-content: center;">
			<ul class="pagination p1">
				<%if (startPage > 1) {%>
				<li>
					<a href="index.jsp?main=notification/notificationlist.jsp?currentPage=<%=startPage - 1%>">이전</a>
				</li>
				<%}
				
				for (int pp = startPage; pp <= endPage; pp++) {
					if (pp == currentPage) {%>
					<li class="active">
						<a href="index.jsp?main=notification/notificationlist.jsp?currentPage=<%=pp%>"><%=pp%></a>
					</li>
				<%} else {%>
					<li>
						<a href="index.jsp?main=notification/notificationlist.jsp?currentPage=<%=pp%>"><%=pp%></a>
					</li>
				<%}
				}
				if (endPage < totalPage) {%>
					<li>
						<a href="index.jsp?main=notification/notificationlist.jsp?currentPage=<%=endPage + 1%>">다음</a>
					</li>
				<%}%>
			</ul>
		</div>
    </div>
</body>
</html>