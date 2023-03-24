<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-13.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style>
		.rectangle {
			
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
		
		.a-tag {
			color: black;
		}
		
		.a-tag:hover{
			color: black;
		}
	</style>
</head>
<body>
<%
	MemberDao mdao = new MemberDao();
	List<MemberDto> userList = mdao.getAllUserList();
	
	//Qna
	QnaBoardDao qnaDao = new QnaBoardDao();
	List<QnaBoardDto> qnaList = qnaDao.getAnswerPendingQList();
			
			
%>
	<div class="container" style="display: flex; justify-content: center;">
		<div class="" style="width: 1000px; display: flex; flex-direction: column;">	
			<span> | 관리자 페이지 | </span><br>
			
			<div style="flex-direction: row; display: flex;">
				<div class="rectangle" style="padding:10px 20px;">
					<div style="margin-bottom: 20px;">
						<span>유저 관리</span>
						<button class="moreBtn btn btn-sm btn-light"
								style="float:right;"
								onclick="location.href='index.jsp?main=mypage/admin/manageUserList.jsp'">더 보기</button>
					</div>
					
					<div>
						<table class="table">
							<tr>
								<td width="20">번호</td>
								<td width="50">닉네임</td>
								<td width="50">아이디</td>
								<td width="30">주소</td>
							</tr>
					<%if(userList.size() == 0) { %>
						<tr>
							<td colspan="4" align="center">
								<h3>등록된 유저가 없습니다.</h3>
							</td>
						</tr>
						
					<%} else if(userList.size() < 8) {%>
						<%for(MemberDto m : userList) {%>
							<tr><%=m.getNum() %></tr>
							<tr><%=m.getNickname() %></tr>
							<tr><%=m.getId() %></tr>
							<tr><%=m.getAddr() %></tr>
						<%}%>
					<%} else {%>
							
						<%for(int i = 0 ; i < 8 ; i++) {%>
							<tr>
								<td><%=userList.get(i).getNum() %></td>
								<td><%=userList.get(i).getNickname() %></td>
								<td><%=userList.get(i).getId() %></td>
								<td><%=userList.get(i).getAddr() %></td>
							</tr>
						<%}%>
					<%}%>
						</table>
					</div>
				</div>
				
				<div class="rectangle" style="padding:10px 20px;">
					<div style="margin-bottom: 20px;">
						<span>답변을 기다리는 질문</span>
						<button class="moreBtn btn btn-sm btn-light" 
								style="float:right;"
								onclick="location.href='index.jsp?main=mypage/admin/showWaitingQuestion.jsp'">더 보기</button>
					</div>
					<div>
						<table class="table">
							<tr>
								<td width="50">번호</td>
								<td width="100">작성자</td>
								<td>제목</td>
							</tr>
						<%if(qnaList.size() == 0) { %>
							<tr>
								<td colspan="3" align="center">
									<h3>등록된 질문글이 없습니다.</h3>
								</td>
							</tr>
						
						<%} else if(qnaList.size() < 8) { %>
							<%for(QnaBoardDto q : qnaList) {
							//닉네임설정
							String nickname = mdao.getNickname(q.getId());%>
							<tr>
								<td><%=q.getNum() %></td>
								<td><%=nickname %></td>
								<td style='width:350px;overflow:hidden;text-overflow:ellipsis;'><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=q.getNum()%>"><%=q.getTitle() %></a></td>
							</tr>
							<%}%>
						<%} else {%>
							<%for(int i = 0 ; i < 8 ; i ++) { %>
							<tr>
								<td><%=qnaList.get(i).getNum() %></td>
								<td><%=qnaList.get(i).getNum() %></td>
								<td style='width:350px;overflow:hidden;text-overflow:ellipsis;'><a class="a-tag" href="index.jsp?main=qna/detail.jsp?num=<%=qnaList.get(i).getNum()%>"><%=qnaList.get(i).getNum() %></a></td>
							</tr>
							<%}%>
						<%}%>
							
						
						</table>
					</div>
				</div>
			</div>
			
			<!-- <div style="flex-direction: row; display: flex;">
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>??????</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
				
				<div class="rectangle">
					<div style="flex-direction: row; display: flex;">
						<p>방문자 현황</p>
						<button class="moreBtn btn btn-xs btn-warning">더 보기</button>
					</div>
					<div></div>
				</div>
			</div>
			 -->
		</div>
	</div>
</body>
</html>