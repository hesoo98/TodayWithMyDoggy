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

.content {

}
</style>
</head>
<body>
   <article>
      <div class="container" role="main">
         <h2>qna 리스트 미완</h2>
         <br>
         <form method="post" action="#">
            <div class="subjext">
               <div>제목</div>
               <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
            </div>
            <br>         
            <div class="writer">
               <div>작성자</div>
               <input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="이름을 입력해 주세요">
            </div>
            <br>         
            <div class="content">
               <div>내용</div>
               <textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
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