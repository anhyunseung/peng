<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%@ page import="poly.dto.UserDTO" %>
<%
String SESSION_USER_ID =CmmUtil.nvl((String) session.getAttribute("USER_ID"));
String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
System.out.println("ss_user_id : " + SESSION_USER_ID);
String url=CmmUtil.nvl((String)session.getAttribute("url"));
if(url.isEmpty()){
	url="/top.do";
}

UserDTO rDTO = (UserDTO)request.getAttribute("rDTO");

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
<link rel="shortcut icon" href="http://localhost:8080/user/manageInfo.do/../../img/common/icon.ico" type="image/x-icon" />
<title><%=SESSION_USER_NO%> - 회원관리 : Lovie</title>
<script type="text/javascript">
function doOnload(){
	   var user_id = "<%=SESSION_USER_ID%>";
	   
	   if (user_id!="admin"){
		      alert("잘못된 접근입니다.");
	      location.href="<%=url%>";
	      
	   }
	   
	}
function doDelete(){
    if(confirm("정말로 삭제하시겠습니까?")){
       location.href="/user/manageDelete.do?user_no=<%=CmmUtil.nvl(rDTO.getUser_no())%>";
 }
}
function doList(){
 location.href="/user/manageList.do";
}
function doIdchange(){
	window.open('/user/manage_id_change.do?user_id=<%=CmmUtil.nvl(rDTO.getUser_id())%>','아이디 변경','width=470, height=226, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;
	}
function doEmailchange(){
	window.open('/user/manage_email_change.do?user_id=<%=CmmUtil.nvl(rDTO.getUser_id())%>','이메일 변경','width=470, height=226, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;
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
.id_change {
	width: 80px;
	background-color: #fff;
	height: 34px;
	text-align: center;
	text-decoration: none;
	color: #888888;
	border: 1px solid #888888;
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

.id_change:hover {
	background-color:#888888;
	color: #fff;
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
	width: 75px;
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
						style="color: #555555;"> <b>회원관리</b>
					</font></div>
					<div align="right">
					 <a href="manageList.do"> <img src="../img/button/list.png"
							onmouseover="this.src='../img/button/list2.png'"
							onmouseout="this.src='../img/button/list.png'" />
					</a></div>
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
						autocomplete="off" disabled="disabled" value="<%=CmmUtil.nvl(rDTO.getUser_name())%>" />
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>아이디</b>
						</font>
					</div>
					<input type="text" name="user_id" maxlength="20" class="id" style="width:204px"
						onkeydown="return doKeyIdPw(event)" placeholder="아이디"
						autocomplete="off" disabled="disabled" value="<%=CmmUtil.nvl(rDTO.getUser_id())%>" />
						<input type="button" class="id_change" onclick="doIdchange();" value="변경"/>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>이메일</b>
						</font>
					</div>
					<input type="text" name="email1" maxlength="20" class="email"
						onkeydown="return doKeyIdPw(event)" disabled="disabled" placeholder="이메일" autocomplete="off"
						value="<%=CmmUtil.nvl(rDTO.getEmail1())%>" />
					<div>
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>@</b>
						</font>
						<select name="email2" class="email"
							style="height: 34px; width: 99px" disabled="disabled">
							<option value="<%=CmmUtil.nvl(rDTO.getEmail2()) %>"><%=CmmUtil.nvl(rDTO.getEmail2())%>
							</option>
							<option value="naver.com">naver.com</option>
							<option value="nate.com">nate.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						<input type="button" class="id_change" onclick="doEmailchange();" value="변경"/>
					</div>
				</div>
				<div>
					<div class="joinfont">
						<font face='Malgun Gothic' size="4px" style="color: #777777;">
							<b>전화번호</b>
						</font>
					</div>
					<div>
						<select name="tel_1" class="tel" style="height: 34px; width: 92px" disabled="disabled">
							<option value="<%=CmmUtil.nvl(rDTO.getTel_1())%>">
							<%=CmmUtil.nvl(rDTO.getTel_1())%></option>
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
						autocomplete="off" disabled="disabled" value="<%=CmmUtil.nvl(rDTO.getTel_2())%>"/>
					<div>
					<font face='Malgun Gothic' size="4px" style="color: #777777;">
						<b>-</b>
					</font> <input type="text" name="tel_3" maxlength="4" class="tel"
						onkeydown="return doKeyOnlyNumber(event)" placeholder="뒷자리" 
						autocomplete="off" disabled="disabled" value="<%=CmmUtil.nvl(rDTO.getTel_3())%>"/>
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
						autocomplete="off" disabled="disabled" value="<%=CmmUtil.nvl(rDTO.getBirthday())%>"/>
				</div>
				</div>
				</div>
				<div class="tabledown" align="center">
				<a style="cursor: pointer;" onclick="doDelete();">
				<img src="../img/button/del.png"
							onmouseover="this.src='../img/button/del2.png'"
							onmouseout="this.src='../img/button/del.png'" />
				</a>
				<a style="cursor: pointer;" onclick="doList();">
				<img src="../img/button/sign.png"
							onmouseover="this.src='../img/button/sign2.png'"
							onmouseout="this.src='../img/button/sign.png'" />
				</a>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
