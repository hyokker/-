<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.zipcode.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="zipService" class="com.herbmall.zipcode.model.ZipcodeService"></jsp:useBean>	
	
<%
	//[1] register.jsp 에서 우편번호찾기 버튼을 눌러 get방식으로 이동,새창열림
	//[2] zipcode.jsp 에서 찾기 클릭하면 post 방식으로 서브밋
	
	//1
	request.setCharacterEncoding("utf-8");
	String dong=request.getParameter("dong");
	//2
	
	List<ZipcodeVO> list=null;

		if(dong!=null && !dong.isEmpty()){
			list=zipService.selectByAll(dong);
		}

	//3
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>zipcode.jsp</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h2>우편번호 검색</h2>
	<p style="font-weight: bold" >찾고 싶으신 주소의 동(읍/면)을 입력하세요</p>
	<form name="frmZipcode" method="post" action="zipcode.jsp">
		<label for="dong">지역명 : </label>
		<input type="text" name="dong" id="dong" style="ime-mode: active">
		<input type="submit" id="submit" value="찾기">
	</form>
	<table style="width: 470px" class="box2"
		summary="우편번호 검색 결과에 관한 표로써, 우편번호, 주소에 대한 정보를 제공합니다.">
		<colgroup>
			<col style="width: 20%" />
			<col style="width: *" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">우편번호</th>
				<th scope="col">주소</th>
			</tr>
		</thead>
		<tbody>
			
		
		</tbody>
</body>
</html>