<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="java.io.IOException"%>
<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write_ok.jsp</title>
</head>
<body>
<%
   //write.jsp에서 post방식으로 서브밋됨
   try{
      String upDir=Utility.UPLOAD_PATH; //업로드할 폴더
      //업로드할 폴더의 절대경로 구하기
      String saveDir=application.getRealPath(upDir);
      System.out.println("saveDir="+saveDir);
      
      saveDir=config.getServletContext().getRealPath(upDir);
      System.out.println("saveDir="+saveDir);
      
      saveDir=Utility.TEST_PATH;
      System.out.println("testDir="+saveDir);
      
      int maxSize=2*1024*1024;  //업로드 최대용량,2M
      String encoding="utf-8";
      
      //업로드시 동일한 파일명이 있을 경우 나중에 업로드한 파일에 번호를 붙여 이름 변경
      DefaultFileRenamePolicy policy=new DefaultFileRenamePolicy();
      
      MultipartRequest mr
         =new MultipartRequest(request, saveDir, maxSize, encoding, policy);
      System.out.println("업로드 완료");
      
      //업로드한 파일 정보
      String fileName=mr.getFilesystemName("upfile");
      long fileSize=0;
      String originFileName="";
      if(fileName!=null && !fileName.isEmpty()){
         File f = mr.getFile("upfile");
         fileSize=f.length();
         
         originFileName=mr.getOriginalFileName("upfile");
      }
      
      //1
      String title=mr.getParameter("title");
      String name=mr.getParameter("name");
      String pwd=mr.getParameter("pwd");
      String email=mr.getParameter("email");
      String content=mr.getParameter("content");
      
      //ip 읽어오기
      String ip=request.getRemoteAddr();
      System.out.println("ip="+ip);
      
      ip=request.getRemoteHost();
      System.out.println("ip="+ip);
      
      //2
      ReBoardDAO dao = new ReBoardDAO();
      ReBoardVO vo = new ReBoardVO();
      vo.setContent(content);
      vo.setEmail(email);
      vo.setName(name);
      vo.setPwd(pwd);
      vo.setTitle(title);
      
      vo.setFileName(fileName);
      vo.setOriginalFileName(originFileName);
      vo.setFileSize(fileSize);
   
      int cnt=dao.insertReBoard(vo);
      
      //3
      if(cnt>0){ %>
         <script type="text/javascript">
            alert("글쓰기 성공");
            location.href="list.jsp";
         </script>
      <%}else{%>
         <script type="text/javascript">
            alert("글쓰기 실패");
            history.back();
         </script>         
      <%}
   }catch(IOException e){
      e.printStackTrace();%>
         <script type="text/javascript">
            alert("2M 이상의 파일은 업로드 불가!");
            history.back();
         </script>         
     
  <% }catch(SQLException e){
      e.printStackTrace();
   }
   
   
%>
</body>
</html>


