<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    
    <%
    request.setCharacterEncoding("utf-8");
    
    //세션에 저장한 id 
  	String id=(String)session.getAttribute("myId");
  	
  	//file upload, 이미지가 업로드되는 실제경로
  	String realPath=getServletContext().getRealPath("/dog-talking-photo");
  	System.out.print(realPath);
  	
  	int uploadSize=1024*1024*2; //2mb
  	MultipartRequest multi=null;
  	
  	try{
  		multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
  		
  		//multi 변수로 모든 폼데이터 읽어오기
  		String num=multi.getParameter("num");
  		String content=multi.getParameter("content");
  		String photoname=multi.getFilesystemName("photo");
  		String currentPage=multi.getParameter("currentPage");
  		
  		//사진 수정 안하면 이전의 값 유지하기
  		DogTalkingBoardDao dao=new DogTalkingBoardDao();
  		//기존의 포토명 가져오기
  		String gu_photoname=dao.getData(num).getPhoto();
		
  		
  		//dto에 저장
  		DogTalkingBoardDto dto=new DogTalkingBoardDto();
  		dto.setNum(num);
  		dto.setContent(content);
  		dto.setPhoto(photoname==null?gu_photoname:photoname); //현재 사진 없으면 이전 사진 넣기
  		//update
  		dao.updateBoard(dto);
  		
  		response.sendRedirect("../index.jsp?main=dog-talking/detail.jsp?num="+num+"&currentPage="+currentPage);
  	} catch (Exception e){
  		System.out.print("업로드 오류:"+e.getMessage());
  	}
  	
    %>
    
    