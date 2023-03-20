<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style>
		.rectangle {
			border:1px solid brown;
			width:500px;
			height: 500px;
		}
		
		.moreBtn {
			margin-right:10px;
			margin-left: auto;
		}
		table {
		table-layout:fixed;
			text-overflow: ellipsis;
			max-width: 500px;
			white-space: nowrap;
		}
	</style>
</head>
<body>
<%
	MemberDao mdao = new MemberDao();
	List<MemberDto> userList = mdao.getAllUserList();
	

%>
	<div class="container" style="border:1px solid black;display: flex; justify-content: center;">
		<div class="" style="width: 1000px; border:1px solid red; display: flex; flex-direction: column;">	
			<p style="font-size: 2rem;">관리자 페이지</p>
			<hr>
			
			<div style="flex-direction: row; display: flex;">
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>유저 관리</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					
					<div>
						<table class="table table-bordered">
							<tr>
								<td width="20">번호</td>
								<td width="50">닉네임</td>
								<td width="50">아이디</td>
								<td width="30">주소</td>

							</tr>
						<%for(int i = 0 ; i < 8 ; i++) {%>
							<tr>
								<td><%=userList.get(i).getNum() %></td>
								<td><%=userList.get(i).getNickname() %></td>
								<td><%=userList.get(i).getId() %></td>
								<td><%=userList.get(i).getAddr() %></td>
							</tr>
						<%}%>
						</table>
					</div>
				</div>
				
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>방문자 현황</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
			</div>
			
			<div style="flex-direction: row; display: flex;">
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>??????</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
				
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>Q&A 현황</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>