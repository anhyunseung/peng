<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String SS_USER_ID = CmmUtil.nvl((String)session.getAttribute("USER_ID"));
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
<link rel="shortcut icon" href="http://localhost:8080/user/manage_id_confirm.do/../../img/common/icon.ico" type="image/x-icon" />
<title>Let's see the movie! : Lovie - 아이디 변경</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SS_USER_ID%>";
	   if (user_id!="admin"){
		      alert("잘못된 접근입니다.");
	      location.href="<%=url%>";

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
.joinfont{
	width:70px;
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
<body onload="doOnload();" style="min-width: 400px; background-color: #f3f3f3;">
<font face='Malgun Gothic' style='line-height: 1.4' />
	<div class="maindiv" align="center">
		<div class="logindiv">
					<div style="padding: 55px 0 30px 0;">
						<font face='Malgun Gothic' size="5px" style="color: #777777;">
							<b>아이디가 변경되었습니다.</b>
						</font>
					</div>
				<div align="right">
					<input type="submit" class="sign" onclick="Close_Event()" value="확인"/>
				</div>
		</div>
	</div>
</body>
</html>