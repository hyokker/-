<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberEdit_ok.jsp</title>
</head>
<body>
<%@ include file="../login/loginCheck.jsp" %>

<jsp:useBean id="memService" class="com.herbmall.member.model.MemberService"
   scope="session"></jsp:useBean>
<jsp:useBean id="memVo" class="com.herbmall.member.model.MemberVO"
   scope="page"></jsp:useBean>
<%
   //memberEdit.jsp에서 post방식으로 이동
   //1
   request.setCharacterEncoding("utf-8");
   String userid=(String)session.getAttribute("userid");

   String email1=request.getParameter("email1");
   String email2=request.getParameter("email2");
   String email3=request.getParameter("email3");
   String pwd=request.getParameter("pwd");
   String hp1=request.getParameter("hp1");
   String hp2=request.getParameter("hp2");
   String hp3=request.getParameter("hp3");
   String zipcode=request.getParameter("zipcode");
   String address=request.getParameter("address");
   String addressDetail=request.getParameter("addressDetail");
   
   String hp="", email="";
   if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()){
      hp=hp1+"-"+hp2+"-"+hp3;
   }
   
   if(email1!=null && !email1.isEmpty()){
      if(email2.equals("etc")){
         if(email1!=null && !email1.isEmpty()){
            email=email1+"@"+email3;
         }
      }else{
         email=email1+"@"+email2;
      }
   }
   //2
   //3
   String msg="비밀번호 체크 실패", url="memberEdit.jsp";
   try{      
      int result=memService.checkLogin(userid, pwd);
      if(result==MemberService.LOGIN_OK){
         memVo.setUserid(userid);
         memVo.setEmail(email);
         memVo.setPwd(pwd);
         memVo.setHp(hp);
         memVo.setZipcode(zipcode);
         memVo.setAddress(address);
         memVo.setAddressDetail(addressDetail);
         
         int cnt=memService.updateMember(memVo);
         if(cnt>0){            
            msg="회원정보가 수정되었습니다.";            
         }else{
            msg="회원수정 실패";            
         }
      }else if(result==MemberService.DISAGREE_PWD){
         msg="비밀번호 불일치!!";
      }
   }catch(SQLException e){
      e.printStackTrace();
   }
   
   request.setAttribute("msg", msg);
   request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>