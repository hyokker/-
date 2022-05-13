<%@page import="com.herbmall.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:useBean id="Memberservice" class="com.herbmall.member.model.MemberService"></jsp:useBean>
<%
	//[1]register.jsp 에서 중복확인 버튼을 눌러 get방식으로 이동
	//==>http://localhost:9090/herbmall/member/checkUserid.jsp?userid=
	//[2]checkUserid.jsp 에서 아이디확인 버튼을 눌러 post방식으로 이동
	
	//1
	request.setCharacterEncoding("utf-8");
	String userid=request.getParameter("userid");
	
	//2
	int result=0;
	if(userid!=null && !userid.isEmpty()){
		result=Memberservice.duplicateId(userid);
	}
	//3


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkUserid.jsp</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css"/>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btUse').click(function(){
			$(opener.document).find('#userid').val('<%=userid%>');	
			$(opener.document).find('#chkId').val('Y');
			
			self.close();
		});
	})	
</script>
</head>
<body>
	<h2>아이디 중복 검사</h2>
	<br>
	<form name="frmId" method="post" action="checkUserid.jsp">
		<input type="text" name="userid" id="userid" value="<%=userid %>" title="아이디입력">
		<input type="submit" id="submit" value="아이디 확인">
	
		<%if(result==MemberService.UNUSABLE_ID){ %>
			<p>이미 등록된 아이디 입니다. 다른아이디를 입력하세요</p>
		<%}else if(result==MemberService.USABLE_ID){%>
			<input type="button" value="사용하기" id="btUse">
			<p>사용 가능한 아이디 입니다.[사용하기 ]버튼을 누르세요
		<%} %>
	</form>
</body>
</html>