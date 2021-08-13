<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

   <input type="hidden" id="cmtNo" name="commentNo" value="${cmtcan.C_NO}"/>
   <input type="hidden" id="cmtPw" value="${cmtcan.C_PW}"/>
     <label>${cmtcan.C_NICK }
      <font size="2" color="lightgray"><fmt:formatDate value="${cmtcan.C_CREATE_DATE}" pattern="yy-MM-dd HH:mm:ss" /></font>
     </label><br>
    <label class="comment-txt">
     <div id="content" name="content"  style="resize:none;" >${cmtcan.C_CONTENT}</div>
    </label>
    <label id="btn_group">
        <button id="comdelete"  onclick="Cmtdelete(${cmtcan.C_NO},${cmtcan.B_NO })" >삭제</button>
        <button id="comdeupdate" onclick="CmtUpdateForm(${cmtcan.C_NO}, ${cmtcan.B_NO})" >수정</button><br> 
    </label>
    <hr>