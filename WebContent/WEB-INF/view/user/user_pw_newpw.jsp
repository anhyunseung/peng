<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");

String SESSION_USER_ID = CmmUtil.nvl((String)session.getAttribute("PW_USER_ID"));
/* session.setAttribute("PW_USER_ID", ""); */

System.out.println("user_id : "+ CmmUtil.nvl((String)session.getAttribute("PW_USER_ID")));
System.out.println("user_id : "+ SESSION_USER_ID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/user/user_pw_newpw.do/../../img/common/icon.ico" type="image/x-icon" />
<title>Let's see the movie! : Lovie - 비밀번호 찾기</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SESSION_USER_ID%>";
	   if (user_id==""){
		      alert("잘못된 접근입니다.");
	      location.href="/user/user_pw_search.do";
		}
	}
   function doSubmit(f) {
      if (f.pwd1.value.length >= 20) {
         alert("비밀번호가 20자를 초과하였습니다.");
         f.pwd1.focus();
         return false;
      }
      if (f.pwd1.value == "") {
         alert("새 비밀번호를 적어주세요.");
         f.pwd1.focus();
         return false;
      }

      if (f.pwd2.value == "") {
         alert("새 비밀번호를 적어주세요.");
         f.pwd2.focus();
         return false;
      }
      if (f.pwd2.value != f.pwd1.value) {
         alert("비밀번호가 일치하지 않습니다.");
         f.pwd1.focus();
         return false;
      }
   }
   function doKeyOnlyNumber(event) {
      event = event || window.event;
      var keyID = (event.which) ? event.which : event.KeyCode;

      if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
            || keyID == 8) {
         return true;
      } else {
         return false;
      }

   }
   function hange(obj){

	    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');

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
	height: 280px;
	padding: 10px 10px;
}
div.logindiv>div>div{
	display: inline-block;
}
.joinfont{
	width:150px;
	padding: 50px 0 0 0;
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
}

.sign:hover {
	background-color: #888888;
	color: #fff;
}
</style>
</head>
<body style="min-width: 400px; background-color: #f3f3f3;" onload="doOnload();">
 <form action="/user/user_pw_confirm.do" name="f" method="post"
      onsubmit="return doSubmit(this);">
<font face='Malgun Gothic' style='line-height: 1.4' />
	<div class="maindiv" align="center">
		<div class="logindiv">
			<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>새 비밀번호</b>
						</font>
					</div>
					<input type="password" name="pwd1" maxlength="20" class="id"
						onkeypress="return doKeyIdPw(event)" placeholder="비밀번호"
						autocomplete="off"  onkeydown="hange(this);"/>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>새 비밀번호 확인</b>
						</font>
					</div>
					<input type="password" name="pwd2" maxlength="20" class="id"
						onkeypress="return doKeyIdPw(event)" placeholder="비밀번호 확인"
						autocomplete="off" style="margin: 30px 0 15px 0;"  onkeydown="hange(this);"/>
				</div>
				<font face='Malgun Gothic' size="3px" style="color: #ff6666;">
					<b>비밀번호는 20자 이하입니다.</b>
				</font>
				<div align="right" style="padding: 30px 0 0 0">
				<input type="submit" class="sign" value="확인"/>
				</div>
				<input type="hidden" name="user_id"
         value="<%=SESSION_USER_ID%>" />
		</div>
	</div>
</form>
</body>
</html>