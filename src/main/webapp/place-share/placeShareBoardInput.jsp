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
	$(function() {
		$("#card1").attr('src', 'css/imgg.png');
		$("#card2").attr('src', 'css/imgg.png');
		$("#card3").attr('src', 'css/imgg.png');
		
		if($('input[name="photo1"]').is(":checked") == true){
			var fileValue = $("#photo1").val().split("\\");
			var fileName = fileValue[fileValue.length-1]; 
			$("#titlePhoto").val(fileName);
		}
		 
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
	width: 900px;
}

.content>input {
	height: 700px;
}

img {
	width: 00px;
	height: 200px;
	opacity: 0.3;
}

.comm {
	font-size: 13px;
	color: gray;
}

.card {
	border-radius: 10%;
}
</style>
</head>
<body>
	<article>
		<div class="container" role="main">
			<br>
			<form method="post" action="place-share/addAction.jsp" enctype="multipart/form-data">
				<input type="hidden" name="titlePhoto" id="titlePhoto" value="">
				<div class="subject">
					<input type="text" class="form-control" name="subject" id="subject"
						placeholder="제목을 입력해 주세요">
				</div>
				<br>
				<div class="comm">대표 이미지를 선택해주세요</div>
				<br> <br>
				<div class="card-deck">
					<div class="card">

						<img src="" class="card-img-top" id="card1">
						<div class="card-body">
							<p class="card-text">
								<input type="checkbox" class="chk" id="chk1"> <input
									type="file" class="form-control" name="photo1"
									onchange="readURL1(this)">

							</p>
						</div>
					</div>
					<div class="card">
						<img src="" class="card-img-top" id="card2">
						<div class="card-body">
							<p class="card-text">
								<input type="checkbox" class="chk" id="chk2"> <input
									type="file" class="form-control" name="photo2"
									onchange="readURL2(this)">

							</p>
						</div>
					</div>
					<div class="card">
						<img src="" class="card-img-top" id="card3">
						<div class="card-body">
							<p class="card-text">
								<input type="checkbox" class="chk" id="chk3"> <input
									type="file" class="form-control" name="photo3"
									onchange="readURL3(this)">
							</p>
						</div>
					</div>
				</div>
				<br> <br>
				<div class="content">
					<textarea type="text" class="form-control" rows="15" name="content"
						id="content" placeholder="내용을 입력해주세요"></textarea>
				</div>
				<div>
				<br> <br>
				<button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
			</form>
			
		</div>
	</article>
</body>
</html>