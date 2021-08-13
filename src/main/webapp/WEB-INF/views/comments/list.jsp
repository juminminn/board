<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">


</script>

<style type="text/css">


</style>

<c:forEach items="${commentList}" var="c">
 <div data-commentNo="${c.cNo}">
   <input type="hidden" id="cmtNo" name="commentNo" value="${c.cNo}"/>
     <label>${c.cNick }
      <font size="2" color="lightgray"><fmt:formatDate value="${c.cCreateDate}" pattern="yy-MM-dd HH:mm:ss" /></font>
     </label><br>
    <label class="comment-txt">
     <textarea id="content" name="content" rows="4" cols="70" style="resize:none;" >${c.cContent}</textarea>
    </label>
    <label id="btn_group">
        <button id="comdelete"  onclick="deletecomment(${c.cNo})" >삭제</button><br>
        <button id="comdeupdate" onclick="updatecomment(${c.cNo})" >수정</button> 
    </label>
 </div>
</c:forEach>