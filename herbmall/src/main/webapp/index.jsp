<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc/top.jsp" %>

<article id="centerCon">
	<img alt="메인 이미지" src="<%=request.getContextPath()%>/images/herb.JPG">
</article>
<article id="rightCon">
	<!-- 공지사항 -->
	<%@ include file="inc/mainNotice.jsp" %>
</article>
<article id="listCon">
	<h2>이벤트별 상품 목록</h2>
</article>
<%@ include file="inc/bottom.jsp" %>