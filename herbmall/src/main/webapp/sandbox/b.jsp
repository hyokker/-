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
	request.setCharacterEncoding("utf-8");
	String name=request.getParameter("name");
	String addr=request.getParameter("address");
	String hobby=request.getParameter("hobby");
	
	String fruit=(String)request.getAttribute("fruit");
%>
<h1>b.jsp 페이지</h1>
<h2>요청 파라미터</h2>
<p>name : <%=name %></p>
<p>address : <%=addr %></p>
<p>hobby : <%=hobby %></p>

<h2>속성</h2>
<p>과일 : <%=fruit %></p>
</body>
</html>