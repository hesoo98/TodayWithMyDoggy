<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@page import="member.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		
		tr td {
			cursor: pointer;
		}
		
		.a-tag {
			color:black;
		}
		.a-tag:hover {
		color: black;
		}
		
		/* 페이지 */
		.pagination{
		  padding: 30px 0;
		}
		
		.pagination ul{
		  margin: 0;
		  padding: 0;
		  list-style-type: none;
		}
		
		.pagination a{
		  display: inline-block;
		  padding: 10px 18px;
		  color: #222;
		}
		
		.p1 a{
		  width: 40px;
		  height: 40px;
		  line-height: 40px;
		  padding: 0;
		  text-align: center;
		}
		
		.p1 li.active{
		   background-color: #fce694;
		   border-radius: 100%;
		   color: #fff;
		}
		
		
	</style>
</head>
<body>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//로그인한 사용자 아이디 가져옴
	String id = (String)session.getAttribute("myid");
	QnaBoardDao dao = new QnaBoardDao();
	int totalCount;		// 총개수
	int totalPage;		// 총페이지수
	int startPage;		// 각블럭의 시작페이지
	int endPage;		// 각블럭의 끝페이지
	int start; 			// 각페이지의 시작번호
	int perPage=10; 	// 한페이지에 보여질 글의 갯수
	int perBlock=5; 	// 한블럭당 보여지는 페이지개수
	int currentPage; 	// 현재페이지

	// 현재페이지번호 읽기(단 null 일때는 1페이지로 설정)
	if(request.getParameter("currentPage") == null){
		currentPage = 1;
	} else {
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//각블럭의 시작페이지..현재페이지가 3(s:1,e:5) 6(s:6 e:10)
	startPage = (currentPage - 1) / perBlock * perBlock + 1;
	endPage = startPage + perBlock - 1;

	
	//각페이지에서 불러올 시작번호
	start = (currentPage - 1) * perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<QnaBoardDto> userList = dao.getMyBoardList(start, perPage, id);
	// 총개수
	totalCount = userList.size();
	//총 페이지 갯수
	totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
	//총페이지가 8. (6~10...endpage를 8로 수정해주어야 한다)
	if(endPage > totalPage){
		endPage = totalPage;
	}
%>

	<div class="container">
		<div style="margin-top: 50px;">
			<p style="margin-bottom: 30px;"> | 나의 질문 리스트 | </p>
			<div style="width: 800px; display: flex; flex-direction: column;">
				<table class="table">
					<tr>
						<td width="80">번호</td>
						<td>제목</td>
						<td>내용</td>
						<td>작성일</td>
					</tr>
				<%for(QnaBoardDto d : userList) {%>

					<tr onclick="location.href='index.jsp?main=qna/detail.jsp?num=<%=d.getNum()%>'">
						<td align="center"><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=d.getNum()%>"><%=d.getNum() %></a></td>
						<td><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=d.getNum()%>"><%=d.getTitle() %></a></td>
						<td><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=d.getNum()%>"><%=d.getContent() %></a></td>
						<td><%=sdf.format(d.getWriteday())%></td>
					</tr>

				<%}%>
				</table>
			</div>
			<!-- 페이징 출력 -->
			<div style="display: flex; justify-content: center;">
				<ul class="pagination p1">
					<%if (startPage > 1) {%>
					<li>
						<a href="index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=<%=startPage - 1%>">이전</a>
					</li>
					<%}
					
					for (int pp = startPage; pp <= endPage; pp++) {
						if (pp == currentPage) {%>
					<li class="active">
						<a href="index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=<%=pp%>"><%=pp%></a>
					</li>
					<%} else {%>
					<li>
						<a href="index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=<%=pp%>"><%=pp%></a>
					</li>
					<%}
					}
					if (endPage < totalPage) {%>
					<li>
						<a href="index.jsp?main=mypage/admin/manageUserList.jsp?currentPage=<%=endPage + 1%>">다음</a>
					</li>
					<%}%>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>