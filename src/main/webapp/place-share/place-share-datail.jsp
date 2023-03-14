<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.SmartDto"%>
<%@page import="data.dao.smartDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
div.alist {
	margin-left: 20px;
}
div.alist span.aday {
	font-size: 0.8em;
	color: gray;
}

div.alist #adel, #amod {
	float: right;
	margin-left: 2px;
}
</style>
<script type="text/javascript">
$(function() {
	//처음에 시작시 리스트 호출
	var num = $("#num").val();
	
	list();
	
	$("#btnanswer").click(function() {
	$.ajax({	
		type: "get",
		url: "smartanswer/insertanswer.jsp",
		dataType: "html",
		data: {"num":num, "nickname": $("#nickname").val(), "content":$("#content").val()},
		success: function(res) {
				
			$("#nickname").val(" ");
			$("#content").val(" ");
			
			//댓글 추가 후 댓글 목록 다시 출력
			list();
			}
		});
	});	
	$(document).on("click", ".adel", function() {
		var idx = $("button.adel").attr("idx");
		alert(idx);
		//alert(idx);
		var a = confirm("댓글을 삭제하려면 [확인]을 눌러주세요");
		
		if(a) {
			$.ajax({	
				type: "get",
				url: "smartanswer/deleteanswer.jsp",
				dataType: "html",
				data: {"idx":idx},
				success: function(res) {
					location.reload();
				}
			});
		}
	});
	
	// 수정폼 모달
	$(document).on("click", ".amod", function() {
		idx = $(this).attr("idx");
		//alert(idx);
		
		$.ajax({
			type:"get",
			url:"smartanswer/jsonupdateform.jsp",
			dataType:"json",
			data:{"idx":idx},
			success: function(res) {
				$("#unickname").val(res.nickname);
				$("#ucontent").val(res.content);
			}
		});
		$("#myModal").modal();
	});
	
	
	// 수정
	$(document).on("click", "#btnupdate", function() {
		
		var nickname = $("#unickname").val();
		var content = $("#ucontent").val();
		
		$.ajax({
			type:"get",
			url:"smartanswer/updateanswer.jsp",
			dataType:"json",
			data:{"idx":idx,"nickname":nickname, "content":content},
			success: function(res) {
				
			}
		});
		alert("수정되었습니다");
		location.reload();
	});
	
});

// 사용자 정의 호출
function list() {
	console.log("list num" + $("#num").val());
	
	$.ajax({
		type: "get",
		url: "smartanswer/listanswer.jsp",
		data: {"num":$("#num").val()},
		dataType: "json",
		success: function(res) {
			$("b.acount>span").text(res.length);	
			var s = "";
			$.each(res, function(idx, item) {
				s += "<div style='width: 800px; font-size:12pt'><b>" + item.nickname + "</b> : " + item.content;
				s += "<button type='button' idx='" + item.idx + "' id='adel' class='adel btn btn-danger' style='width: 50px'>삭제</button>";
				s += "<button type='button' idx='" + item.idx + "' id='amod' class='amod btn btn-success' style='width: 50px'>수정</button>";
				s += "<br><span class='aday'>" + item.writeday + "</span>";
				s += "</div><hr>";
				
			});
			
			$("div.alist").html(s);
		},
		statusCode: {
			404: function() {
				alert("json파일을 못잡음");
			},
			
			500: function() {
				alert("서버오류..코드");
			}
		}
	});
}
</script>
</head>
<body>
<%
	smartDao dao = new smartDao();
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	
	//조회수 증가
	dao.updateReadCount(num);
	
	//dto 가져오기
	SmartDto dto = dao.getData(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<div style="margin: 30px 30px;">
	<table class="table table-bordered" style="width: 500px">
		<caption>
			<h3><b><%=dto.getSubject() %></b></h3>
		</caption>
		<tr>
			<td>
			<b>작성자: <%=dto.getWriter() %></b><br>
			<span class="day">
			<%=sdf.format(dto.getWriteday()) %>
			&nbsp;&nbsp;조회 <%=dto.getReadcount() %>
			</span>
			</td>
		</tr>
		<tr>
			<td>
			<%=dto.getContent() %>
			</td>
		</tr>
		
		<!-- 댓글 -->
		<tr>
			<td>
				<b class="acount">댓글 <span>0</span></b>
				<br><br>
				<div class="alist">
					댓글목록
				</div>
				
				<div class="aform form-inline">
				<input type="hidden" id="num" value="<%=num%>">
					<input type="text" id="nickname" class="form-control" style="width: 100px"
					placeholder="닉네임입력">
					<input type="text" id="content" class="form-control" style="width: 100px"
					placeholder="댓글입력">
					<button type="button" id = "btnanswer" class="btn btn-info">저장</button>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<button type="button" class="btn btn-defalut" 
				onclick="location.href='index.jsp?main=board/smartform.jsp'">
				<span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
				
				<button type="button" class="btn btn-defalut" 
				onclick="location.href='index.jsp?main=board/updateform.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>'">
				<span class="glyphicon glyphicon-edit"></span>수정</button>
				
				<button type="button" class="btn btn-defalut" 
				onclick="fundel(<%=num%>, <%=currentPage%>)">
				<span class="glyphicon glyphicon-remove"></span>삭제</button>
				
				<button type="button" class="btn btn-defalut" 
				onclick="location.href='index.jsp?main=board/boardlist.jsp?currentPage=<%=currentPage%>'">
				<span class="glyphicon glyphicon-list"></span>목록</button>
			</td>
		</tr>
	</table>
</div>

<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">댓글수정</h4>
        </div>
        
        <div class="modal-body">
          <b>닉네임: </b>
          <input type="text" id="unickname" style="width: 100px;">
          <br><br>
          <b>댓글내용: </b>
          <input type="text" id="ucontent" style="width: 200px;">
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal"
          id="btnupdate">댓글수정</button>
        </div>
      </div>
    </div>
  </div>

<script type="text/javascript">
	function fundel(num, currentPage) {
		var a = confirm("삭제하려면 [확인]을 눌러주세요");
		
		if(a) {
			location.href = "board/delete.jsp?num="+num+"&currentPage="+currentPage;
		}
	}
</script>
</body>
</html>