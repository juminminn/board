<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
//목록가기
$("#btnList").click(function(){
	  $(location).attr("href","/board/list")
})
//댓글 글자수 세기
$("#cmtcontent").keyup(function (e){
				 var content = $("#cmtcontent").val();
				 $('#counter').html("("+content.length+" / 300)");    //글자수 실시간 카운팅
                 
				 if (content.length > 299){
				        alert("최대 300자까지 입력 가능합니다.");
				        $(this).val(content.substring(0, 300));
				        $('#counter').html("(300 / 300)");
				    }
			 })
	//작성자 정규식
	$("#bNick").blur(function(){
		   var idck= /^[가-힣A-Za-z0-9]{1,6}$/;
		   var nick = $("#bNick").val()
		   console.log(nick);
		   
			    if(nick == '' || nick == null) {
			    	$("#bNick").focus(); 
			    	$("#idMsg").removeClass("color-correct").html("필수항목입니다 제목을 입력하세요")
			   }else if(!idck.test(nick)){
				   $("#bNick").focus();
				   $("#idMsg").removeClass("color-correct").html("한글,영어,숫자 1~10로만 입력가능합니다")
			   }else{
				   $("#idMsg").addClass("color-correct").html("사용 가능한 아이디입니다")
			   }
	   })
	   $("#bNick").on('input',function(){
		   var nick = $("#bNick").val();
		   if(nick.length>9){
			   alert("최대10자이하로 입력가능합니다")
		   }
	   })
	   //비밀번호 정규식
	   $("#bPw").blur(function(){
		   var pw = $("#bPw").val();
		   var pwck= /^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,10}/;
		 
		   if(pw == '' || pw == null) {
			   $("#bPw").focus(); 
			   $("#pwMsg").removeClass("color-correct").html("필수항목입니다 비밀번호를 입력하세요")
		   }else if(!pwck.test(pw)==true){
			   $("#bPw").focus(); 
			   $("#pwMsg").removeClass("color-correct").html("영어,숫자,특수문자가 1자이상 포함된 6~10자로만 입력가능합니다")
		   }else{
			   $("#pwMsg").addClass("color-correct").html("사용 가능한 비밀번호입니다")
		   }
	   })
	   $("#bPw").on('input',function(){
		   var pw = $("#bPw").val();
		   if(pw.length>9){
			   alert("최소6자이상 10자이하로 입력가능합니다")
		   }
 		   
	   })
			 

})<!--$(document).ready(function()-->
//삭제하기	
function deletebNo(){
	const chk = confirm("게시물을 삭제하시겠습니까?");
	if(chk){
		const pwchk = prompt("비밀번호를 입력해주세요.");
		if(pwchk === '${detail.B_PW}'){
			 $(location).attr("href","/board/delete?bNo=" + ${detail.B_NO})
		} else{
			alert("비밀번호를 다시 확인해주세요");
			
		}
	} else {
		return;
	}
}
//수정하기
function updatebNo(){
	const chk = confirm("게시물을 수정하시겠습니까?");
	if(chk){
		const pwchk = prompt("비밀번호를 입력해주세요.");
		if(pwchk === '${detail.B_PW}'){
			$(location).attr("href","/board/update?bNo=" + ${detail.B_NO} )
		} else{
			alert("비밀번호를 다시 확인해주세요");
		}
	}
}
//댓글 등록하기 
function comment_ok(){
	var isEmpty = false;
	if($("#bNick").val()==''|| $("#bNick").val() == null){
		  isEmpty = true;
		  alert("아이디를 입력하세요")
		  $("#bNick").focus();
	  }else if($("#bPw").val()==''|| $("#bPw").val() == null){
		  isEmpty = true;
		  alert("비밀번호를 입력하세요")
		  $("#bPw").focus();
	  }else if($("#cmtcontent").val()==''|| $("#cmtcontent").val() == null){
		  isEmpty = true;
		  alert("내용을 입력하세요")
		  $("#cmtcontent").focus();
	  }
	  if(isEmpty) {
			 return false;
		 }
	  $.ajax({
	 type: "get"
	 ,url:"/board/comments/insert"
   ,data:{
   	bNo : ${detail.B_NO }
       ,cNick : $("#bNick").val()
       ,cPw : $("#bPw").val()
   	,cContent : $("#cmtcontent").val()
   }
	,dataType: ""
   ,success:function(res){
   	console.log("성공")
   	$("#comment_list").html(res);
   	$("#registerComment input[name='bNick']").val("")
   	,$("#registerComment input[name='bPw']").val("")
   	,$("#registerComment textarea[name='content']").val("")
   	,$("#idMsg").addClass("color-correct").html("")
   	,$("#pwMsg").addClass("color-correct").html("")
   }	
	,error:function(res){
		console.log("실패")	
	}  
 })<!--end $.ajax -->
}
//댓글 수정기능 시작
function CmtUpdateForm(c_no,b_no){
	$.ajax({
		type: "GET"
		, url: "/board/comments/update"
		, data: {
			cNo : c_no,
			bNo : b_no
		}
		, dataType: ""
		, success: function(res){
			$("#comment_list").html(res)
		}
		, error: function(res){
			
		}
	  })
  }
//댓글 수정 취소
function updateCmtCancel(c_no){
	$.ajax({
		type: "GET"
		, url: "/board/comments/updateCancel" 
		, data: {
			cNo: c_no
		}
		, dataType: "html"
		, success: function(res){
			$("#comment"+c_no).html(res);
		}
		, error: function(res){
			
		}
	})
}
//댓글 수정 완료
function updateCmt(c_no, b_no){
	$.ajax({
		type: "POST"
		, url: "/board/comment/update"
		, data: {
			cNo : c_no,
			bNo : b_no,
			cContent: document.getElementById("comment_updateContent").value
		}
		, dataType: ""
		, success: function(res){
			$("#comment_list").html(res)
		}
		, error: function(res){
		}
	
	})
}
//댓글 삭제 
function Cmtdelete(c_no,b_no){
	$("#comdelete").parent().parent().remove();
	$.ajax({ 
		 type : "get"
		,url : "/board/comments/delete"
		,data : {
			cNo : c_no,
			bNo : b_no
		}
		,dataType: ""
		,success:function(res){
			console.log("성공")
			$("#comment_list").html(res);
		}
		,error:function(){
			console.log("실패")
		} 
	 })<!--end  $.ajax-->
	
}
</script>
<style type="text/css">
#show{
  display: none;
}
.imgfile{
width:300px;
hegiht:200px;
}
.bContent{
    margin: 0px;
    width: 962px;
    resize: none;
}
.container{
  width:962px;
}
#registerComment{
  border: 1px solid #ccc;
  width: 962px;
  height:302px;
}
#fold{
 text-align: center;
}
#bPw{
  width: 200px;
  height: 30px;
}
#bNick{
  width: 200px;
  height: 30px;
}
#content{
  width:962px;
  height:110px;
}
.color{
   color: red;
}
.color-correct{
  color: green;

</style>


<div class="container">
<h1 style="text-align:center;">게시판 상세보기</h1>
<hr>

<div class="wrchage">


<div style="font-size: xx-large; border: 1px solid #ccc; word-break:break-all;">제목 : &nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${detail.B_TITLE}" escapeXml="true" /></div><br>
<div style="font-size:x-large; border: 1px solid #ccc">작성자 : &nbsp;&nbsp;&nbsp;&nbsp;${detail.B_NICK }</div><br>
<div class="c" style="font-size:x-large; border: 1px solid #ccc">작성시간 : &nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${detail.B_CREATE_DATE}" pattern="yy-MM-dd HH:mm:ss"/></div>
<br>
<div class="bContent" style="border: 1px solid #ccc; word-break:break-all;"><span style="font-size:x-large;">내용</span><br>
<div class="bContent">${detail.B_CONTENT}</div>
</div><br>
 <c:forEach var="f" items="${viewfile}">
  <c:if test="${f.bfContentType eq image}">
    <img src="/resources/upload/${f.bfStoredName}" class="imgfile">
    <a href="/board/download?bfFileno=${f.bfFileno }">${f.bfOriginName }</a>
  </c:if>
  <c:if test="${f.bfContentType ne image}">
    <a href="/board/download?bfFileno=${f.bfFileno }">${f.bfOriginName }</a><br>
  </c:if>
 </c:forEach>

</div><br><br><br>

<div class="text-center" style="text-align: center;">
  <button id="btnList" class="btn btn-primary">목록</button>
  <input type="button" id="btnUpdate"  onclick="updatebNo()" value="수정">
  <button id="btnDelete" class="btn btn-danger"onclick="deletebNo()">삭제</button>
</div><br><br>

<div id="registerComment">
  <div class="nNick">작성자 : &nbsp;&nbsp;<input type="text" name="bNick" id="bNick" placeholder="아아디을 입력해주세요." maxlength="6"/>
    <span id="idMsg" class="color"></span> 
  </div><br>
  <div class="nPw">비밀번호 : &nbsp;&nbsp;<input type="text" name="bPw" id="bPw" placeholder="비밀번호을 입력해주세요." maxlength="10"/>
    <span id="pwMsg" class="color"></span>
  </div><br>
  <div><textarea style="resize:none;" id="cmtcontent" name="content" rows="10" cols="100" placeholder="내용을 작성하세요"></textarea></div>
  <span style="color:#aaa;" id="counter">(0 /300)</span><br>
  <button id="register" onclick="comment_ok()">등록하기</button>
</div><br><br>



<div id="comment_list" class="comment_list">
<c:forEach items="${commentList}" var="c">
 <div id="comment${c.C_NO}" data-commentNo="${c.C_NO}">
   <input type="hidden" id="cmtNo" name="commentNo" value="${c.C_NO}"/>
   <input type="hidden" id="cmtPw" value="${c.C_PW}"/>
     <label>${c.C_NICK }
      <font size="2" color="lightgray"><fmt:formatDate value="${c.C_CREATE_DATE}" pattern="yy-MM-dd HH:mm:ss" /></font>
     </label><br>
    <label class="comment-txt">
     <div id="content" name="content"  style="resize:none;" >${c.C_CONTENT}</div>
    </label>
    <label id="btn_group">
        <button id="comdelete"  onclick="Cmtdelete(${c.C_NO}, ${c.B_NO})" >삭제</button>
        <button id="comdeupdate" onclick="CmtUpdateForm(${c.C_NO}, ${c.B_NO})" >수정</button><br> 
    </label>
 </div><hr>
</c:forEach>
</div>

</div><!-- end class="container"  -->







