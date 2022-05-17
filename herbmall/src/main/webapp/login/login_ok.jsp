<%@page import="com.herbmall.member.model.MemberVO"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login_ok.jsp</title>
</head>
<body>
<jsp:useBean id="memberservice" class="com.herbmall.member.model.MemberService" scope="session"></jsp:useBean>
<%
	//login.jsp 에서 post 방식으로 submit됨.
	
	//1 요청 파라미터 읽어오기
	request.setCharacterEncoding("utf-8");
	String userid=request.getParameter("userid");
	String pwd=request.getParameter("pwd");
	String chkSaveId=request.getParameter("chkSaveId");
	
			//2
	String msg="로그인 실패", url="login.jsp";
			MemberVO vo = null;
		try{
			int result=memberservice.checkLogin(userid, pwd);
			//3
			if(result==MemberService.LOGIN_OK){
				vo=memberservice.selectByUserid(userid);
				//[1]session에 로그인 정보 저장 
				session.setAttribute("userid", userid);						
				session.setAttribute("userName", vo.getName());						
				//[2]쿠키에 아이디 저장
					Cookie ck = new Cookie("ck_userid",userid);
					ck.setPath("/");
				if(chkSaveId!=null){//체크한 경우
					ck.setMaxAge(1000*24*60*60); //쿠키유효시간 - 1000일 
					response.addCookie(ck);
				}else{
					ck.setMaxAge(0); //쿠키유효시간 - 0 => 쿠키 삭제 
					response.addCookie(ck);
					
				}
	
				
				msg=vo.getUserid()+"님, 로그인 되었습니다.";
				url="../index.jsp";
			}else if(result==MemberService.DISAGREE_PWD){
				msg="비밀번호가 일치하지 않습니다.";
			}else if(result==MemberService.NONDE_USERID){
				msg="존재하지 않는 아이디 입니다.";
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