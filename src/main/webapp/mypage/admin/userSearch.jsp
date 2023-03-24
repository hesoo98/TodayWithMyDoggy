<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="css/page.css">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		td {
			word-break:breack-all;
		}
	</style>
</head>
<body>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String searchField = request.getParameter("searchField");
	String searchText = request.getParameter("searchText");
	if(searchText != null) {
		searchText = new String(searchText.getBytes("8859_1"), "UTF-8");
	}

	MemberDao dao = new MemberDao();
	List<MemberDto> userList = dao.getUserSearch(searchField, searchText);

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
	List<MemberDto> list = dao.getUserSearch(start, perPage, searchField, searchText);
	
%>

	<div class="container" style="display: flex; justify-content: center;">
		<div style=" margin-top: 50px; width: 1100px;">
			<span><a style="color: black;"href="index.jsp?main=mypage/admin/manageUserList.jsp"> | 회원 리스트 | </a></span><br>
			
			<!-- 검색 폼 -->
			<form method="post" name="search" action=''>
				<table class="float-right" style="margin-bottom: 30px;">
					<tr>
						<td  style="padding-right: 10px;">
							<select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="id">아이디</option>
								<option value="nickname">닉네임</option>
								<option value="hp">전화번호</option>
								<option value="addr">주소</option>
							</select>
						</td>
						<td style="padding-right: 10px;">
							<input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100">
						</td>
						<td><button type="submit" class="btn btn-light btn-sm">검색</button></td>
					</tr>

				</table>

				<div>
					<table class="table table-hover">
						<tr class="line">
							<td width="60">번호</td>
							<td>닉네임</td>
							<td>아이디</td>
							<td width="150">전화번호</td>
							<td width="60">주소</td>
							<td>이메일</td>
							<td>생성일</td>
							<td width="80">계정등급</td>
							<td align="center">기능버튼</td>
		
						</tr>
					<%for(MemberDto d : list) {%>
						<tr>
							<td align="center"><%=d.getNum() %></td>
							<td><%=d.getNickname() %></td>
							<td><%=d.getId() %></td>
							<td><%=d.getHp() %></td>
							<td><%=d.getAddr() %></td>
							<td style="word-break: break-all"><marquee scrollamount="3"><%=d.getEmail()%></marquee></td>
							<td><%=sdf.format(d.getCreateDay()) %></td>
							<%if(d.getAuth() == 1){ %>
							<td align="center">관리자</td>
							<%} else {%>
							<td align="center">유저</td>
							<%} %>
							<%if(d.getAuth() == 1){ %>
							<td align="center">
								<button class="btn btn-sm btn-light" onclick="funcdel(<%=d.getNum()%>, <%=currentPage%>)">삭제</button>
							</td>
							<%} else { %>
							<td align="center">
								<button class="btn btn-sm btn-light" onclick="location.href='mypage/admin/updateAuth.jsp?num=<%=d.getNum()%>&currentPage=<%=currentPage%>'">관리자</button>
								<button class="btn btn-sm btn-light" onclick="funcdel(<%=d.getNum()%>, <%=currentPage%>)">삭제</button>
							</td>
							<%} %>
						</tr>
					<%}%>
					</table>
				</div>
			</form>
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
	
	<script type="text/javascript">
	function funcdel(num, currentPage){
		var a = confirm("삭제하려면 확인버튼을 눌러주세요.");
		if(a) {
			location.href = "mypage/admin/deleteUser.jsp?num=" + num + "&currentPage=" + currentPage;
		}
	}
</script>
</body>
</html>