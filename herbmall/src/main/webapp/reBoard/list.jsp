<%@page import="com.herbmall.reboard.model.PagingVO"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	//[1]write.jsp에서 글목록 클릭하면 get방식으로 이동
	//[2]write_ok.jsp에서 글쓰기 성공하면 get방식으로 이동
	//[3]검색 - list.jsp에서 post방식으로 submit
	//[4]페이징처리 - list.jsp에서 페이지번호 누르면 get방식으로 이동		
/* 	response.setCharacterEncoding("text/html;charset=uft-8"); */
	//1
	//검색 - 파라미터
	request.setCharacterEncoding("utf-8");
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");	
	
	//2
	ReBoardDAO dao=new ReBoardDAO();

	List<ReBoardVO> list=null;
	try{
		list=dao.selectAll(condition, keyword);	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	if(keyword==null) keyword="";
	
	//페이징 처리
	int currentPage=1;  //현재 페이지
	
	//list.jsp?currentPage=3
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt((request.getParameter("currentPage")));
	}
	
	//[1] 현재 페이지와 무관한 변수
	int totalRecord=list.size();  //총레코드 수  17
	int pageSize=5; //한 페이지에 보여줄 레코드(행) 수
	int blockSize=10; //한 블럭에 보여줄 페이지 수

	PagingVO pageVo=new PagingVO(currentPage, totalRecord, pageSize, blockSize);
	
%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>답변형게시판 글 목록 - 허브몰</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">	
	$(function(){
		$('.divList table.box2 tbody tr').hover(function(){
			$(this).css('background','lightblue');
		}, function(){
			$(this).css('background','');
		});
	});
</script>
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }	
</style>	
</head>	
<body>
<h2>답변형 게시판</h2>
<% if(keyword!=null && !keyword.isEmpty()){ %>
	<p>검색어 : <%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>
<%} %>

<div class="divList">
<table class="box2"
	 	summary="답변형 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다.">
	<caption>답변형 게시판</caption>
	<colgroup>
		<col style="width:10%;" />
		<col style="width:50%;" />
		<col style="width:15%;" />
		<col style="width:15%;" />
		<col style="width:10%;" />		
	</colgroup>
	<thead>
	  <tr>
	    <th scope="col">번호</th>
	    <th scope="col">제목</th>
	    <th scope="col">작성자</th>
	    <th scope="col">작성일</th>
	    <th scope="col">조회수</th>
	  </tr>
	</thead> 
	<tbody>  
	<%if(list.isEmpty()){ %>
		<tr>
			<td colspan="5" class="align_center">해당 글이 존재하지 않습니다.</td>
		</tr>
	<%}else{ %>	
	  <!--게시판 내용 반복문 시작  -->	
	  <%
	  int num=pageVo.getNum();
	  int curPos=pageVo.getCurPos();
	  
	  for(int i=0;i<pageVo.getPageSize();i++){ 
		  	if(num-- <1) break;
		  	
	  		ReBoardVO vo = list.get(curPos++);
	  %>	
		<tr  style="text-align:center">
			<td><%=vo.getNo() %></td>
			<td style="text-align:left">
				<!-- 답변글인 경우 이미지 넣기 -->
				 <%-- <%
				 if(vo.getStep()>0){
		              for(int j=0;j<vo.getStep();j++){  %>
		               		&nbsp;
		              <%}%>
		               
		              <img src="../images/re.gif">
		         <%} %> --%>
		          
		         <%=Utility.displayRe(vo.getStep()) %>
		        <%if(vo.getDelFlag().equals("Y")){ %>
		        	<p style="color:gray">삭제된 글입니다</p>
		        <%}else{ %>
		        <!-- 제목이 긴 경우 일부 글자만 보여주기 -->  
				<a href="countUpdate.jsp?no=<%=vo.getNo()%>">
					
					<%=Utility.cutString(vo.getTitle(), 35) %>
				</a>
				
				<!-- 24시간 이내의 글인 경우 new 이미지 보여주기 -->
		        <%=Utility.displayNew(vo.getRegdate()) %>
				<%} %>
			</td>
			<td><%=vo.getName() %></td>
			<td><%=sdf.format(vo.getRegdate()) %><\/td>
			<td><%=vo.getReadcount() %></td>		
		</tr>
	  <%}//for %>	 
	  <!--반복처리 끝  -->
	 <%}//if %> 
	 </tbody>
</table>	   
</div>
<div class="divPage">
	<!-- 이전블럭으로 이동 -->
	<%
		if(pageVo.getFirstPage()>1){ %>
			<a href='list.jsp?currentPage=<%=pageVo.getFirstPage()-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
				<img src='../images/first.JPG'>
			</a>	
	<%	} %>

	<!-- 페이지 번호 추가 -->						
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=pageVo.getFirstPage();i<=pageVo.getLastPage();i++){
			if(i>pageVo.getTotalPage()) break;  
			
			if(i==currentPage){	%>
				<span style="color: blue;font-weight: bold;font-size: 1em">
					<%=i %></span>
			<%}else{ %>
				<a href
	='list.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
					[<%=i %>]</a>
			<%} %>		
	<%	} %>
	<!--  페이지 번호 끝 -->
	
	<!-- 다음 블럭으로 이동 -->
	<%
		if(pageVo.getLastPage() < pageVo.getTotalPage()){ %>
			<a href='list.jsp?currentPage=<%=pageVo.getLastPage()+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>'>
				<img src='../images/last.JPG'>
			</a>	
	<%	} %>
</div>
<div class="divSearch">
   	<form name="frmSearch" method="post" action='list.jsp'>
        <select name="searchCondition">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="name">작성자</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력하세요"
        	value="">   
		<input type="submit" value="검색">
    </form>
</div>

<div class="divBtn">
    <a href='write.jsp' >글쓰기</a>
</div>

</body>
</html>

