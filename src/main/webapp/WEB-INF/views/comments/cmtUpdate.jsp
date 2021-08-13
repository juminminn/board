<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="c" items="${commentList }">
  <div id="comment${c.C_NO }" class="comment">
     <input type="hidden" id="cmtNo" name="commentNo" value="${c.C_NO}"/>
   <input type="hidden" id="cmtPw" value="${c.C_PW}"/>
     <label>${c.C_NICK }
      <font size="2" color="lightgray"><fmt:formatDate value="${c.C_CREATE_DATE}" pattern="yy-MM-dd HH:mm:ss" /></font>
     </label><br>
    <label class="comment-txt">
     <div id="content" name="content"  style="resize:none;" >${c.C_CONTENT}</div>
    </label>
    <label id="btn_group">
        <button id="comdelete"  onclick="Cmtdelete(${c.C_NO}, ${c.B_NO })" >삭제</button>
        <button id="comdeupdate" onclick="CmtUpdateForm(${c.C_NO}, ${c.B_NO},${c.C_PW})" >수정</button><br> 
    </label>
 </div><hr>
  
</c:forEach>