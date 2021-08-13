<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<!--  부트스트랩 3.2.2 -->
<!-- 합쳐지고 최소화된 최신 CSS -->


<script type="text/javascript">
$(document).ready(function(){
	//작성버튼
	$("#btnWrite").click(function(){
		var isEmpty = false;
		  if($("#bNick").val()==''|| $("#bNick").val() == null){
			  isEmpty = true;
			  alert("아이디를 입력하세요")
			  $("#bNick").focus();
		  }else if($("#bPw").val()==''|| $("#bPw").val() == null){
			  isEmpty = true;
			  alert("비밀번호를 입력하세요")
			  $("#bPw").focus();
		  }else if($("#bTitle").val()==''|| $("#bTitle").val() == null ){
			  isEmpty = true;
			  alert("제목을 입력하세요")
			  $("#bTitle").focus();
		  }else if($("#bContent").val()==''|| $("#bContent").val() == null){
			  isEmpty = true;
			  alert("내용을 입력하세요")
			  $("#bContent").focus();
		  }
		  if(isEmpty) {
				 return false;
			 }
		  $('form').submit();
	})
	//취소버튼
	$("#btnCancel").click(function(){
		
		$("#bNick").val("");
		$("#bPw").val("");
		$("#bTitle").val("");
		$("#bContent").val("");
		$("#file").val("");
		$(location).attr("href","/board/write");
	})
	//목록가기
	$("#btnlist").click(function(){
		$(location).attr("href","/board/list");
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
	   
	
	//제목 글자수 초과시 처리,공백문자 처리
		$("#bTitle").on('keyup',function(){
			 var title = $("#bTitle").val();
				console.log(title);
				
				if(title.length==100){
		 		 alert("최대 100자까지 입력 가능합니다");
				}
		  })
		 $("#bTitle").blur('input',function(){
			 var bTitle = $("#bTitle").val();
			
			 if(bTitle == '' || bTitle == null){
				 $("#bTitle").focus();
				 $("#titleMsg").removeClass("color-correct").html("필수항목입니다 제목를 입력하세요")
			 }else{
				 $("#titleMsg").addClass("color-correct").html("")
			 }
			 })
                        	 
			 $("#bContent").keyup(function (e){
				 var content = $("#bContent").val();
				 $('#counter').html("("+content.length+" / 1000)");    //글자수 실시간 카운팅
                 
				 if (content.length > 999){
				        alert("최대 1000자까지 입력 가능합니다.");
				        $(this).val(content.substring(0, 1000));
				        $('#counter').html("(1000 / 1000)");
				    }
			 })
			 //비밀번호 안보이게 표시
			 $(document).ready(function(){
				    $('.nPw i').on('click',function(){
				        $('input').toggleClass('active');
				        if($('input').hasClass('active')){
				            $(this).attr('class',"fa fa-eye-slash fa-lg")
				            .prev('input').attr('type',"text");
				        }else{
				            $(this).attr('class',"fa fa-eye fa-lg")
				            .prev('input').attr('type','password');
				        }
				    });
				});


			 
})<!--$(document).ready(function()-->
//파일업로드시 용량 체크
function checkFile(el){

	// files 로 해당 파일 정보 얻기.
	var file = el.files;

	// file[0].size 는 파일 용량 정보입니다.
	if(file[0].size > 1024 * 1024 * 2){
		// 용량 초과시 경고후 해당 파일의 용량도 보여줌
		alert('2MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(file[0].size / 1024 / 1024 * 100) / 100) + 'MB');
	}

	// 체크를 통과했다면 종료.
	else return;

	// 체크에 걸리면 선택된 내용 취소 처리를 해야함.
	// 파일선택 폼의 내용은 스크립트로 컨트롤 할 수 없습니다.
	// 그래서 그냥 새로 폼을 새로 써주는 방식으로 초기화 합니다.
	// 이렇게 하면 간단 !?
	el.outerHTML = el.outerHTML;
}
//파일업로드 버튼 추가
attachFile = {
        idx:0,
        add:function(){ // 파일필드 추가
            var o = this;
            var idx = o.idx;
 
            var div = document.createElement('div');
            div.style.marginTop = '3px';
            div.id = 'file' + o.idx;
 
            var file = document.all ? document.createElement('<input name="file">') : document.createElement('input');
            file.type = 'file';
            file.name = 'file';
            file.id = 'fileField' + o.idx;
 
            var btn = document.createElement('input');
            btn.type = 'button';
            btn.value = '삭제';
            btn.onclick = function(){o.del(idx)}
            btn.style.marginLeft = '5px';
 
            div.appendChild(file);
            div.appendChild(btn);
            document.getElementById('attachFileDiv').appendChild(div);
 
            o.idx++;
        },
        del:function(idx){ // 파일필드 삭제
            if(document.getElementById('fileField' + idx).value != '' && !confirm('삭제 하시겠습니까?')){
                return;
            }
            document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
        }
       
    }	

</script>

<style type="text/css">
#bContent{
    margin:0px;
    width: 962px;
    height: 302px;
    resize: none;
}
#bTitle{
  width: 900px;
  height: 30px;
}
#bPw{
  width: 200px;
  height: 30px;
}
#bNick{
  width: 200px;
  height: 30px;
}
.color{
   color: red;
}
.color-correct{
  color: green;
}

</style>

<div id="container">

<div class="anbody2">

<h1>게시판 글쓰기</h1><br>
<div class="buttonbox">
</div>

<form action="/board/write" method="post" enctype="multipart/form-data">

<div class="nNick">작성자 : &nbsp;&nbsp;<input type="text" name="bNick" id="bNick" placeholder="아아디을 입력해주세요." maxlength="6"/>
    <span id="idMsg" class="color"></span>  
</div><br>
<div class="nPw">비밀번호 : &nbsp;&nbsp;<input type="text" name="bPw" id="bPw" placeholder="비밀번호을 입력해주세요." maxlength="10"/><i class="fa fa-eye fa-lg"></i>
    <span id="pwMsg" class="color"></span>
</div><br>
<div class="nTitle">제목 :&nbsp;&nbsp;<input type="text" name="bTitle" id="bTitle" placeholder="제목을 입력해주세요." maxlength="100"/><br>
    <span id="titleMsg" class="color"></span>
</div><br>
<div class="nContent"><textarea cols="140" rows="15" id="bContent" name="bContent" placeholder="내용을 입력해주세요." maxlength="1000"></textarea></div>
<span style="color:#aaa;" id="counter">(0 /1000)</span><Br><br>


<!-- <input type="file" name="image" id="image" accept="image/*" onchange="setThumbnail(event);" multiple="multiple" /><br> -->
<script>

</script>
<!-- <input type="file" name="file"/><br><br> -->
<div id="attachFileDiv"><input type="file" name="file" value="" onchange="checkFile(this)"><input type="button" value="추가" onclick="attachFile.add()" style="margin-left:5px"></div><br><br>

<input type="button" id="btnlist" value="목록" >
<input type="button" id="btnCancel" value="취소">
<input type="button" id="btnWrite"  value="완료">

</form>
</div> <%-- anbody end --%>

</div> <%-- content end --%>




