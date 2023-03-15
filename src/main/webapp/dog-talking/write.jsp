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
         <h2>산책 친구 게시판</h2>
         <br>
         <form method="post" action="dog-talking/writeaction.jsp" enctype="multipart/form-data">
            <div class="subject">
               <div>제목</div>
               <input type="text" class="form-control" name="subject" id="subject" placeholder="제목을 입력해 주세요">
            </div>
            <br>
            
            <div class="photo">
               <div>사진</div>
               <input type="file" multiple="multiple" name="photo" id="photo">
            </div>
            
            <br>         
            <div class="content">
               <div>내용</div>
               <textarea class="form-control" rows="10" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
            </div>
            
         <div>
            <br><br>
            <button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>
            <button type="button" onclick="location.href='index.jsp?main=dog-talking/board.jsp'" class="btn btn-sm btn-primary" id="btnList">목록</button>
         </div>
            
         </form>
      </div>
   </article>
</body>
</html>