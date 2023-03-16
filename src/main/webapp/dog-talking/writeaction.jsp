<%@page import="member.MemberDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%

request.setCharacterEncoding("utf-8");

//file upload, 이미지가 업로드되는 실제경로
String realPath=getServletContext().getRealPath("/dog-talking-photo");
System.out.print(realPath);

int uploadSize=1024*1024*2; //2mb
MultipartRequest multi=null;

try{
	multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
	
	//session의 id를 저장
	String id=(String)session.getAttribute("myid");
	
	//multi 변수로 모든 폼데이터 읽어오기
	String photoname=multi.getFilesystemName("photo"); //실제업로드된 파일명
	String content=multi.getParameter("content");
	
	//dto에 저장
	DogTalkingBoardDto dto=new DogTalkingBoardDto();
	dto.setId(id);
	dto.setPhoto(photoname);
	dto.setContent(content);
	
	//insert
	DogTalkingBoardDao dao=new DogTalkingBoardDao();
	dao.insertBoard(dto);

	response.sendRedirect("../index.jsp?main=dog-talking/board.jsp");
} catch (Exception e){
	System.out.print("업로드 오류:"+e.getMessage());
}

%>