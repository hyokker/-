<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>edit_ok.jsp</title>
</head>
<body>
<%
   //edit.jsp에서 post방식으로 서브밋
   //1
   try{
      String upDir=Utility.UPLOAD_PATH; //업로드할 폴더
      //업로드할 폴더의 절대경로 구하기
      String saveDir=application.getRealPath(upDir);
      System.out.println("saveDir="+saveDir);
      
      saveDir=config.getServletContext().getRealPath(upDir);
      System.out.println("saveDir="+saveDir);
      
      saveDir=Utility.TEST_PATH;
      System.out.println("testDir="+saveDir);
      
      int maxSize=2*1024*1024; //업로드 최대용량, 2M
      String encoding="utf-8";
      
      //업로드시 동일한 파일명이 있을 경우 나중에 업로드한 파일에 번호를 붙여 이름 변경
      DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
      
      MultipartRequest mr
      = new MultipartRequest(request, saveDir, maxSize, encoding, policy);
      System.out.println("업로드 완료");
      
      //업로드 파일 정보
      String fileName=mr.getFilesystemName("upfile");
      long fileSize=0;
      String originalFileName="";
      if(fileName!=null && !fileName.isEmpty()){
         originalFileName=mr.getOriginalFileName("upfile");
         
         File file=mr.getFile("upfile");
         fileSize=file.length();
      }
      
      String no=mr.getParameter("no");
      String title=mr.getParameter("title");
      String name=mr.getParameter("name");
      String pwd=mr.getParameter("pwd");
      String email=mr.getParameter("email");
      String content=mr.getParameter("content");
      String oldFileName=mr.getParameter("oldFileName");
      
      //2
      ReBoardDAO dao=new ReBoardDAO();
      ReBoardVO vo=new ReBoardVO();
      vo.setContent(content);
      vo.setEmail(email);
      vo.setName(name);
      vo.setPwd(pwd);
      vo.setTitle(title);
      vo.setNo(Integer.parseInt(no));
      vo.setFileName(fileName);
      vo.setOriginalFileName(originalFileName);
      vo.setFileSize(fileSize);
      
      //[1]비밀번호 체크
      if(dao.checkPwd(Integer.parseInt(no), pwd)){
         int cnt=dao.updateReBoard(vo);
         //3
         if(cnt>0){
            //새로 첨부한 경우, 기존 파일이 있으면 기존파일 삭제처리
            if(fileName!=null && !fileName.isEmpty()){
               if(oldFileName!=null && !oldFileName.isEmpty()){
                  File oldFile=new File(saveDir, oldFileName);
                  if(oldFile.exists()){
                     boolean bool=oldFile.delete();
                     System.out.println("기존파일 삭제:"+ bool);
                  }
               }
            }
         %>
            <script type="text/javascript">
               alert('글 수정 성공!');
               location.href="detail.jsp?no=<%=no%>";
            </script>
         <%}else{%>
            <script type="text/javascript">
               alert('글 수정 실패!');
               history.go(-1);
            </script>         
         <%
         }
      }else{
         //비번 불일치해도 이미 파일 업로드가 되므로 delete해준다
         if(fileName!=null && !fileName.isEmpty()){
            File file=new File(saveDir, fileName);
            if(file.exists()){
               boolean bool=file.delete();
               System.out.println("업로드된 파일 삭제:"+ bool);
            }         
         }%>
         <script type="text/javascript">
            alert('비밀번호가 일치하지 않습니다.');
            history.go(-1);
         </script>
      <%}
   }catch(SQLException e){
      e.printStackTrace();
   }
   
   
%>
</body>
</html>