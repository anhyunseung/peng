<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%
String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
String url=CmmUtil.nvl((String)session.getAttribute("url"));
if(url.isEmpty()){
	url="/top.do";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon"
	href="http://localhost:8080/user/user_login.do/../../img/common/icon.ico"
	type="image/x-icon" />
<title>로그인 : Lovie</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SESSION_USER_ID%>";
	   
	   if (user_id!=""){
		      alert("로그아웃을 해주시기 바랍니다.");
	      location.href="<%=url%>";
	      
	   }
	   
	}
</script>
<style type="text/css">
html, body {
	margin: 0;
	height: 100%;
	word-break: break-all;
}


div.maindiv {
	padding: 200px 0 200px 0;
	width: 100%;
}

div.logindiv {
	box-shadow: 2px 2px 2px 0 rgba(100, 100, 100, 0.4);
	background-color: rgba(255,255,255,0.9);
	width: 380px;
	height: 60px;
	padding: 50px 50px;
}
.id:-webkit-autofill {
	border: 1px solid #888;
	-webkit-box-shadow: inset 0 0 0px 9999px white;
}
.id{
	width: 356px;
	height: 40px;
	font-size: large;
	padding: 0 10px 0 10px;
	margin:0 0 15px 0;
	outline-color: #888888;
}
.pw{
	width: 356px;
	height: 40px;
	font-size: large;
	padding: 0 10px 0 10px;
	margin:0 0 15px 0;
	outline-color: #888888;
}
.outbutton{
	margin: 0;
	background-color: rgba(0,0,0,0);
	border: 0;
	outline:0;
	position: relative;
	left: -6px
}
.idf{
	width:170px;
	height:35px;
	text-align: center;
	text-decoration: none;
	color:#7d80af;
	border: 2px solid #7d80af;
	font-size: 16px;
	display: inline-block;
	transition: all 0.2s ease-in-out;
	position: relative;
	overflow: hidden;
	transition: all 0.2s ease-in-out;
}
.idf:hover {
	background-color: #7d80af;
	color: #fff;
}
.pwf{
	width:170px;
	height:35px;
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
}
.pwf:hover {
	background-color: #924040;
	color: #fff;
}

/* 회원가입 버튼 시작 */
.button2 {
  width:376px;
  height:44px;
  text-align: center;
  text-decoration: none;
  color:#195026;
  border: 2px solid #195026;
  font-size: 24px;
  display: inline-block;
  transition: all 0.2s ease-in-out;
  position: relative;
  overflow: hidden;
}
.button2:before {
  content: "";
  background-image:url("../img/user/joinbt.png");
  height: 500px;
  width: 380px;
  display: block;
  position: absolute;
  bottom: -505px;
  left:1px;
  -webkit-transform:translateY(0);
          transform:translateY(0);
  transition: none;
  white-space: pre;
}
.button2:hover {
  background-color: #195026;
  color: #fff;
}
.button2:hover:before {
  -webkit-transform:translateY(-24.5em);
          transform:translateY(-24.5em);
          transition: all 3s ease-in-out;
}
/* 회원가입 버튼 종료 */
</style>
</head>
<body onload="doOnload();" style="min-width: 500px; background-color: #f3f3f3;">
<form name="f" method="post" action="/user/user_login_proc.do" onsubmit="return doSubmit(this);">
	<font face='Malgun Gothic' style='line-height: 1.4' />
	<div class="maindiv" align="center">
		<div class="logindiv">
		<a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('230526166a00e868a586f374a4f60ddb');
    // 카카오 로그인 버튼을 생성합니다.
   Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        // 로그인 성공시, API를 호출합니다.
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(res) {
            //alert(res.properties.nickname+'님 환영합니다.');
            location.href="/top.do"+res.properties.nickname;
          },
          fail: function(error) {
            alert(JSON.stringify(error));
          }
        });
      },
      fail: function(err) {
        alert(JSON.stringify(err));
      }
    });
  //]]>
</script>
		</div>
	</div>
</form>
</body>
</html>