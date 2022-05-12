<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	
	String no=request.getParameter("no");
	String name=request.getParameter("name");

	Date d = new Date();
	String str=d.toLocaleString();
%>
<hr>

<p>파라미터 no : <%=no %></p>
<p>파라미터 name : <%=name %></p>

<p>현재 일자 : <%=str %></p>
