<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register2_ok.jsp</title>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");
%>
	<!-- 1. 요청 파라미터 읽어오기 -->
<jsp:useBean id="memVo" class="com.herbmall.member.model.MemberVO"
 scope="page"></jsp:useBean>
<jsp:useBean id="memDao" class="com.herbmall.member.model.MemberDAO"
 scope="session"></jsp:useBean>
 
<jsp:setProperty property="*" name="memVo"/>
 
<%
	//register2.jsp 에서 post 방식으로 submit
	/*2  */
	String msg="가입 실패", url="register2.jsp";
	try{
		
		int cnt=memDao.insertMember(memVo);
		
		if(cnt>0){
			msg="회원가입 되었습니다.";
			url="../index.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3
	request.setAttribute("msg", msg);	
	request.setAttribute("url", url);

%>
<!-- forward하면 request를 공유하므로 현재 페이지와 message.jsp는 같은 request를 갖는다  -->
<jsp:forward page="../common/message.jsp"></jsp:forward>

</body>
</html>