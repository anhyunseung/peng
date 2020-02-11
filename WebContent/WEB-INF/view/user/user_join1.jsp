<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="poly.util.CmmUtil"%>
        <%
        String SESSION_USER_ID =CmmUtil.nvl((String) session.getAttribute("USER_ID"));
        System.out.println("ss_user_id : " + SESSION_USER_ID);
        String url=CmmUtil.nvl((String)session.getAttribute("url"));
        if(url.isEmpty()){
        	url="/top.do";
        }
        String id_over = CmmUtil.nvl((String) session.getAttribute("id_over"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/user/user_join.do/../../img/common/icon.ico" type="image/x-icon" />
<title>회원가입 : Lovie</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SESSION_USER_ID%>";
	   var over_id="<%=id_over%>"
	   if (user_id!=""||over_id==""){
		      alert("잘못된 접근입니다.");
	      location.href="<%=url%>";

		}

	}
function enterkey(a) {
    if (window.event.keyCode == 13) {

         // 엔터키가 눌렸을 때 실행할 내용
         doSubmit(a);
    }
}
function doSubmit(a) {
	if(f.email1.value == ""){
	      alert("이메일을 입력 해주세요.");
	      f.email1.focus();
	      return false;
	   }
		if(f.email2.value == "bd"){
	      alert("이메일을 입력 해주세요.");
	      f.email2.focus();
	      return false;
	   }
	   a.form.submit();
	}
function doKeyOnlyNumber(event) {
   event = event || window.event;
   var keyID = (event.which) ? event.which : event.KeyCode;
   
   if((keyID >= 48 && keyID <= 57) || (keyID>=96 && keyID <=105) || keyID==8 || keyID==37 || keyID==39 || keyID==9){
      return true;
   }else{
      return false;
   }
}

function doKeyOnlyWord(event) {
   event = event || window.event;
   var keyID = (event.which) ? event.which : event.KeyCode;
   
   if((keyID >= 65 && keyID <= 90) || keyID==8 || keyID==37 || keyID==39 || keyID==9 || keyID==229){
      return true;
   }else{
      return false;
   }
}

function doKeyIdPw(event) {
   event = event || window.event;
   var keyID = (event.which) ? event.which : event.KeyCode;
   
   if((keyID >= 48 && keyID <= 57) || (keyID>=96 && keyID <=105) || (keyID >= 65 && keyID <= 90) || keyID==8 || keyID==37 || keyID==39 || keyID==9 ){
      return true;
   }else{
      return false;
   }
}
function dojoin() {
	location.href = "/user/user_join.do";
}
</script>
<style>
html, body {
	margin: 0;
	word-break:break-all;
	min-hight:500px;
}
a:link {
	text-decoration: none;
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

div.maindiv {
	padding:200px 0;
	width: 100%;
	height: 100%;
}
div.jointotal>div{
	display: inline-block;
}
div.joinstart{
	position:relative;
	top:2px;
	height: 90%;
	width:228px;
	background-color:rgba(220,220,220); 
	border:1px solid rgba(150,150,150,0.7);
}
div.joinmiddle{
	height: 99%;
	width:228px;
	background-color:rgba(150,150,150); 
	border:1px solid rgba(40,40,40,0.7);
}
div.joinend{
	position:relative;
	top:2px;
	height: 90%;
	width:228px;
	background-color:rgba(220,220,220); 
	border:1px solid rgba(150,150,150,0.7);
}
div.joindiv {
	border:1px solid rgba(180,180,180,0.7);
	background-color: rgba(255,255,255,0.9);
	width: 600px;
	height:100%;
	padding: 50px 50px;
	box-shadow: 2px 2px 2px 0 rgba(100, 100, 100, 0.4);
}
.id:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}
.id{
	width: 160px;
	height: 40px;
	font-size: large;
	padding: 0 10px 0 10px;
	margin:40px 0 15px 0;
	outline-color: #888888;
}
.idf{
	width:130px;
	background-color:#ffffff;
	height:44px;
	text-align: center;
	text-decoration: none;
	color:#888888;
	border: 2px solid #888888;
	font-size: 16px;
	display: inline-block;
	transition: all 0.2s ease-in-out;
	position: relative;
	overflow: hidden;
	transition: all 0.2s ease-in-out;
	position: relative;
	top:1px;
	outline: 0;
	cursor: pointer;
}
.idf:hover {
	background-color: #888888;
	color: #fff;
}

.cc{
	width:130px;
	background-color:#ffffff;
	height:44px;
	text-align: center;
	text-decoration: none;
	color:#924040;
	border: 2px solid #924040;
	font-size: 16px;
	display: inline-block;
	transition: all 0.2s ease-in-out;
	position: relative;
	overflow: hidden;
	transition: all 0.2s ease-in-out;
	position: relative;
	top:1px;
	outline: 0;
	cursor: pointer;
}
.cc:hover {
	background-color: #924040;
	color: #fff;
}

</style>
</head>
<body onload="doOnload();" style="min-width: 800px; background-color: #f3f3f3;">
<form action="/user/user_join4.do" method="post" name="f" onsubmit="return doSubmit(this);" style="height: 100%;">
		<font face='Malgun Gothic' style='line-height: 1.4;' />
		<div class="maindiv" align="center">
	<div class="jointotal" style="width: 702px; height: 100px;">
		<div class="joinstart" >
		<div style="position: relative; top:35px;">
		<font face='Malgun Gothic' size="4px"
						style="color: rgba(150,150,150)"> <b>아이디 중복확인</b>
					</font> </div></div>
		<div class="joinmiddle" >
		<div style="position: relative; top:35px;">
		<font face='Malgun Gothic' size="5px"
						style="color: rgba(40,40,40)"> <b>이메일 중복확인</b>
					</font> </div></div>
		<div class="joinend">
		<div style="position: relative; top:35px;">
		<font face='Malgun Gothic' size="4px"
						style="color: rgba(150,150,150)"> <b>회원가입</b>
					</font></div></div>
	</div>
		<div class="joindiv">
		<a href="/top.do">
			<img src="../img/user/loginlogo.png">
			</a><br/>
        <input type="text" name="email1" maxlength="20" class="id"
						onkeydown="return doKeyIdPw(event)" placeholder="이메일" autocomplete="off" />
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>@</b>
						</font> <select name="email2" class="id"
							style="height: 44px; width: 170px">
							<option value="bd"></option>
							<option value="naver.com">naver.com</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
         <input type="submit" class="idf" value="중복확인"/>
         <br/>
         <input type="button" class="cc" onclick="javascript:dojoin();" value="돌아가기"/>
		</div>
	</div>
</form>
</body>
</html>