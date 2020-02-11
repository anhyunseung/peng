<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%
request.setCharacterEncoding("UTF-8");
String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID")); //아이디
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/bbm/bbmReg.do/../../img/common/icon.ico" type="image/x-icon" />
<title>자유게시판 : Lovie</title>
<script type="text/javascript">
function doOnload(){
   var user_id = "<%=SESSION_USER_ID%>";
   
   if (user_id==""){
	      alert("로그인된 사용자만 글을 쓸 수 있습니다.");
      location.href="/user/user_login.do";
      
   }
   
}

//로그인 여부 체크

   function doList(){
	   if(confirm("글 작성을 취소하시겠습니까?")){
	    location.href="/bbm/bbmList.do";
	   }
	}
</script>
<style>
html, body {
	margin: 0;
	height: 100%;
	min-height: 1500px;
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

div.tableup {
	background-color: #eeeeee;
	padding: 14px 50px 10px 50px;
	border-bottom: 1px solid #dddddd;
	vertical-align: middle;
}

div.tableup >div{
	display: inline-block;
}

div.tableleft {
	width: 49.5%;
}

div.tableright {
	width: 49.5%;
}

div.tablemiddle {
	padding: 10px 10px;
}

div.tabledown {
	background-color: #eeeeee;
	padding: 8px 8px 1px 8px;
	border-bottom: 1px solid #dddddd;	
}
input{
	outline-color: #888888;
}
textarea{
	outline-color: #888888;
}
div.paging1>div>div {
	display: inline-block;
}

div.comaliggn>div {
	display: inline-block;
}

div.paging>div {
	display: inline-block;
}

div.linebox {
	width: 25px;
	height: 25px;
	background-color: #dddddd;
	vertical-align: bottom;
}

div.linebox2 {
	width: 25px;
	height: 25px;
	background-color: #white;
	vertical-align: bottom;
}

div.linebox3 {
	width: 25px;
	height: 25px;
	background-color: #111111;
	vertical-align: bottom;
}

a.linetag:hover {
	text-decoration: underline;
	color: white;
}

a.linetag2:hover {
	text-decoration: underline;
	color: #555555;
}
/* 여기까지 오른쪽 정렬  */
</style>
</head>
<body onload="doOnload();"
	style="min-width: 1250px; background-color: #f3f3f3;">
	<form name="f" method="post" action="/bbm/bbmInsert.do" style="height:100%;">
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
					%><a href="/user/user_login.do"> <img
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
				</a> <a href="/bbm/bbmList.do"> <img src="../img/total/listbbm2.jpg">
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
						style="color: #555555;"> <b>자유게시판</b>
					</font></div>
					<div align="right">
					 <a href="bbmList.do"> <img src="../img/button/list.png"
							onmouseover="this.src='../img/button/list2.png'"
							onmouseout="this.src='../img/button/list.png'" />
					</a>
					</div>
					<div style="height:5px"></div>
				<div style="height:3px;background-color: #dddddd;"></div>
					<div style="height:10px"></div>
			<div class="tableborder">
				<div class="tableup">
				<div >
				<font size="4px"> <b>제목</b>
					</font>
				</div>
				<div style="position:relative; padding: 0 0 0 50px; bottom: 2px;">
				
					<input type="text" autocomplete="off" name="title" maxlength="40"
               style="width: 500px; height: 24px;" />
				</div>
				</div>
				<div class="tablemiddle">
				<textarea name="contents"
                  style="width:673px; height:600px; resize: none;"></textarea>
				</div>
				<div class="tabledown" align="right">
				<button  type="button" onclick="submitContents(this);" style="background-color: rgba(0,0,0,0); 
				border: 0; outline:0; width:64px; height: 29px; margin: 0 6px 0 0;">
				<img style="cursor: pointer;" src="../img/button/sign.png"
							onmouseover="this.src='../img/button/sign2.png'"
							onmouseout="this.src='../img/button/sign.png'" />
				</button>
				<a style="cursor: pointer;" onclick="doList();">
				<img src="../img/button/cc.png"
							onmouseover="this.src='../img/button/cc2.png'"
							onmouseout="this.src='../img/button/cc.png'" />
				</a>
				</div>
			</div>
		</div>
	</div>
	</div>
	</form>
</body>
<script type="text/javascript">
function submitContents(elClickedObj) {
	if (f.title.value == "") {
	      alert("제목을 입력하시기 바랍니다.");
	      f.title.focus();
	      return false;
	   }
	   if(f.title.value.length > 45){
	      alert("최대 45자까지 입력 가능합니다.");
	      f.title.focus();
	      return false;
	   }
	 if(f.contents.value == ""){
		 alert("내용을 입력하시기 바랍니다.");
		 f.contents.focus();
	      return false;
	 }
	 if (f.contents.value.length > 20000) {
	      alert("최대 20000자까지 입력 가능합니다.");
	      f.contents.focus();
	      return false;
	   }
	elClickedObj.form.submit();
}
</script>
</html>