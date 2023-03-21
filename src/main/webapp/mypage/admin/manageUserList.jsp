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
	MemberDao dao = new MemberDao();
	List<MemberDto> userList = dao.getAllUserList();//사용하지않고 리스트들 갯수 구하는 용도임.

	int totalCount;		// 총개수
	int totalPage;		// 총페이지수
	int startPage;		// 각블럭의 시작페이지
	int endPage;		// 각블럭의 끝페이지
	int start; 			// 각페이지의 시작번호
	int perPage=10; 	// 한페이지에 보여질 글의 갯수
	int perBlock=5; 	// 한블럭당 보여지는 페이지개수
	int currentPage; 	// 현재페이지

	// 총개수
	totalCount = userList.size();
	
	// 현재페이지번호 읽기(단 null 일때는 1페이지로 설정)
	if(request.getParameter("currentPage") == null){
		currentPage = 1;
	} else {
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
	List<MemberDto> list = dao.selectPageingUserList(start, perPage);
	
%>

	<div class="container" style="border:1px solid black; display: flex; justify-content: center;">
		<div style="flex-direction: column; margin-top: 50px;">
			<p style="font-size: 2rem;">회원 리스트</p>
			<div class="" style="width: 1100px; border:1px solid red; display: flex; flex-direction: column;">
				<table class="table table-hover">
					<tr>
						<td width="">번호</td>
						<td width="">닉네임</td>
						<td width="">아이디</td>
						<td>전화번호</td>
						<td width="">주소</td>
						<td>이메일</td>
						<td>생성일</td>
						<td width="">계정등급</td>
						<td align="center">기능버튼</td>
	
					</tr>
				<%for(MemberDto d : list) {%>
					<tr>
						<td align="center"><%=d.getNum() %></td>
						<td><%=d.getNickname() %></td>
						<td><%=d.getId() %></td>
						<td><%=d.getHp() %></td>
						<td><%=d.getAddr() %></td>
						<td><%=d.getEmail()%></td>
						<td><%=d.getCreateDay() %></td>
						<%if(d.getAuth() == 1){ %>
						<td align="center">관리자</td>
						<%} else {%>
						<td align="center">유저</td>
						<%} %>
						<%if(d.getAuth() == 1){ %>
						<td align="center">
							<button class="btn btn-sm btn-danger" onclick="location.href='mypage/admin/deleteUser.jsp?num=<%=d.getNum()%>&currentPage=<%=currentPage%>'">삭제</button>
						</td>
						<%} else { %>
						<td align="center">
							<button class="btn btn-sm btn-primary" onclick="location.href='mypage/admin/updateAuth.jsp?num=<%=d.getNum()%>&currentPage=<%=currentPage%>'">관리자</button>
							<button class="btn btn-sm btn-danger" onclick="location.href='mypage/admin/deleteUser.jsp?num=<%=d.getNum()%>&currentPage=<%=currentPage%>'">삭제</button>
						</td>
						<%} %>
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