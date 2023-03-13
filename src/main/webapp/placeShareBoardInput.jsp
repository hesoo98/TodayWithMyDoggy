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

<style>
body {
  padding-top: 70px;
  padding-bottom: 30px;
}

.container {
	width: 800px;
}
</style>
</head>
<body>
	<article>
		<div class="container" role="main">
			<br>
			<form method="post" action="#">
				<div class="subject">
					<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
				</div>
				<br>			
				<div class="content">
					<textarea class="form-control" rows="15" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
				</div>
			</form>
			<div>
				<br><br>
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
		</div>
	</article>
</body>
</html>