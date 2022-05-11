<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String upDir= "pds_upload"; //업로드할 폴더
	//업로드할 폴더의 절대경로 구하기
	String saveDir = application.getRealPath(upDir);
	System.out.println("saveDir="+saveDir);
	
	saveDir=config.getServletContext().getRealPath(upDir);
	System.out.println("saveDir="+saveDir);
	
	saveDir="C:\\Users\\EZEN\\git\\acadamy\\herbmall\\src\\main\\webapp\\pds_upload";
	
	int maxSize = 2 * 1024 * 1024;
	String encoding="utf-8";
	
	//업로드시 동일한 파일명이 있을경우 나중에 업로드한 파일에 번호를 붙여 이름 변경
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	try{
		MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize, encoding, policy);
		out.print("업로드 완료!");
		
		//업로드된 파일의 정보 읽어오기
		Enumeration enFileNames= mr.getFileNames();
		//=>여러개 파일을 업로드하는 경우 파일이름 목록을 리턴
				
		while(enFileNames.hasMoreElements()){
			String fName=(String)enFileNames.nextElement();
			//=> upfile1, upfile2, upfile3
					
			String fileName=mr.getFilesystemName(fName);
			//=> 업로드된 파일의 이름(변경된 파일 이름)
					
			String originFileName=mr.getOriginalFileName(fName);
			//=> 변경 전 원래 파일 이름
					
			File f = mr.getFile(fName);
			long fileSize=0;
			if(f != null){
				fileSize=f.length();
			}
			
			out.print("업로드된 파일명:"+fileName+"<br>");
			out.print("원래 파일명:"+originFileName+"<br>");
			out.print("파일크기:"+fileSize+"<br>");
		}
			//사용자가 입력한 요청 파라미터 읽어오기
			String id=mr.getParameter("id");
			String addr=mr.getParameter("address");
			out.print("<h1>파라미터</h1>");
			out.print("id:"+id+"<br>");
			out.print("address:"+addr+"<br>");
	}catch(IOException e){
		out.print("2M이상의 파일은 업로드할 수 없습니다.");
		e.printStackTrace();
	}

%>
</body>
</html>