<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- Bootstrap 3.3.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	 $("#search").click(function(){
		  $("form").submit()
	 })
	 
 })

</script>

<style type="text/css">
.nTitle{
	table-layout: fixed;
}

table, th {
	text-align: center;
}

/* 게시글 제목 */
td:nth-child(2) {
	text-align: left;
}	
#searchForm{
   text-align : center; 
}
table tr td{
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
#btitle{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  
}
</style>

<div class="container">

<h1>게시판</h1>
<hr> 
<span class="pull-right"><button><a href="/board/list">목록</a></button></span>

<table class="nTitle table table-striped table-hover">
<thead>
	<tr>
		<th style="width: 10%">글번호</th>	
		<th style="width: 60%">제목</th>
		<th style="width: 15%">작성자</th>
		<th style="width: 15%">작성일</th>
	</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="board">
	<tr>
	  <c:if test="${board.B_DELETE_STATE eq 'Y'}">
		<td>${board.ROWNUM }</td>
		<td><a id="bTitle" href="/board/view?bNo=${board.B_NO }"  id="btitle"><c:out value="${board.B_TITLE}" escapeXml="true"   /></a></td>
		<td>${board.B_NICK}</td>
		<td><fmt:formatDate value="${board.B_CREATE_DATE }" pattern="yy-MM-dd HH:mm:ss" /></td>
	  </c:if>
	  <c:if test="${board.B_DELETE_STATE eq 'N' }">
	    <td>${board.ROWNUM }</td>
	    <td>삭제된 게시글입니다</td>
	    <td></td><td></td>
	  </c:if>
	</tr>
</c:forEach>
</tbody>
</table>

<span class="pull-left">total : ${paging.totalCount }</span>
<span class="pull-right"><button><a href="/board/write">글쓰기</a></button></span>

<div class="clearfix"></div>

<%-- 페이징 JSP --%> 
<jsp:include page="/WEB-INF/views/layout/paging.jsp" />

<div id="searchForm">
   <form>
   <div>
     <select name="category">
       <option value="title">제목</option>
       <option value="content">내용</option>
       <option value="totalplus">제목+내용</option>
     </select>
     <input type="text" size="20" name="search" />&nbsp;
     <input type="submit" id="search" value="검색"/>
   </div>
    </form>
</div>

</div><!-- .container -->
