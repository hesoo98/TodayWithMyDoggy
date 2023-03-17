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
         <h2>공지사항 글쓰기 폼</h2>
         <br>
         <form method="post" action="notification/notificationaddaction.jsp">
            <div class="subject">
               <div>제목</div>
               <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
            </div>        
            <br>
            <div class="content">
               <div>내용</div>
               <textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
            </div>
            <button type="submit" class="btn btn-sm btn-primary" id="btnSave">저장</button>
         </form>
      </div>
   </article>
</body>
</html>