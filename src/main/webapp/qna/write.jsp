<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>

	.wrapper{
		margin: 100px 200px;
	}
		
	input:focus {
	    outline: none;
	}
	
	textarea:focus {
	    outline: none;
	}
	

</style>
</head>

<body>
   
   <div class="container wrapper">
   <form action="qna/writeaction.jsp" method="post">
   <table class="table" style="width: 100%;">
   <span>1:1 문의는 기본적으로 공개글로 설정됩니다.</span>
       <tr>
       	<td width="100">제목</td>
       	<td><input type="text" name="title" placeholder="제목을 입력하세요" style="width: 100%;"></td>
       	<td width="100">
       	<select name="secret">
       		<option value="0">공개글</option>
       		<option value="1">비밀글</option>
       	</select>
       	</td>
       </tr>
       
       <tr>
       	<td width="100">내용</td>
       	<td colspan="2">
       	<textarea name="content" placeholder="내용을 입력하세요" style="width: 100%;height: 300px;"></textarea>
       	</td>
       </tr>
       
       <tr>
         <td colspan="3" align="center">
           <button type="submit" class="btn btn-sm border-secondary">문의하기</button>
         </td>
       </tr>
       
   </table>
   </form>
   </div>
   
</body>
</html>