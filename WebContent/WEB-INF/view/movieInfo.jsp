<%@ page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	session.setAttribute("url", "/movieInfo.do?moviecode="+CmmUtil.nvl((String) session.getAttribute("moviecodeI")));
	String SESSION_USER_ID =CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
	String imgsrc = (String)request.getAttribute("imgI");
	String moviename = (String)request.getAttribute("nameI");
	String story = (String)request.getAttribute("storyI");
	String genre = (String)request.getAttribute("genreI");
	String videoL1=(String)request.getAttribute("videoL1");
	String videoL2=(String)request.getAttribute("videoL2");
	System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
	System.out.println("ss_user_id : " + SESSION_USER_ID);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/movieInfo.do/../img/common/icon.ico" type="image/x-icon" />
<title><%=moviename %> - 영화소개 : Lovie</title>
<style>
html, body {
	margin: 0;
	height: 100%;
	min-height: 1700px;
	word-break: break-all;
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
	float: left;
	min-width: 337px;
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
	margin: 162px 0 100px 160px;
	padding: 10px 10px;
	background-color: rgb(255, 255, 255);
	width: 700px;
	box-shadow: 1px 1px 2px 0 rgba(100, 100, 100, 0.6);
}

div.writemenu>div>div>div {
	display: inline-block;
}
div.tableborder {
	border: 1px solid #dddddd;
	padding: 30px 10px 10px 10px;
}
.poster{
	border: 10px ridge rgba(102, 51, 0, 0.4);
}
.poster:hover{
	-webkit-transform: scale(1.1); /*  크롬 */
	-moz-transform: scale(1.1); /* FireFox */
	-o-transform: scale(1.1); /* Opera */
	transform: scale(1.1);
	transition: transform .5s;
	-o-transition: transform .5s;
	-moz-transition: transform .5s;
	-webkit-transition: transform .5s;
}
.youtube{
	color: #888888;
	cursor: pointer;
}
.youtube:hover{
	color: #333333;
}
/* 여기까지 오른쪽 정렬  */
</style>
</head>
<body style="min-width: 1250px; background-color: #f3f3f3;">
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
	<div style="height: 100%;">
		<div align="right" class="leftmenu">
			<div class="leftmenu2">
				<div class="loginmenu">
					<div align="center" style="position: relative; top: 25px;">
						<%
							if (SESSION_USER_ID.equals("")) {
						%>
						<a href="/user/user_login.do"> <img
							src="../img/total/leftlogin.png"
							onmouseover="this.src='../img/total/leftlogin2.png'"
							onmouseout="this.src='../img/total/leftlogin.png'">
						</a>
						<div
							style="width: 260px; height: 1px; background-color: #888888; position: relative; top: 25px;"></div>
						<div style="position: relative; top: 35px;">
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
						<div
							style="width: 260px; height: 1px; background-color: #888888; position: relative; top: 25px;"></div>
						<div style="position: relative; top: 35px;">
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
						<div
							style="width: 260px; height: 1px; background-color: #888888; position: relative; top: 25px;"></div>
						<div style="position: relative; top: 35px;">
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
				<div>
					<font face='Malgun Gothic' size="6px" style="color: #555555;">
						<b>영화소개</b>
					</font>
				</div>
				<div align="right">
				<a href="javascript:history.back()">
				<img src="../img/button/sign.png"
				onmouseover="this.src='../img/button/sign2.png'"
				onmouseout="this.src='../img/button/sign.png'">
				</a>
				</div>
				<div style="height:5px"></div>
				<div style="height: 3px; background-color: #dddddd;"></div>
				<div style="height: 20px;"></div>
				<div class="tableborder">
				<div>
				<div align="center" style="width: 45%; vertical-align:top; ">		
				<img src="<%=imgsrc %>" class="poster">
				</div>
				<div style="width: 53%; padding: 60px 0 0 0;">
				<div>
				<font face='Malgun Gothic' size="6px" style="color: #333333;">
						<b><%=moviename %></b>
					</font>
				</div>
				<div style="height: 10px"></div>
				<div style="height: 2px; background-color: #dddddd;"></div>
				<div style="height: 10px"></div>
				<div>
				<font face='Malgun Gothic' size="5px" style="color: #555555;">
						<b>장르</b>
					</font>
					<br/>
				<div style="height: 7px"></div>
					<font face='Malgun Gothic' size="3px" style="color: #777777;">
					<%=genre %>
					</font>
				</div>
				</div>
				</div>
				<div style="height: 30px"></div>
				<div style="background-color: #eeeeee; border:2px solid #cccccc;">
				<div>
				<font face='Malgun Gothic' size="6px" style="color: #555555;">
						<b>줄거리</b>
					</font>
				</div>
				<br/>
				<div style="height: 7px"></div>
				<div>
				<font face='Malgun Gothic' style="letter-spacing:2px; line-height:1.7" style="color: #666666;">
						&nbsp;<%=story.replaceAll("\\. ",".<br/>") %>
					</font>
				</div>
				</div>
				<div style="height: 10px"></div>
				<div style="height: 2px; background-color: #dddddd;"></div>
				<div style="height: 10px"></div>
				<font face='Malgun Gothic' size="6px" style="color: #555555;">
						<b>관련영상</b>
				</font>
				<div style="height: 7px"></div>
				<div align="center">
				<iframe name="vedio1" width="300" height="200" src="https://www.youtube.com/embed/<%=videoL1 %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				<iframe name="vedio2" width="300" height="200" src="https://www.youtube.com/embed/<%=videoL2 %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				</div>
				<div style="height: 7px"></div>
				<a onClick="window.open('<%="https://www.youtube.com/results?search_query="+moviename %>');" class="youtube">
				<b>
				유튜브로 해당영화 검색
				</b>
				</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>