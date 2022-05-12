<%@page import="com.herbmall.test.SimpleVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>usebeanTest_ok</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	//기존방식
/* 	String msg=request.getParameter("msg");
	
	SimpleVO vo = new SimpleVO();
	vo.setMsg(msg); */
%>
<jsp:useBean id="simVo" class="com.herbmall.test.SimpleVO"
	scope="page"></jsp:useBean>
	<jsp:setProperty property="msg" name="simVo"/>
	<jsp:setProperty property="name" name="simVo"/>
<h1>파라미터</h1>
<%-- <p>msg : <%=vo.getMsg() %></p> --%>

<p>메시지 : <jsp:getProperty property="msg" name="simVo"/></p>
<p>이름 : <jsp:getProperty property="name" name="simVo"/></p>


</body>
</html>