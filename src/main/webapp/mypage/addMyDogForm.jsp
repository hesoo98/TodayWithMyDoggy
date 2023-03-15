<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style type="text/css">
		.rectangle {
			float:left;
			border:1px solid black;
			width: 400px;
			height: 300px;
		}
		#dogprofile {
			border:1px solid gray;
			border-radius: 200px;
			width:200px;
			height:200px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			
		});
		
		function readURL(input) {
			if(input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#dogprofile').attr("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		
	</script>
</head>
<body>
	<div class="container main" style="border:1px solid red;">
		<h1>강아지 추가 폼</h1>
	
		<div class="firstLine">
			<form action="mypage/addDogAction.jsp" method="post" enctype="multipart/form-data">
				<div class="rectangle">
					<img src="" id="dogprofile">
					<div>
						<b>강아지 사진 등록</b>
				 		<input type="file" name="photo" id="photo" onchange="readURL(this)">
				 	</div>
				</div>
				<div class="rectangle">
					
					<table class="table">
						<tr>
							<td>
								강아지 이름 : &nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<input type="text" name="name" class="form-control" style="width:200px;" placeholder="강아지 이름 입력" required="required">
							</td>
						</tr>
						<tr>
							<td>성별 : &nbsp;&nbsp;&nbsp;</td>
							<td>
								<input type="radio" name="gender" value="암">암&nbsp;&nbsp;
								<input type="radio" name="gender" value="수">수&nbsp;&nbsp;
								<input type="radio" name="gender" value="중성화">중성화&nbsp;&nbsp;
							</td>
						</tr>
						
						<tr>
							<td>사이즈 : &nbsp;&nbsp;&nbsp;</td>
							<td>
								<input type="radio" name="dog_size" value="소형견">소형견&nbsp;&nbsp;
								<input type="radio" name="dog_size" value="중형견">중형견&nbsp;&nbsp;
								<input type="radio" name="dog_size" value="대형견">대형견&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td>생일 : &nbsp;&nbsp;&nbsp;</td>
							<td>
								<input type="date" name="birthday" value="2023-03-14"min="2000-01-01" max="2030-12-31">
							</td>
						</tr>
					</table>
					<input type="submit" value="저장하기">
				</div>
			</form>
		</div>
	</div>
</body>
</html>