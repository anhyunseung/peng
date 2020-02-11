<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%@ page import="poly.dto.UserDTO" %>
<%
UserDTO rDTO = (UserDTO)request.getAttribute("rDTO");
String SESSION_USER_ID =CmmUtil.nvl((String) session.getAttribute("USER_ID"));
String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
System.out.println("ss_user_id : " + SESSION_USER_ID);
String url=CmmUtil.nvl((String)session.getAttribute("url"));
if(url.isEmpty()){
	url="/top.do";
}

//공지글 정보를 못불러왔다면, 객체 생성
if (rDTO==null){
 rDTO = new UserDTO();

}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/user/userEditInfo.do/../../img/common/icon.ico" type="image/x-icon" />
<title>내 정보 : Lovie</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SESSION_USER_ID%>";
	   var user_id2="<%=CmmUtil.nvl(rDTO.getUser_id())%>";
	   if (user_id!=user_id2){
		      alert("잘못된 접근입니다.");
	      location.href="<%=url%>";
	      
	   }
	   
	}
function doSubmit(a) {
   if(f.pwd1.value.length >= 20){
      alert("비밀번호가 20자를 초과했습니다.");
      f.pwd1.focus();
      return false;
   }
   
   if(f.user_name.value == ""){
      alert("모두 입력을 해주세요.");
      f.user_name.focus();
      return false;
   }
   
   if(f.pwd1.value == ""){
      alert("모두 입력을 해주세요.");
      f.pwd1.focus();
      return false;
   }
   
   if(f.pwd2.value == ""){
      alert("모두 입력을 해주세요.");
      f.pwd2.focus();
      return false;
   }
   
   if(f.pwd1.value != f.pwd2.value){
      alert("비밀번호가 일치하지 않습니다.");
      f.pwd1.focus();
      return false;
   }

   if(f.email1.value == ""){
      alert("모두 입력을 해주세요.");
      f.email1.focus();
      return false;
   }
   
   if(f.email2.value == "bd"){
      alert("모두 입력을 해주세요.");
      f.email2.focus();
      return false;
   }
   
   if(f.tel_1.value == ""){
      alert("모두 입력을 해주세요.");
      f.tel_1.focus();
      return false;
   }
   
   if(f.tel_2.value == ""){
      alert("모두 입력을 해주세요.");
      f.tel_2.focus();
      return false;
   }
   
   if(f.tel_3.value == ""){
	   
      alert("모두 입력을 해주세요.");
      f.tel_3.focus();
      return false;
   }
   
   if(f.birthday.value == ""){
      alert("모두 입력을 해주세요.");
      f.birthday.focus();
      return false;
   }
   
   if(f.birthday.value.length != 6){
      alert("6자리로 입력해 주세요 \n ( ex.190101 )");
      f.birthday.focus();
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

function doKeyIdPw(obj) {
	if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >=96 && event.keyCode <=105) || (event.keyCode  >= 65 && keyID <= 90) || event.keyCode ==8 || event.keyCode ==37 || event.keyCode ==39 || event.keyCode ==9 ) { 
	  }else {
	   event.returnValue = false;
   }
}

function doInfo(no){
    location.href="/user/userInfo.do?user_no=<%=CmmUtil.nvl(rDTO.getUser_no())%>";
}
function hange(obj){

    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');

}
</script>
<style>
html, body {
	margin: 0;
	height: 100%;min-height: 1500px;
	word-break:break-all;
}

a.line:hover {
	color: black;
	text-decoration: underline;
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

a.tag {
	color: #6b7177;
}

a.tag:hover {
	color: black;
	text-decoration: underline;
}

body {
	margin: 0;
}

.navbar {
	background-image: url("../img/common/headerbg.png");
	margin: 0;
	padding: 0;
	position: fixed;
	width: 30000px;
	z-index: 2;
}

.navbar>li {
	display: inline-block;
}

img.logo {
	position: relative;
	top: 10px
}

.navbar>li>a {
	display: block;
	text-decoration: none;
	padding: 0px 20px;
}

.navbar>li>a#nologo {
	display: block;
	text-decoration: none;
	padding: 20px 40px;
	color: gray;
}

.navbar>li>a#nologo:hover {
	color: #ffffff;
}

div.login {
	position: fixed;
	right: 0%;
	z-index: 3;
}

div.blank {
	width: 100%;
	height: 64px;
	border-color: black;
}
/* 여기까지 상단  */
div.leftmenu {
	background-color: rgba(184, 184, 184, 0.9);
	width: 27%;
	height: 100%;
	box-shadow: 2px 2px 3px 0 rgba(100, 100, 100, 0.6);
	min-width: 337px;
	float: left;
}

div.leftmenu2 {
	margin: 0;
	padding: 100px 0 162px 0;
	width: 300px;
	background-image: url("../img/total/listbg.jpg");
	height: 600px;
	background-repeat: no-repeat;
}

div.loginmenu {
	margin: 0 30px 100px 0px;
	padding: 0 0;
	width: 270px;
	height: 160px;
	background-color: rgb(255, 255, 255);
	box-shadow: 2px 0 3px 0 rgba(100, 100, 100, 0.6);
}

a.user {
	color: gray;
}

a.user:hover {
	color: #494949;
	text-decoration: none;
}

div.listmenu {
	margin: 0 0;
	padding: 0 0;
	width: 270px;
	height: 285px;
}
/* 여기까지 왼쪽 정렬  */
div.rightmenu {
	position: relative;
	top: 0px;
	margin: 0px 0px 0px 0px;
	background-color: #f3f3f3;
	width: 72.3%;
	height: 100%;
	float: right;
}

div.writemenu {
	margin: 162px 0 162px 160px;
	padding: 10px 10px;
	background-color: rgb(255, 255, 255);
	width: 700px;
	box-shadow: 1px 1px 2px 0 rgba(100, 100, 100, 0.6);
}

div.tableborder {
	border: 1px solid #dddddd;
}
div.joinfont {
	width: 130px;
}
div.tablemiddle {
	width:678px;
	padding: 50px 10px 30px 10px;
}
div.tablemiddle>div>div>div {
	display: inline-block;
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
	width: 118px;
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
	width: 68px;
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
div.tabledown{
	padding:0 0 50px 0;
}
/* 여기까지 오른쪽 정렬  */
</style>
</head>
<body onload="doOnload();"
	style="min-width: 1250px; background-color: #f3f3f3;">
	<form name="f" method="post" action="/user/userUpdate.do" style="height:100%;" onsubmit="return doSubmit(this);">
	<font face='Malgun Gothic' style='line-height: 1.4' />
	<ul class="navbar">
		<li><a href="/top.do"> <img class="logo"
				src="../img/common/Logo.png" />
		</a></li>
		<li><a id="nologo" href="/notice/NoticeList.do">공지사항</a></li>
		<li><a id="nologo" href="/newmovie/newmovieList.do">최신영화</a></li>
		<li><a id="nologo" href="/upmovie/upmovieList.do">추천영화</a></li>
		<li><a id="nologo" href="/bbm/bbmList.do">자유게시판</a></li>
		<li><a id="nologo" href="/inquiry/inquiryList.do">문의</a></li>
	</ul>
	<div class="login">
		<%
			if (SESSION_USER_ID.equals("")) {
		%>
		<a href="/user/user_login.do"><img src="../img/top/uplogin.png"
			onmouseover="this.src='../img/top/uplogin2.png'"
			onmouseout="this.src='../img/top/uplogin.png'"></a>
		<%
			} else {
		%>
		<a href="/user/user_logout.do"><img src="../img/top/uplogout.png"
			onmouseover="this.src='../img/top/uplogout2.png'"
			onmouseout="this.src='../img/top/uplogout.png'"></a>
		<%
			}
		%>
	</div>
	<div class="blank"></div>
	<div style="height: 100%">
	<div align="right" class="leftmenu">
		<div class="leftmenu2">
			<div class="loginmenu">
				<div align="center" style="position: relative; top:25px;">
					<%
						if (SESSION_USER_ID.equals("")) {
					%>
							<a href="/user/user_login.do"> <img
								src="../img/total/leftlogin.png"
								onmouseover="this.src='../img/total/leftlogin2.png'"
								onmouseout="this.src='../img/total/leftlogin.png'">
						</a>
						<div style="width:260px;height: 1px; background-color: #888888;
						position: relative; top:25px;"></div>
							<div style="position: relative; top:35px;">
								<span style="padding: 10px 6px;"> <a class="tag"
									href="/user/user_join.do"> <font face='Malgun Gothic'
										size="2px"> 회원가입 </font>
								</a>
								</span> <span style="padding: 10px 0px;"> <font
									face='Malgun Gothic' size="2px" style="color: #6b7177;">
										| </font>
								</span> <span style="padding: 10px 6px;"> <a class="tag"
									href="/user/user_id_search.do"
									onClick="window.open('/user/user_id_search.do','아이디 찾기','width=470, height=226, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;">
										<font face='Malgun Gothic' size="2px"> 아이디찾기 </font>
								</a>
								</span> <span style="padding: 10px 0px;"> <font
									face='Malgun Gothic' size="2px" style="color: #6b7177;">
										| </font>
								</span> <span style="padding: 10px 6px;"> <a class="tag"
									href="/user/user_pw_search.do"
									onClick="window.open('/user/user_pw_search.do','비밀번호 찾기','width=470, height=366, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;">
										<font face='Malgun Gothic' size="2px"> 비밀번호 찾기 </font>
								</a>
								</span>
							</div>
					<%
						} else if (SESSION_USER_ID.equals("admin")) {
					%>
							<font face='Malgun Gothic' size="10px"> <a
								href="/user/manageList.do" class="user"> <%=SESSION_USER_ID%>
							</a>
						</font>
						<div style="width:260px;height: 1px; background-color: #888888;
						position: relative; top:25px;"></div>
							<div style="position: relative; top:35px;">
								<span style="padding: 10px 6px;"> <a class="tag"
									href="/user/manageList.do"> <font face='Malgun Gothic'
										size="2px"> 회원관리 </font>
								</a>
								</span> <span style="padding: 10px 0px;"> <font
									face='Malgun Gothic' size="2px" style="color: #6b7177;">
										| </font>
								</span> <span style="padding: 10px 6px;"> <a class="tag"
									href="/user/userInfo.do"> <font face='Malgun Gothic'
										size="2px"> 내 정보 </font>
								</a>
								</span> <span style="padding: 10px 0px;"> <font
									face='Malgun Gothic' size="2px" style="color: #6b7177;">
										| </font>
								</span> <span style="padding: 10px 6px;"> <a class="tag"
									href="/user/user_logout.do"> <font face='Malgun Gothic'
										size="2px"> 로그아웃 </font>
								</a>
								</span>
							</div>
					<%
						} else {
					%>
							<font face='Malgun Gothic' size="10px"> <a
								href="/user/userInfo.do" class="user"> <%=SESSION_USER_ID%>
							</a>
						</font>
						<div style="width:260px;height: 1px; background-color: #888888;
						position: relative; top:25px;"></div>
							<div style="position: relative; top:35px;">
								<span style="padding: 10px 6px;"> <a class="tag"
									href="/user/userInfo.do"> <font face='Malgun Gothic'
										size="2px"> 내 정보</font>
								</a>
								</span> <span style="padding: 10px 0px;"> <font
									face='Malgun Gothic' size="2px" style="color: #6b7177;">
										| </font>
								</span> <span style="padding: 10px 6px;"> <a class="tag"
									href="/user/user_logout.do"> <font face='Malgun Gothic'
										size="2px"> 로그아웃 </font>
								</a>
								</span>
							</div>
					<%
						}
					%>
				</div>
			</div>
			<div class="listmenu">
				<font face='Malgun Gothic' size="6px"
					style="color: rgba(85, 85, 85, 0.7); margin: 0 10px 0 0;"> <b>게시판</b></font>
				<a href="/notice/NoticeList.do"> <img
					src="../img/total/listnotice.jpg"
					onmouseover="this.src='../img/total/listnotice2.jpg'"
					onmouseout="this.src='../img/total/listnotice.jpg'">
				</a> <a href="/newmovie/newmovieList.do"> <img
					src="../img/total/listnewmo.jpg"
					onmouseover="this.src='../img/total/listnewmo2.jpg'"
					onmouseout="this.src='../img/total/listnewmo.jpg'">
				</a> <a href="/upmovie/upmovieList.do"> <img
					src="../img/total/listupmo.jpg"
					onmouseover="this.src='../img/total/listupmo2.jpg'"
					onmouseout="this.src='../img/total/listupmo.jpg'">
				</a> <a href="/bbm/bbmList.do"> <img src="../img/total/listbbm.jpg"
					onmouseover="this.src='../img/total/listbbm2.jpg'"
					onmouseout="this.src='../img/total/listbbm.jpg'">
				</a> <a href="/inquiry/inquiryList.do"> <img
					src="../img/total/listinq.jpg"
					onmouseover="this.src='../img/total/listinq2.jpg'"
					onmouseout="this.src='../img/total/listinq.jpg'">
				</a>
			</div>
		</div>
	</div>
	<div class="rightmenu" align="left">
		<div class="writemenu">
			<div><font face='Malgun Gothic' size="6px"
						style="color: #555555;"> <b>내 정보 수정</b>
					</font></div>
					<div style="height:5px"></div>
				<div style="height:3px;background-color: #dddddd;"></div>
					<div style="height:10px"></div>
			<div class="tableborder">
				<div class="tablemiddle" align="center">
				<div>
					<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>성명</b>
						</font>
					</div>
					<input type="text" name="user_name" maxlength="20" class="id"
						onkeydown="return doKeyOnlyWord(event)" placeholder="성명"
						autocomplete="off" value="<%=CmmUtil.nvl(rDTO.getUser_name())%>" />
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>아이디</b>
						</font>
					</div>
					<input type="text" name="user_id" maxlength="20" class="id"
						onkeydown="return doKeyIdPw(event)" placeholder="아이디"
						autocomplete="off" disabled="disabled" value="<%=CmmUtil.nvl(rDTO.getUser_id())%>" />
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
					<input type="text" name="disemail1" maxlength="20" class="email"
						onkeydown="return doKeyIdPw(event)" placeholder="이메일" autocomplete="off"
						value="<%=CmmUtil.nvl(rDTO.getEmail1())%>" disabled="disabled"/>
					<div>
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>@</b>
						</font><select name="disemail2" class="email"
							style="height: 34px; width: 142px" disabled="disabled">
							<option value="<%=CmmUtil.nvl(rDTO.getEmail2()) %>"><%=CmmUtil.nvl(rDTO.getEmail2())%>
							</option>
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
						<select name="tel_1" class="tel" style="height: 34px; width: 92px">
							<option value=""></option>
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="017">017</option>
						</select>
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>-</b>
						</font>
					</div>
					<input type="text" name="tel_2" maxlength="4" class="tel"
						onkeydown="return doKeyOnlyNumber(event)" placeholder="앞자리"
						autocomplete="off" value="<%=CmmUtil.nvl(rDTO.getTel_2())%>"/>
					<div>
					<font face='Malgun Gothic' size="4px" style="color: #777777;">
						<b>-</b>
					</font> <input type="text" name="tel_3" maxlength="4" class="tel"
						onkeydown="return doKeyOnlyNumber(event)" placeholder="뒷자리" 
						autocomplete="off" value="<%=CmmUtil.nvl(rDTO.getTel_3())%>"/>
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
						autocomplete="off" value="<%=CmmUtil.nvl(rDTO.getBirthday())%>"/>
				</div>
				</div>
				</div>
				<div class="tabledown" align="center">
				<button  type="button" onclick="doSubmit(this);" style="background-color: rgba(0,0,0,0); 
				border: 0; outline:0; width:64px; height: 29px; margin: 0 6px 0 0;">
				<img style="cursor: pointer;" src="../img/button/sign.png"
							onmouseover="this.src='../img/button/sign2.png'"
							onmouseout="this.src='../img/button/sign.png'" />
				</button>
				<a style="cursor: pointer;" onclick="doInfo();">
				<img src="../img/button/cc.png"
							onmouseover="this.src='../img/button/cc2.png'"
							onmouseout="this.src='../img/button/cc.png'" />
				</a>
				</div>
			</div>
		</div>
	</div>
	</div>
	<input type="hidden" name="user_no" value="<%=CmmUtil.nvl(rDTO.getUser_no())%>"/>
	<input type="hidden" name="user_id" value="<%=CmmUtil.nvl(rDTO.getUser_id())%>"/>
	<input type="hidden" name="email1" value="<%=CmmUtil.nvl(rDTO.getEmail1())%>"/>
	<input type="hidden" name="email2" value="<%=CmmUtil.nvl(rDTO.getEmail2())%>"/>
	</form>
</body>
</html>