<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%
	request.setCharacterEncoding("UTF-8");
	String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
	System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
	System.out.println("ss_user_id : " + SESSION_USER_ID);
	String id_over = CmmUtil.nvl((String) session.getAttribute("id_over"));
	String url = CmmUtil.nvl((String) session.getAttribute("url"));
	if(url.isEmpty()){
    	url="/top.do";
    }
	String email_over=CmmUtil.nvl((String) session.getAttribute("email_over"));
	String email_over2=CmmUtil.nvl((String) session.getAttribute("email_over2"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon"
	href="http://localhost:8080/user/user_join2.do/../../img/common/icon.ico"
	type="image/x-icon" />
<title>회원가입 : Lovie</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SESSION_USER_ID%>";
	   var over_id="<%=id_over%>"
		var email_over="<%=email_over%>"
		var email_over2="<%=email_over2%>"
	   if (user_id!=""||over_id==""||email_over==""||email_over2==""){
		      alert("잘못된 접근입니다.");
	      location.href="<%=url%>";

		}

	}

	function doTop() {
		top.location.href = "/top.do";
	}

	function doSubmit(f) {
		if (f.pwd1.value.length >= 20) {
			alert("비밀번호가 20자를 초과했습니다.");
			f.pwd1.focus();
			return false;
		}

		if (f.user_name.value == "") {
			alert("모두 입력을 해주세요.");
			f.user_name.focus();
			return false;
		}
		
		if (f.pwd1.value == "") {
			alert("모두 입력을 해주세요.");
			f.pwd1.focus();
			return false;
		}

		if (f.pwd2.value == "") {
			alert("모두 입력을 해주세요.");
			f.pwd2.focus();
			return false;
		}

		if (f.pwd1.value != f.pwd2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			f.pwd1.focus();
			return false;
		}

		if (f.email1.value == "") {
			alert("모두 입력을 해주세요.");
			f.email1.focus();
			return false;
		}

		if (f.email2.value == "bd") {
			alert("모두 입력을 해주세요.");
			f.email2.focus();
			return false;
		}

		if (f.tel_1.value == "") {
			alert("모두 입력을 해주세요.");
			f.tel_1.focus();
			return false;
		}

		if (f.tel_2.value == "") {
			alert("모두 입력을 해주세요.");
			f.tel_2.focus();
			return false;
		}

		if (f.tel_3.value == "") {
			alert("모두 입력을 해주세요.");
			f.tel_3.focus();
			return false;
		}

		if (f.birthday.value == "") {
			alert("모두 입력을 해주세요.");
			f.birthday.focus();
			return false;
		}

		if (f.birthday.value.length != 6) {
			alert("6자리로 입력해 주세요 \n ( ex.991111 )");
			f.birthday.focus();
			return false;
		}
	}
	function doKeyOnlyNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.KeyCode;

		if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
				|| keyID == 8 || keyID == 37 || keyID == 39 || keyID == 9) {
			return true;
		} else {
			return false;
		}
	}

	function doKeyOnlyWord(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.KeyCode;

		if ((keyID >= 65 && keyID <= 90) || keyID == 8 || keyID == 37
				|| keyID == 39 || keyID == 9 || keyID == 229) {
			return true;
		} else {
			return false;
		}
	}

	function doKeyIdPw(obj) {
		if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >=96 && event.keyCode <=105) || (event.keyCode  >= 65 && keyID <= 90) || event.keyCode ==8 || event.keyCode ==37 || event.keyCode ==39 || event.keyCode ==9 ) { 
		  }else {
		   event.returnValue = false;
	   }
	}
	function dojoin() {
		location.href = "/user/user_join1.do";
	}
	function hange(obj){

	    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');

	}
</script>
<style>
html, body {
	margin: 0;
	word-break: break-all;
	min-hight: 500px;
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
	padding: 200px 0;
	width: 100%;
	height: 100%;
}

div.jointotal>div {
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
	position:relative;
	top:2px;
	height: 90%;
	width:228px;
	background-color:rgba(220,220,220); 
	border:1px solid rgba(150,150,150,0.7);
}
div.joinend{
	height: 99%;
	width:228px;
	background-color:rgba(150,150,150); 
	border:1px solid rgba(40,40,40,0.7);
}

div.joindiv {
	border: 1px solid rgba(180, 180, 180, 0.7);
	background-color: rgba(255, 255, 255, 0.9);
	width: 600px;
	height: 100%;
	padding: 50px 50px;
	box-shadow: 2px 2px 2px 0 rgba(100, 100, 100, 0.4);
}

div.joindiv>div>div {
	display: inline-block;
}

div.joinfont {
	width: 130px;
}

.id:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}

.id {
	width: 290px;
	height: 30px;
	font-size: large;
	padding: 0 10px 0 10px;
	margin: 40px 0 15px 0;
	outline-color: #888888;
	position: relative;
}

.id:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}

.email {
	width: 120px;
	height: 30px;
	font-size: large;
	padding: 0 10px 0 10px;
	margin: 40px 0 15px 0;
	outline-color: #888888;
	position: relative;
}

.email:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}
.tel {
	width: 70px;
	height: 30px;
	font-size: large;
	padding: 0 10px 0 10px;
	margin: 40px 0 15px 0;
	outline-color: #888888;
	position: relative;
}

.tel:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}

.sign {
	width: 130px;
	background-color: #ffffff;
	height: 44px;
	text-align: center;
	text-decoration: none;
	color:#195026;
	border: 2px solid #195026;
	font-size: 16px;
	display: inline-block;
	transition: all 0.2s ease-in-out;
	position: relative;
	overflow: hidden;
	transition: all 0.2s ease-in-out;
	position: relative;
	top: 1px;
	margin: 30px 40px 0 0;
	outline:0;
	cursor: pointer;
}

.sign:hover {
	background-color: #195026;
	color: #fff;
}

.back {
	width: 130px;
	background-color: #ffffff;
	height: 44px;
	text-align: center;
	text-decoration: none;
	color: #924040;
	border: 2px solid #924040;
	font-size: 16px;
	display: inline-block;
	transition: all 0.2s ease-in-out;
	position: relative;
	overflow: hidden;
	transition: all 0.2s ease-in-out;
	position: relative;
	outline:0;
	top: 1px;
	margin: 30px 0 0 0;
	cursor: pointer;
}

.back:hover {
	background-color:#924040;
	color: #fff;
}
</style>
</head>
<body onload="doOnload();"
	style="min-width: 800px; background-color: #f3f3f3;">
	<form name="f" method="post" action="/user/user_join_save.do"
		onsubmit="return doSubmit(this);" style="height: 100%;">
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
		<font face='Malgun Gothic' size="4px"
						style="color: rgba(150,150,150)"> <b>이메일 중복확인</b>
					</font> </div></div>
		<div class="joinend">
		<div style="position: relative; top:35px;">
		<font face='Malgun Gothic' size="5px"
						style="color: rgba(40,40,40)"> <b>회원가입</b>
					</font></div></div>
	</div>
			<div class="joindiv">
				<a href="/top.do">
			<img src="../img/user/loginlogo.png">
			</a>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>성명</b>
						</font>
					</div>
					<input type="text" name="user_name" maxlength="20" class="id"
						onkeydown="return doKeyOnlyWord(event)" placeholder="성명"
						autocomplete="off" />
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>아이디</b>
						</font>
					</div>
					<input type="text" name="user_id" maxlength="20" class="id"
						onkeydown="return doKeyIdPw(event)" placeholder="아이디"
						autocomplete="off" disabled="disabled" value="<%=id_over%>" />
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>비밀번호</b>
						</font>
					</div>
					<input type="password" name="pwd1" maxlength="20" class="id"
						onkeypress="return doKeyIdPw(event)" placeholder="비밀번호"
						autocomplete="off"  onkeydown="hange(this);"/>
				</div>
				<font face='Malgun Gothic' size="3px" style="color: #ff6666;">
					<b>비밀번호는 20자 이하입니다.</b>
				</font>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>비밀번호 확인</b>
						</font>
					</div>
					<input type="password" name="pwd2" maxlength="20" class="id"
						onkeypress="return doKeyIdPw(event)" placeholder="비밀번호 확인"
						autocomplete="off" style="margin: 30px 0 15px 0;"  onkeydown="hange(this);"/>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>이메일</b>
						</font>
					</div>
					<input type="text" name="email1" maxlength="20" class="email"
						onkeydown="return doKeyIdPw(event)" placeholder="이메일" autocomplete="off" 
						disabled="disabled" value="<%=email_over%>"/>
					<div>
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>@</b>
						</font> <select name="email2" class="email"
							style="height: 34px; width: 140px" disabled="disabled">
							<option value="<%=email_over2 %>"><%=email_over2 %></option>
							<option value="naver.com">naver.com</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</div>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>전화번호</b>
						</font>
					</div>
					<div>
						<select name="tel_1" class="tel" style="height: 34px; width: 87px">
							<option value=""></option>
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="017">017</option>
						</select> <font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>-</b>
						</font>
					</div>
					<input type="text" name="tel_2" maxlength="4" class="tel"
						onkeydown="return doKeyOnlyNumber(event)" placeholder="앞자리"
						autocomplete="off" />
					<div>
					<font face='Malgun Gothic' size="4px" style="color: #777777;">
						<b>-</b>
					</font> <input type="text" name="tel_3" maxlength="4" class="tel"
						onkeydown="return doKeyOnlyNumber(event)" placeholder="뒷자리" autocomplete="off" />
 				</div>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>생년월일</b>
						</font>
					</div>
					<input type="text" name="birthday" maxlength="6" class="id"
						onkeydown="return doKeyOnlyNumber(event)" placeholder="생년월일"
						autocomplete="off" />
				</div>
				<input type="submit" class="sign" value="가입완료"/>
				<input type="button" class="back" onclick="dojoin();" value="돌아가기"/>
			</div>
		</div>
	</form>
</body>
</html>