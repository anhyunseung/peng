<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/user/user_id_search.do/../../img/common/icon.ico" type="image/x-icon" />
<title>Let's see the movie! : Lovie - 아이디 찾기</title>
<script type="text/javascript">
function doSubmit(f) {
   if(f.user_name.value == ""){
      alert("성명 또는 이메일을 입력해주세요.");
      f.user_name.focus();
      return false;
   }
   
   if(f.email1.value == ""){
      alert("성명 또는 이메일을 입력해주세요.");
      f.email1.focus();
      return false;
   }
   
   if(f.email2.value == "bd"){
      alert("성명 또는 이메일을 입력해주세요.");
      f.email2.focus();
      return false;
   }
}

function doKeyOnlyNumber(event) {
   event = event || window.event;
   var keyID = (event.which) ? event.which : event.KeyCode;
   
   if((keyID >= 48 && keyID <= 57) || (keyID>=96 && keyID <=105) || keyID==8){
      return true;
   }else{
      return false;
   }
}
function Close_Event(){
    window.close();
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
.email {
	width: 70px;
	height: 28px;
	padding: 0 10px 0 10px;
	margin: 15px 0 15px 0;
	outline-color: #888888;
	position: relative;
}

.email:-webkit-autofill {
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
}

.sign:hover {
	background-color: #888888;
	color: #fff;
}
</style>

</head>
<body style="min-width: 400px; background-color: #f3f3f3;">
<form name="f" method="post" action="/user/user_id_search_proc.do" onsubmit="return doSubmit(this);">
<font face='Malgun Gothic' style='line-height: 1.4' />
	<div class="maindiv" align="center">
		<div class="logindiv">
			<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>성명</b>
						</font>
					</div>
					<input type="text" name="user_name" maxlength="20" class="id"
						onkeydown="return doKeyIdPw(event)" placeholder="성명"
						autocomplete="off"/>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>이메일</b>
						</font>
					</div>
					<input type="text" name="email1" maxlength="20" class="email"
						onkeydown="return doKeyIdPw(event)" placeholder="이메일" autocomplete="off"/>
					<div>
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>@</b>
						</font><select name="email2" class="email"
							style="height: 32px; width: 80px">
							<option value="bd"></option>
							<option value="naver.com">naver.com</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</div>
				</div>
				<div align="right">
				<input type="submit" class="sign" value="확인"/>
				</div>
		</div>
	</div>
</form>
</body>
</html>