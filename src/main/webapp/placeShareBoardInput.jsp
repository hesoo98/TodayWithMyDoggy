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
<script type="text/javascript">
	$(function () {
		$("#card1").attr('src', 'css/imgg.png');
		$("#card2").attr('src', 'css/imgg.png');
		$("#card3").attr('src', 'css/imgg.png');
	});
	function readURL1(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#card1').attr('src', e.target.result);
				$('#card1').css('opacity', 1);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	function readURL2(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#card2').attr('src', e.target.result);
				$('#card2').css('opacity', 1);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	function readURL3(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#card3').attr('src', e.target.result);
				$('#card3').css('opacity', 1);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
<style>
body {
	padding-top: 70px;
	padding-bottom: 30px;
}

.container {
	width: 800px;
}

.content>input {
	height: 500px;
}

img {
	width: 500px;
	height: 200px;
	background-color: white;
	opacity: 0.3;
	}
</style>
</head>
<body>
	<article>
		<div class="container" role="main">
			<br>
			<form method="post" action="#">
				<div class="subject">
					<input type="text" class="form-control" name="title" id="title"
						placeholder="제목을 입력해 주세요">
				</div>
				<br>
				<div class="card-deck">
					<div class="card">
						<img src="" class="card-img-top" id="card1">
						<div class="card-body">
							<p class="card-text"></p>
							<input type="file" class="form-control" name="photo" id="photo"
						onchange="readURL1(this)">
						</div>
					</div>
					<div class="card">
						<img src="" class="card-img-top" id="card2">
						<div class="card-body">
							<p class="card-text"></p>
							<input type="file" class="form-control" name="photo" id="photo"
							onchange="readURL2(this)">
						</div>
					</div>
					<div class="card">
						<img src="" class="card-img-top" id="card3">
						<div class="card-body">
							<p class="card-text"></p>
							<input type="file" class="form-control" name="photo" id="photo"
							onchange="readURL3(this)">
						</div>
					</div>
				</div>
				<br><br>
				<div class="content">
					<textarea type="text" class="form-control" rows="15" name="content" id="content"></textarea>
				</div>

			</form>
			<div>
				<br> <br>
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
		</div>
	</article>
</body>
</html>