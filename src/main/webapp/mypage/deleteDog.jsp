<%@page import="java.io.File"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String idx = request.getParameter("idx");
	DogProfileDao dao = new DogProfileDao();
	DogProfileDto dto = dao.getDogProfileDto(idx);
	
	//강아지 프로필 이미지도 삭제.
	String photoname = dto.getPhoto();
	String imgPath = getServletContext().getRealPath("/mypage/dogImg");
	
	String deletePhotoName = imgPath + "\\"+ photoname;
	File deleteImg = new File (deletePhotoName);
	
	System.out.println(deletePhotoName);
	
	dao.deleteDog(idx);
	
	//파일삭제
	if (deleteImg.exists() && deleteImg.isFile()){
	    deleteImg.delete();
	}
	
	response.sendRedirect("../index.jsp?main=mypage/dogMorePage.jsp");
%>