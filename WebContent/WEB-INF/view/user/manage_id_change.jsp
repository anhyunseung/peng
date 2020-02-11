<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String SS_USER_ID_CH = CmmUtil.nvl((String)session.getAttribute("USER_ID_CHE"));
String SS_USER_ID = CmmUtil.nvl((String)session.getAttribute("USER_ID"));
System.out.print(SS_USER_ID_CH);
String url = CmmUtil.nvl((String) session.getAttribute("url"));
if(url.isEmpty()){
	url="/top.do";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/user/manage_id_change.do/../../img/common/icon.ico" type="image/x-icon" />
<title>Let's see the movie! : Lovie - 아이디 변경</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SS_USER_ID%>";
	   if (user_id!="admin"){
		      alert("잘못된 접근입니다.");
	      location.href="<%=url%>";

		}

	}
function doIdchack(f){
	if(f.user_id.value == ""){
	      alert("아이디를 입력해주세요.");
	      f.user_id.focus();
	      return false;
	   }
}
function doKeyIdPw(event) {
	   event = event || window.event;
	   var keyID = (event.which) ? event.which : event.KeyCode;
	   
	   if((keyID >= 48 && keyID <= 57) || (keyID>=96 && keyID <=105) || (keyID >= 65 && keyID <= 90) || keyID==8 || keyID==37 || keyID==39 || keyID==9){
	      return true;
	   }else{
	      return false;
	   }
	}
</script>
<style>
html, body {
	margin: 0;
	height: 100%;
	word-break: break-all;
}
div.maindiv {
	padding: 15px 0 10px 0;
	width: 100%;
}
div.logindiv {
	box-shadow: 2px 2px 2px 0 rgba(100, 100, 100, 0.4);
	background-color: rgba(255,255,255,0.9);
	width: 370px;
	height: 160px;
	padding: 10px 10px;
}
div.logindiv>div>div{
	display: inline-block;
}
.joinfont{
	width:70px;
}
.id:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}

.id {
	width: 180px;
	height: 28px;
	padding: 0 10px 0 10px;
	margin: 15px 0 10px 0;
	outline-color: #888888;
	position: relative;
}

.id:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}
.sign {
	width: 80px;
	background-color: #ffffff;
	height: 33px;
	text-align: center;
	text-decoration: none;
	color:#888888;
	border: 1px solid #888888;
	font-size: 16px;
	display: inline-block;
	transition: all 0.2s ease-in-out;
	position: relative;
	overflow: hidden;
	transition: all 0.2s ease-in-out;
	position: relative;
	top: 1px;
	outline:0;
	cursor: pointer;
	position: relative;
	top:2px;
}

.sign:hover {
	background-color: #888888;
	color: #fff;
}
</style>
</head>
<body onload="doOnload();" style="min-width: 400px; background-color: #f3f3f3;">
<form name="f" method="post" action="/user/manage_id_check.do" onsubmit="return doIdchack(this);">
<font face='Malgun Gothic' style='line-height: 1.4' />
	<div class="maindiv" align="center">
		<div class="logindiv">
					<div style="padding: 30px 0 20px 0;">
						<font face='Malgun Gothic' size="5px" style="color: #777777;">
							<b><%=SS_USER_ID_CH%></b>
						</font>
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>님의 아이디를 변경합니다.</b>
						</font>
					</div>
					<input type="text" name="user_id" maxlength="20" class="id"
						onkeydown="return doKeyIdPw(event)" placeholder="아이디" autocomplete="off"/>
					<input type="submit" class="sign" value="확인"/>
		</div>
	</div>
</form>
</body>
</html>