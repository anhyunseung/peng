<%@ page import="poly.util.CmmUtil"%>
<%@ page import="poly.dto.CommonDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="poly.dto.UserDTO"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Collection"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.URL"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="java.util.Iterator"%>
<%@ page
	import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@ page import="org.jsoup.select.Elements"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page import="java.util.Random"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
	session.setAttribute("url", "/top.do");
	String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
	System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
	System.out.println("ss_user_id : " + SESSION_USER_ID);
	session.setAttribute("id_over", "");
	session.setAttribute("email_over", "");
	session.setAttribute("email_over2", "");

	List<CommonDTO> nList = (List<CommonDTO>) request.getAttribute("nList");
	if (nList == null) {
		nList = new ArrayList<CommonDTO>();

	}
	System.out.print(nList);
	List<CommonDTO> bList = (List<CommonDTO>) request.getAttribute("bList");
	if (bList == null) {
		bList = new ArrayList<CommonDTO>();

	}
	System.out.print(bList);
	
	String moviecode = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon"
	href="http://localhost:8080/top.do/../img/common/icon.ico"
	type="image/x-icon" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script
	src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<title>Let's see the movie! : Lovie</title>

<script type="text/javascript">
	var j = $.noConflict(true); // $.noConflict(true) 를 사용해서 $ -> 변수로 선언한 j로 바꾸니 해결!
	j(document).ready(function() {
		var main = j('.bxslider').bxSlider({
			mode : 'fade',
			auto : true, //자동으로 슬라이드 
			controls : true, //좌우 화살표	
			autoControls : true, //stop,play 
			pager : true, //페이징 
			pause : 5000,
			autoDelay : 0,
			speed : 800,
			stopAutoOnclick : true,
			autoHover : true,
			touchEnabled : (navigator.maxTouchPoints > 0)
		});
		j(".bx-stop").click(function() { // 중지버튼 눌렀을때 
			main.stopAuto();
			j(".bx-stop").hide();
			j(".bx-start").show();
			return false;
		});
		j(".bx-start").click(function() { //시작버튼 눌렀을때 
			main.startAuto();
			j(".bx-start").hide();
			j(".bx-stop").show();
			return false;
		});
		j(".bx-start").hide(); //onload시 시작버튼 숨김. 
	});
	function doNDetail(seq) {
		location.href = "/notice/NoticeInfo.do?notice_seq=" + seq;
	}
	function doBDetail(seq) {
		location.href = "/bbm/bbmInfo.do?bbm_seq=" + seq;
	}
</script>
<style>

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
	color: gray;
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
/* 여기까지 상단  */
div.mainmenu {
	background-repeat: no-repeat;
	background-size: 100% 1000px;
	width: 100%;
	height: 600px;
	text-align: center;
}

div.mainmenuin {
	background-color: rgba(255, 255, 255, 0.9);
	width: 100%;
	height: 600px;
	text-align: center;
}

img.movieimg {
	position: relative;
	width: 280px;
	height: 400px;
	top: 0px;
	left: 20%;
	opacity: 0.9;
	border: 15px ridge rgba(102, 51, 0, 0.4);
}

img.movieimg:hover {
	cursor: pointer;
	-webkit-transform: scale(1.1); /*  크롬 */
	-moz-transform: scale(1.1); /* FireFox */
	-o-transform: scale(1.1); /* Opera */
	transform: scale(1.1);
	transition: transform .5s;
	-o-transition: transform .5s;
	-moz-transition: transform .5s;
	-webkit-transition: transform .5s;
	opacity: 1;
}

span.moviename {
	position: relative;
	left: 20%;
	top: 250px;
}

font.namefont {
	z-index: 1;
	color: rgba(0, 0, 0, 0.4);
}
/* 여기까지 탑1 */
div.menu {
	background-color: #f3f3f3;
	width: 100%;
	height: 400px;
	text-align: center;
}

div.menuboth {
	height: 400px;
}

div.menu>div>div {
	display: inline-block;
}

div.mainlogin {
	background-color: #ffffff;
	width: 300px;
	height: 250px;
	margin: 45px 30px;
	padding: 30px 20px;
	box-shadow:1px 1px 3px 0 rgba(213, 213, 213, 0.5);
	position: relative;
	bottom: 65px;
}

div.loginbg{
	background-image : url("../img/top/tableuser.png");
	width: 272px;
	height: 110px;
    margin-left: 2px;
    position: relative;
    top:20px;
}
div.tabletext{
	background-image : url("../img/top/tabletext.png");
	width: 272px;
	height: 42px;
    margin-left: 2px;
    position: relative;
	top: 50px;
}
div.tabletextmove{
	position: relative;
	top: 23%;
}
a.user {
	color: gray;
}

a.user:hover {
	color: #494949;
	text-decoration: none;
}
div.notice {
	background-color: #ffffff;
	width: 300px;
	height: 250px;
	margin: 45px 30px;
	padding: 30px 20px;
	box-shadow:1px 1px 3px 0 rgba(213, 213, 213, 0.8);
}

div.word>div{
	display: inline-block;
}

div.bbm {
	background-color: #ffffff;
	width: 300px;
	height: 250px;
	margin: 45px 30px;
	padding: 30px 20px;
	box-shadow:1px 1px 3px 0 rgba(213, 213, 213, 0.5);
}
/* 여기까지 탑2 */
div.menu3d {
	width: 100%;
	height: 1200px;
	background-image: url('../img/movie_main.jpg');
	background-repeat: no-repeat;
	background-size: 100% 1600px;
}
div.menu3d>div{
	width: 100%;
	height: 1100px;
	padding: 50px 0;
	background-color: rgba(0,0,0,0.8);
}

div.align3d>div{
	display: inline-block;
}

a.tag2 {
	color: #4f4f4f;
}

a.tag2:hover {
	color: #000000;
	text-decoration: underline;
}
</style>
</head>
<body style="min-width: 1250px">
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
	<!-- 여기까지 상단  -->
	<div class="mainmenu">
		<div class="home__slider">
			<div class="bxslider">
					
					<div class="mainmenu">
							<div class="mainmenuin">
								<span class="moviename" style="color: white; font-weight: bold;">
								
										 <br />
								<br /> 
								<font face='Malgun Gothic' size="3px" class="namefont">
										랜덤 추천 결과 입니다.</font>
								</span> 
							</div>
					</div>
			</div>
		</div>
	</div>
	<!-- 여기까지 메뉴1 -->
	<div class="menu">
		<div class="menuboth">
			<div class="mainlogin">
				<div style="background-image:url('../img/top/tablebg.png'); width:100%; height: 100%; " align="center">
					<%
						if (SESSION_USER_ID.equals("")) {
					%>
						<div class="loginbg">
						<br/>
						<font face='Malgun Gothic' size="10px">
						<a href="/user/user_login.do" class="user">
						로그인
						</a>
						</font>
						</div>
						<div style="position: relative; top:34px;">
						영화 후기를 남겨주세요!
						</div>
						<div class="tabletext">
							<div class="tabletextmove">
						<span
							style="padding: 10px 7px; color: gray;"> <a class="tag"
								href="/user/user_join.do"> <font face='Malgun Gothic'
									size="2px"> 회원가입 </font>
							</a>
						</span> <span style="padding: 10px 0px; color: gray;"> <font
								face='Malgun Gothic' size="2px" color="gray"> | </font>
						</span> <span style="padding: 10px 7px; color: gray;"> <a
								class="tag" href="/user/user_id_search.do"
								onClick="window.open('/user/user_id_search.do','아이디 찾기','width=470, height=226, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;">
									<font face='Malgun Gothic' size="2px"> 아이디찾기 </font>
							</a>
						</span> <span style="padding: 10px 0px; color: gray;"> <font
								face='Malgun Gothic' size="2px" color="gray"> | </font>
						</span> <span style="padding: 10px 7px; color: gray;"> <a
								class="tag" href="/user/user_pw_search.do"
								onClick="window.open('/user/user_pw_search.do','비밀번호 찾기','width=470, height=366, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;">
									<font face='Malgun Gothic' size="2px"> 비밀번호 찾기 </font>
							</a>
						</span>
							</div>
						</div>
					<%
						} else if(SESSION_USER_ID.equals("admin")) {
					%>
						<div class="loginbg">
						<br/>
						<font face='Malgun Gothic' size="10px">
						<a href="/user/manageList.do" class="user">
						<%=SESSION_USER_ID %>
						</a>
						</font>
						</div>
						<div style="position: relative; top:34px;">
						관리를 시작합니다.</div>
						<div class="tabletext">
							<div class="tabletextmove">
						<span
							style="padding: 10px 7px; color: gray;"> <a class="tag"
								href="/user/manageList.do"> <font face='Malgun Gothic'
									size="2px"> 회원관리 </font>
							</a>
						</span><span style="padding: 10px 0px; color: gray;"> <font
								face='Malgun Gothic' size="2px" color="gray"> | </font>
						</span> <span
							style="padding: 10px 7px; color: gray;"> <a class="tag"
								href="/user/userInfo.do"> <font face='Malgun Gothic'
									size="2px"> 내 정보 </font>
							</a>
						</span><span style="padding: 10px 0px; color: gray;"> <font
								face='Malgun Gothic' size="2px" color="gray"> | </font>
						</span> <span style="padding: 10px 7px; color: gray;"> <a
								class="tag" href="/user/user_logout.do"> <font
									face='Malgun Gothic' size="2px"> 로그아웃 </font>
							</a>
						</span>
							</div>
						</div>
					<%
						}else{
					%>
						<div class="loginbg">
						<br/>
						<font face='Malgun Gothic' size="10px">
						<a href="/user/userInfo.do" class="user">
						<%=SESSION_USER_ID %>
						</a>
						</font>
						</div>
						<div style="position: relative; top:34px;">
						Lovie 에 어서오세요!</div>
						<div class="tabletext">
							<div class="tabletextmove">
						<span
							style="padding: 10px 7px; color: gray;"> <a class="tag"
								href="/user/userInfo.do"> <font face='Malgun Gothic'
									size="2px"> 내 정보 </font>
							</a>
						</span><span style="padding: 10px 0px; color: gray;"> <font
								face='Malgun Gothic' size="2px" color="gray"> | </font>
						</span> <span style="padding: 10px 7px; color: gray;"> <a
								class="tag" href="/user/user_logout.do"> <font
									face='Malgun Gothic' size="2px"> 로그아웃 </font>
							</a>
						</span>
							</div>
						</div>
					<%
						}
					%>
			</div>
			</div>
			<!-- 공지사항  -->
			<div class="notice">
			<div align="left">
			<div class="word" style="position: relative; bottom: 10px;">
						<div align="left" style="width: 50%">
						<font
							face='Malgun Gothic' size="5px" color="gray"> <b>공지사항</b>
						</font>
						</div>
							<div align="right" style="width: 48%">
							<a
							href="/notice/NoticeList.do" class="tag"> <font
								face='Malgun Gothic' size="5px"> <b>+</b>
							</font></a></div>
							</div>
							<div style="height: 1px; background-color: #dddddd;"></div>
					<%
						int a1 = nList.size();
						if (a1 > 5) {
							a1 = 5;
						}
						for (int count = 0; count < a1; count++) {
							CommonDTO nDTO = nList.get(count);
							if (nDTO == null) {
								nDTO = new CommonDTO();
							}
					%>
					<div style="height:15px">
					</div>
					<span
							style="color: #4f4f4f; font-weight: bold;"> - </span> <a
							href="javascript:doNDetail('<%=CmmUtil.nvl(nDTO.getnotice_seq())%>');"
							class="tag2"> <span style="font-weight: bold"> 
							<%if(CmmUtil.nvl(nDTO.getnotice_Title()).length()>10){%>
								<%=CmmUtil.nvl(nDTO.getnotice_Title()).substring(0, 10)+"..." %>	
							<%}else{%>
							<%=CmmUtil.nvl(nDTO.getnotice_Title())%>
							<%} %>
							</span>
						</a> <%
 	if (CmmUtil.nvl(nDTO.getnotice_com_count()).equals("0")) {
 		} else {
 %> <span
							style="color: rgb(2, 151, 128); font-weight: bold; font-size: small;">
								[<%=CmmUtil.nvl(nDTO.getnotice_com_count())%>]
						</span>
					<%
						}
					%>
					<%
						}int blank=5-a1;
						for(int a2=0;a2<blank;a2++){%>
							<div style="height:15px">
					</div>
 								<span style="font-weight: bold">　</span>
					<%}
					%>
			</div>
			</div>
			<!-- 자유게시판  -->
			<div class="bbm">
				<div align="left">
				<div class="word" style="position: relative; bottom: 10px;">
						<div align="left" style="width: 50%">
						<font
							face='Malgun Gothic' size="5px" color="gray"> <b>자유게시판</b>
						</font>
						</div>
							<div align="right" style="width: 48%">
							<a
							href="/notice/NoticeList.do" class="tag"> <font
								face='Malgun Gothic' size="5px"> <b>+</b>
							</font></a></div>
							</div>
							<div style="height: 1px; background-color: #dddddd;"></div>

					<%
						int a = bList.size();
						if (a > 5) {
							a = 5;
						}
						for (int count = 0; count < a; count++) {
							CommonDTO bDTO = bList.get(count);
							if (bDTO == null) {
								bDTO = new CommonDTO();
							}
					%>
					<div style="height:15px">
					</div>
					<span
							style="color: #4f4f4f; font-weight: bold;"> - </span> <a
							href="javascript:doBDetail('<%=CmmUtil.nvl(bDTO.getbbm_seq())%>');"
							class="tag2"> <span style="font-weight: bold">
							 <%if(CmmUtil.nvl(bDTO.getbbm_Title()).length()>10){%>
								<%=CmmUtil.nvl(bDTO.getbbm_Title()).substring(0, 10)+"..." %>	
							<%}else{%>
							<%=CmmUtil.nvl(bDTO.getbbm_Title())%>
							<%} %>
							</span>
						</a> <%
 	if (CmmUtil.nvl(bDTO.getbbm_com_count()).equals("0")) {
 		} else {
 %> <span
							style="color: rgb(2, 151, 128); font-weight: bold; font-size: small;">
								[<%=CmmUtil.nvl(bDTO.getbbm_com_count())%>]
						</span>
					<%
						}
					%>
					<%
						}int blank2=5-a;
						for(int a2=0;a2<blank2;a2++){%>
						<div style="height:15px">
					</div>
 								<span style="font-weight: bold">　</span>
					<%}
					%>
					</div>
		</div>
	</div>
	</div>
	<!-- 여기까지 메뉴2  -->
	<div style="height: 5px; box-shadow:0 0 5px #ccc;"></div>
	<div class="menu3d" align="center">
	<div>
	<font face='Malgun Gothic' size="10px" color="#ffffff"> <b>전월 1위 영화</b> </font>
	<div style="height:100px;"></div>
	<div class="align3d">
	<div>
	<a href="/movieInfo.do?moviecode=174903">
	<img src="../img/movie_image.png" style="border: 20px ridge rgba(80,80,80,0.6);"/>
	</a>
	</div>
	<div class="fontmov" style="height:100%; vertical-align:top; padding:100px 0 0 40px;" align="left">
	<a href="/movieInfo.do?moviecode=174903">
	<img src="../img/movie_font.png">
	</a>
	<div style="height: 50px;"></div>
	<div style="height: 2px; width:540px; background-color: #dddddd;"></div>
	<div style="height: 20px;"></div>
	<font face='Malgun Gothic' size="5px" color="#dddddd">
	<b>개봉일</b> </font>
	<div style="height: 5px;"></div>
	<font face='Malgun Gothic' size="4px" color="#dddddd">
	2019. 07. 31.</font>
	<div style="height: 20px;"></div>
	<font face='Malgun Gothic' size="5px" color="#dddddd">
	<b>전월 관객수</b> </font>
	<div style="height: 5px;"></div>
	<font face='Malgun Gothic' size="4px" color="#dddddd">
	8,282,876명 </font>
	<div style="height: 20px;"></div>
	<font face='Malgun Gothic' size="5px" color="#dddddd">
	<b>전월 매출액</b> </font>
	<div style="height: 5px;"></div>
	<font face='Malgun Gothic' size="4px" color="#dddddd">
	70,608,256,112\ </font>
	<div style="height: 20px;"></div>
	<font face='Malgun Gothic' size="5px" color="#dddddd">
	<b>전월 매출액 점유율</b> </font>
	<div style="height: 5px;"></div>
	<font face='Malgun Gothic' size="4px" color="#dddddd">
	33.7%</font>
	</div>
	</div>
	</div>
	</div>
</body>
</html>