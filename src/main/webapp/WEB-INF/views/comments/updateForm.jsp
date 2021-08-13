<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="c" items="${commentList }">
   <c:if test="${c.C_NO ne cmt.C_NO}">
      <div data-commentNo="${c.C_NO}" id="comment${c.C_NO }">
        <input type="hidden" id="cmtNo" name="commentNo" value="${c.C_NO}"/>
        <label>${c.C_NICK }
        <font size="2" color="lightgray"><fmt:formatDate value="${c.C_CREATE_DATE}" pattern="yy-MM-dd HH:mm:ss" /></font>
        </label><br>
        <label class="comment-txt">
           <div id="content" name="content"  style="resize:none;" >${c.C_CONTENT}</div>
        </label>
      <label id="btn_group">
        <button id="comdelete"  onclick="Cmtdelete(${c.C_NO}, ${c.B_NO })" >삭제</button>
        <button id="comdeupdate" onclick="CmtUpdateForm(${c.C_NO}, ${c.B_NO })" >수정</button><br> 
      </label>
 </div><hr>
   </c:if>
  <c:if test="${c.C_NO eq cmt.C_NO }">
   <div data-commentNo="${c.C_NO}" id="comment${c.C_NO }"> 
    <input type="hidden" id="cmtNo" name="commentNo" value="${c.C_NO}"/>
    <label>${c.C_NICK }
        <font size="2" color="lightgray"><fmt:formatDate value="${c.C_CREATE_DATE}" pattern="yy-MM-dd HH:mm:ss" /></font>
    </label><br>
    <textarea style="resize:none;" id="comment_updateContent" name="content" rows="10" cols="100" placeholder="내용을 작성하세요">${c.C_CONTENT }</textarea>
    <div>
		<button class="okbtn-after-cmtupdate" onclick="updateCmt(${c.C_NO}, ${c.B_NO })">등록</button>
		<button class="cnbtn-after-cmtupdate" onclick="updateCmtCancel(${c.C_NO})">취소</button><br>
	</div>
   </div><hr>
  </c:if>
</c:forEach>