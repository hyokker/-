<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memVo" class="com.herbmall.member.model.MemberVO" scope="page"></jsp:useBean>
<jsp:useBean id="memberService" class="com.herbmall.member.model.MemberService" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOut_ok.jsp</title>
</head>
<body>
<%
	String userid=(String)session.getAttribute("userid");
	request.setCharacterEncoding("utf-8");
	
	String pwd=request.getParameter("pwd");
	String msg="비밀번호 체크 실패", url="memberOut.jsp";
	try{
		int result=memberService.checkLogin(userid, pwd);
		
		if(result==MemberService.LOGIN_OK){
			int cnt=memberService.updateOutdate(userid, pwd);
			
			if(cnt>0){
				msg="회원탈퇴 성공.";
				url="../index.jsp";
				
				//[1]세션 초기화
				session.invalidate();
				
				//[2]쿠키 초기화
				Cookie ck = new Cookie("ck_userid", userid);
				ck.setPath("/");
				ck.setMaxAge(0);//쿠키 유효시간 : 0 => 쿠키삭제
				response.addCookie(ck);
	 		}else{
		   		msg="회원탈퇴 실패";
	 		}
	}else if(result==MemberService.DISAGREE_PWD){
		         msg="비밀번호가 일치하지 않습니다";         
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