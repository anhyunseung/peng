<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%@ page import="poly.dto.NoticeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.Comment_noticeDTO"%>
<%@page import="java.util.List"%>
<%
	String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
	System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
	System.out.println("ss_user_id : " + SESSION_USER_ID);
	NoticeDTO rDTO = (NoticeDTO) request.getAttribute("rDTO");
	int count2 = (int)request.getAttribute("count3");

	if (rDTO == null) {
		rDTO = new NoticeDTO();

	}

	session.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+CmmUtil.nvl(rDTO.getnotice_seq()));
	String notice_seq = rDTO.getnotice_seq();

	List<Comment_noticeDTO> clist = rDTO.getClist();
	if (clist == null) {

		clist = new ArrayList<Comment_noticeDTO>();
	}
	String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String seq = CmmUtil.nvl((String) session.getAttribute("com_notice_seq"));
	String com_seq=CmmUtil.nvl((String) session.getAttribute("com_seq"));
	//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
	int edit = 1;

	//로그인 안했다면....
	if (ss_user_id.equals("")) {
		edit = 3;

		//본인이 작성한 글이면 2가 되도록 변경
	} else if (ss_user_id.equals(CmmUtil.nvl(rDTO.getUser_id()))) {
		edit = 2;

	}

	System.out.println("user_id : " + CmmUtil.nvl(rDTO.getUser_id()));
	System.out.println("ss_user_id : " + ss_user_id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon"
	href="http://localhost:8080/notice/NoticeInfo.do/../../img/common/icon.ico"
	type="image/x-icon" />
<%
				String title=CmmUtil.nvl(rDTO.getTitle()).replaceAll("\r\n", "<br/>");;
				title = title.replaceAll("& #39;", "&#39;");
			      title = title.replaceAll("& lt;", "&lt;");
			      title = title.replaceAll("& gt;", "&gt;");
			      title = title.replaceAll("& #40;", "&#40;");
			      title = title.replaceAll("& #41;", "&#41;");
			      title = title.replaceAll("\\ ","&nbsp;");
				%>
<title><%=title%> - 공지사항 : Lovie</title>
<script type="text/javascript">

function doEdit(){
 if ("<%=edit%>"==2 ){
    
    location.href="/notice/NoticeEditInfo.do?notice_seq=<%=CmmUtil.nvl(rDTO.getnotice_seq())%>";
 
 }else if ("<%=edit%>"==3){
    alert("로그인 하시길 바랍니다.");
    top.location.href="/user/user_login.do";
    
    
 }else{
    alert("본인이 작성한 글만 수정 가능합니다.")
 }
}

function doDelete(){
 if ("<%=edit%>"==2 || "<%=ss_user_id%>"=="admin"){
    if(confirm("정말로 삭제하시겠습니까?")){
       location.href="/notice/NoticeDelete.do?notice_seq=<%=CmmUtil.nvl(rDTO.getnotice_seq())%>";
 			}
 		}else if ("<%=edit%>" == 3) {
				alert("로그인 하시길 바랍니다.");
				location.href = "/user/user_login.do";
		} else {
			alert("본인이 작성한 글만 삭제 가능합니다.")
		}
	}
function doInfo(seq){
    location.href="/notice/NoticeInfo.do?notice_seq="+seq;
}

	function doSubmit2(f) {
		if (f.comment2.value == "") {
			alert("댓글내용을 입력해주세요.");
			f.comment.focus();
			return false;
		}
		if (f.comment2.value.length > 3000) {
			alert("최대 3000자까지 입력 가능합니다.");
			f.comment2.focus();
			return false;
		}
	}
	function doEdit2(seq) {
		location.href = "/notice/NoticeInfo2.do?com_seq=" + seq;
	}

	function doDelete2(seq) {
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href = "/notice/commentdelete.do?com_seq=" + seq;
		 		}
	}

	function doList() {
		location.href = "/notice/NoticeList.do";
	}
	function doBack(){
		alert("댓글이 수정되지 않았습니다.");
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

div.tableup {
	background-color: #eeeeee;
	padding: 8px 8px;
	border-bottom: 1px solid #dddddd;
}

div.tableup>div {
	display: inline-block;
}

div.tableleft {
	width: 49.5%;
}

div.tableright {
	width: 49.5%;
}

div.tablemiddle {
	padding: 50px 10px;
}

div.tabledown {
	margin: 0 20px 20px 20px;
	padding: 10px 10px;
	box-shadow: 0 0 3px 0 rgba(100, 100, 100, 0.4);
}

textarea {
	outline-color: #888888;
}

@import url("https://fonts.googleapis.com/css?family=Lato:100,300,400");

@import url("https://fonts.googleapis.com/css?family=Roboto:100");

.button-container {
	position: relative;
	width: 100px;
	height: 50px;
	overflow: hidden;
	border: 1px solid #777;
	font-family: 'Lato', sans-serif;
	font-weight: 300;
	transition: 0.5s;
	letter-spacing: 1px;
}

.button-container button {
	width: 101%;
	height: 100%;
	font-family: 'Lato', sans-serif;
	font-weight: 300;
	font-size: 20px;
	letter-spacing: 1px;
	background: #777;
	-webkit-mask:
		url("https://raw.githubusercontent.com/robin-dela/css-mask-animation/master/img/urban-sprite.png");
	mask:
		url("https://raw.githubusercontent.com/robin-dela/css-mask-animation/master/img/urban-sprite.png");
	-webkit-mask-size: 3000% 100%;
	mask-size: 3000% 100%;
	border: none;
	color: #fff;
	cursor: pointer;
	-webkit-animation: ani2 0.7s steps(29) forwards;
	animation: ani2 0.7s steps(29) forwards;
}

.button-container button:hover {
	-webkit-animation: ani 0.7s steps(29) forwards;
	animation: ani 0.7s steps(29) forwards;
}

.mas {
 position: absolute;
 color: #777;
 text-align: center;
 width: 101%;
 font-family: 'Lato', sans-serif;
 font-weight: 300;
 position: absolute;
 font-size: 20px;
 margin-top: 12px;
 overflow: hidden;
}

@-webkit-keyframes ani {
 from {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }

 to {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }
}

@keyframes ani {
 from {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }

 to {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }
}

@-webkit-keyframes ani2 {
 from {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }

 to {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }
}

@keyframes ani2 {
 from {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }

 to {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }
}
/* 버튼 1  */
div.editalign > div{
	display: inline-block;
}

.button-container-2 {
	position: relative;
	width: 50px;
	height: 34px;
	overflow: hidden;
	border: 1px solid #777;
	font-family: 'Lato', sans-serif;
	font-weight: 300;
	transition: 0.5s;
	letter-spacing: 1px;
}

.button-container-2 button {
	width: 101%;
	height: 100%;
	font-family: 'Lato', sans-serif;
	font-weight: 300;
	font-size: 15px;
	letter-spacing: 1px;
	background: #777;
	-webkit-mask:
		url("https://raw.githubusercontent.com/robin-dela/css-mask-animation/master/img/urban-sprite.png");
	mask:
		url("https://raw.githubusercontent.com/robin-dela/css-mask-animation/master/img/urban-sprite.png");
	-webkit-mask-size: 3000% 100%;
	mask-size: 3000% 100%;
	border: none;
	color: #fff;
	cursor: pointer;
	-webkit-animation: ani2 0.7s steps(29) forwards;
	animation: ani2 0.7s steps(29) forwards;
}

.button-container-2 button:hover {
	-webkit-animation: ani 0.7s steps(29) forwards;
	animation: ani 0.7s steps(29) forwards;
}

.button-container-2>a> button {
	width: 101%;
	height: 100%;
	font-family: 'Lato', sans-serif;
	font-weight: 300;
	font-size: 15px;
	letter-spacing: 1px;
	background: #777;
	-webkit-mask:
		url("https://raw.githubusercontent.com/robin-dela/css-mask-animation/master/img/urban-sprite.png");
	mask:
		url("https://raw.githubusercontent.com/robin-dela/css-mask-animation/master/img/urban-sprite.png");
	-webkit-mask-size: 3000% 100%;
	mask-size: 3000% 100%;
	border: none;
	color: #fff;
	cursor: pointer;
	-webkit-animation: ani2 0.7s steps(29) forwards;
	animation: ani2 0.7s steps(29) forwards;
}

.button-container-2>a> button:hover {
	-webkit-animation: ani 0.7s steps(29) forwards;
	animation: ani 0.7s steps(29) forwards;
}

.mas2 {
 position: absolute;
 color: #777;
 text-align: center;
 width: 101%;
 font-family: 'Lato', sans-serif;
 font-weight: 300;
 position: absolute;
 font-size: 15px;
 margin-top: 7px;
 overflow: hidden;
}

@-webkit-keyframes ani {
 from {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }

 to {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }
}

@keyframes ani {
 from {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }

 to {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }
}

@-webkit-keyframes ani2 {
 from {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }

 to {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }
}

@keyframes ani2 {
 from {
  -webkit-mask-position: 100% 0;
  mask-position: 100% 0;
 }

 to {
  -webkit-mask-position: 0 0;
  mask-position: 0 0;
 }
}
/* 버튼2 */
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
<body 
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
					src="../img/total/listnotice2.jpg">
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
						style="color: #555555;"> <b>공지사항</b>
					</font></div>
					<div align="right">
					<%
						if (edit == 2 || ss_user_id.equals("admin")) {
					%> 
					<a
						style="cursor: pointer;"
						onclick="doEdit();"> <img
							src="../img/button/rewri.png"
							onmouseover="this.src='../img/button/rewri2.png'"
							onmouseout="this.src='../img/button/rewri.png'" />
					</a> <a style="cursor: pointer;"
						onclick="doDelete();"> <img
							src="../img/button/del.png"
							onmouseover="this.src='../img/button/del2.png'"
							onmouseout="this.src='../img/button/del.png'" />
					</a>
					<%} %>
					 <a href="NoticeList.do"> <img src="../img/button/list.png"
							onmouseover="this.src='../img/button/list2.png'"
							onmouseout="this.src='../img/button/list.png'" />
					</a></div>
					<div style="height:5px"></div>
				<div style="height:3px;background-color: #dddddd;"></div>
					<div style="height:10px"></div>
			<div class="tableborder">
				<div class="tableup">
					<%
				title=CmmUtil.nvl(rDTO.getTitle()).replaceAll("\r\n", "<br/>");;
				title = title.replaceAll("& #39;", "&#39;");
			      title = title.replaceAll("& lt;", "&lt;");
			      title = title.replaceAll("& gt;", "&gt;");
			      title = title.replaceAll("& #40;", "&#40;");
			      title = title.replaceAll("& #41;", "&#41;");
			      title = title.replaceAll("\\ ","&nbsp;");
				%>
					<font size="4px"> <b><%=title%></b>
					</font> <br />
					<div class="tableleft">
						<%if(CmmUtil.nvl(rDTO.getUser_id()).equals("admin")){%>
						<font color="#27c1f3" size="3px">운영자</font>
						<%}else{ %>
						<font size="3px" color="#777777"> 
						<%=CmmUtil.nvl(rDTO.getUser_id())%>
						</font>						
						<%} %>
					</div>
					<div class="tableright" align="right">
						<font size="2px" color="#777777"> <b>공지사항</b> | <%
 	String date = CmmUtil.nvl(rDTO.getReg_dt());
						if(date.equals("")){}else{
 %> <%=date.substring(0, 4)%>.<%=date.substring(5, 7)%>.<%=date.substring(8, 10)%>.
							<%=date.substring(11, 16)%>
							<%} %>
						</font>
					</div>
				</div>
				<div class="tablemiddle">
					<%
String contents = CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>");
					contents = contents.replaceAll("& #39;", "&#39;");
					contents = contents.replaceAll("& lt;", "&lt;");
					contents = contents.replaceAll("& gt;", "&gt;");
					contents = contents.replaceAll("& #40;", "&#40;");
					contents = contents.replaceAll("& #41;", "&#41;");
%><%=contents%>
				</div>
				<form action="/notice/commentupdate.do"
					onsubmit="return doSubmit2(this);" method="post">
					<div class="tabledown">
						<div><font face='Malgun Gothic' size="4px"
									style="color: #555555;"> <b>댓글</b>
								</font> <%
 	int l = clist.size();
 	if (l != 0) {
 %> <span style="color: rgb(2, 151, 128); font-weight: bold;"> [<%=l%>]
								</span> <%
 	}
 %></div>
							<div style="background-color: #dddddd; height: 3px;"></div>
								<div style="height:100%;" class="paging1">
									<div style="margin: 5px 0 0 0;">
										<div>
											<textarea name="comment"
												style="height: 46px; width: 516px; resize: none;"></textarea>
										</div>
										<input type="hidden" name="notice_seq" value="<%=notice_seq%>">
										<div class="button-container">
											<span class="mas"><b>등록</b></span>
											<button type="button" onclick="javascript:doBack();" name="Hover">
												<b>등록</b>
											</button>
										</div>
									</div>
								</div>
							<%
								int b = 9;
								int c = l / 10;
								int d = l - c * 10;
								int e = (clist.size() - 1) / 10;

								if (clist.size() > 10) {
									l = 10;
								}
								if (count2 == c) {
									l = d;
								}
								for (int i = 0; i < l; i++) {
									b--;
									Comment_noticeDTO a = clist.get(count2 * 10 + i);
							%>
							<div style="background-color: #dddddd; height: 2px;"></div>
							<div style="margin: 7px 7px;">
										<div class="comaliggn" style="vertical-align: middle;">
											<div style="width: 65%; height: 27px">
												<b><%if(CmmUtil.nvl(a.getUser_id()).equals("admin")){%>
												<span style="color: #27c1f3;">운영자</span>
												<%}else{ %>
												<%=CmmUtil.nvl(a.getUser_id()).replaceAll("\r\n", "<br/>")%>
												<%} %>&nbsp;&nbsp;</b>
												<font size="2px" color="#777777"> <%
 	String comdate = CmmUtil.nvl(a.getReg_dt());
 %> <%=comdate.substring(0, 4)%>.<%=comdate.substring(5, 7)%>.<%=comdate.substring(8, 10)%>.
													<%=comdate.substring(11, 16)%>
												</font>
											</div>
											<div align="right"
												style="width: 34%; position: relative; top: 7px">
												<div>
												<%if(CmmUtil.nvl(a.getcom_seq()).equals(com_seq)){%>
													<script>
													<%if(CmmUtil.nvl(a.getUser_id()).equals(SESSION_USER_ID)){
														}else{%>
														alert("잘못된 접근입니다.");
														location.href = "/notice/NoticeInfo.do?notice_seq=<%=CmmUtil.nvl(rDTO.getnotice_seq())%>";
													<%}%></script>
												<%}else{
												if(ss_user_id.equals(CmmUtil.nvl(a.getUser_id()))){
												%>
													<a style="cursor: pointer;"
														onclick="doEdit2(<%=CmmUtil.nvl(a.getcom_seq())%>);">
														<img src="../img/button/rewri.png"
														onmouseover="this.src='../img/button/rewri2.png'"
														onmouseout="this.src='../img/button/rewri.png'" />
													</a>
													<%} 
												if(ss_user_id.equals(CmmUtil.nvl(a.getUser_id()))||ss_user_id.equals("admin")){
													%>
													 <a style="cursor: pointer;"
														onclick="doDelete2(<%=CmmUtil.nvl(a.getcom_seq())%>);">
														<img src="../img/button/del.png"
														onmouseover="this.src='../img/button/del2.png'"
														onmouseout="this.src='../img/button/del.png'" />
													</a>
													<%}} %>
												</div>
											</div>
										</div>
										<div style="margin: 4px 0;"></div>
										<%
										if(CmmUtil.nvl(a.getcom_seq()).equals(com_seq)){%>
										<div class="editalign">
										<div>
										<%String q= CmmUtil.nvl(a.getcom_seq()); %>
										<input type="hidden" name="user_id" value="<%=CmmUtil.nvl(a.getUser_id())%>"/>
										<input type="hidden" name="com_seq" value="<%=q%>">
										<%
String comment = CmmUtil.nvl(a.getContents()).replaceAll("<br/>", "\r\n");
										comment = comment.replaceAll("& #39;", "'");
										comment = comment.replaceAll("& lt;", "<");
										comment = comment.replaceAll("& gt;", ">");
										comment = comment.replaceAll("& #40;", "(");
										comment = comment.replaceAll("& #41;", ")");
%>
										<textarea name="comment2" style="width: 496px; resize:none;"><%=comment%></textarea>
										</div>
										<div class="button-container-2">
											<span class="mas2"><b>완료</b></span>
											<button type="submit" name="Hover">
												<b>완료</b>
											</button>
										</div>
										<div>
										<div class="button-container-2" >
											<span class="mas2"><b>취소</b></span>
											<button type="button" name="Hover" onclick="javascript:doInfo('<%=seq%>');">
												<b>취소</b>
											</button>
										</div>
										</div>
										</div>
										<%}else{ %>
										<%
String comment = CmmUtil.nvl(a.getContents()).replaceAll("\r\n", "<br/>");
										comment = comment.replaceAll("& #39;", "&#39;");
										comment = comment.replaceAll("& lt;", "&lt;");
										comment = comment.replaceAll("& gt;", "&gt;");
										comment = comment.replaceAll("& #40;", "&#40;");
										comment = comment.replaceAll("& #41;", "&#41;");
										comment = comment.replaceAll("\\ ","&nbsp;");
%>
										<%=comment%>
										<%} %>
									</div>
							<%
								}
							%>
							<div style="background-color: #dddddd; height: 3px;"></div>
								<div class="paging" align="center" style="height:30px; margin: 10px 0 0 0">
									<%
										int line = 0;
										c = clist.size() / 100;
										if (count2 / 10 == 0) {
											int q = 1;
											if (clist.size() > 100) {
												q = 10;
											} else {
												q = (clist.size() - 1) / 10 + 1;
											}
											count2 = count2 + 1;
											for (line = 1; line <= q; line++) {
									%> <%
 	if (count2 == line) {
 %>
									<div class="linebox" align="center">
										<a href="NoticeInfo.do?count2=<%=line%>" class="linetag"> <span
											style="color: white;"> <b> <%=line%>
											</b>
										</span>
										</a>
									</div> <%
 	} else {
 %>
									<div class="linebox2" align="center">
										<a href="NoticeInfo.do?count2=<%=line%>" class="linetag2">
											<span style="color: #555555;"> <b> <%=line%>
											</b>
										</span>
										</a>
									</div> <%
 	}
 %> <%
 	}
 		if (clist.size() > 100) {
 %><div class="linebox3" align="center">
										<a href="NoticeInfo.do?count2=<%=11%>" class="linetag3"> <span
											style="color: #555555;"> <b> > </b>
										</span>
										</a>
									</div> <%
 	}
 	} else if (count2 / 10 == c) {
 		int color = count2 + 1;
 %>
									<div class="linebox3" align="center">
										<a href="NoticeInfo.do?count2=<%=count2 / 10 * 10 - 9%>"
											class="linetag3"> <span style="color: #999999;"> <b>
													< </b>
										</span>
										</a>
									</div> <%
 	for (line = count2 / 10 * 10 + 1; line <= e + 1; line++) {
 %> <%
 	if (color == line) {
 %>
									<div class="linebox" align="center">
										<a href="NoticeInfo.do?count2=<%=line%>" class="linetag"> <span
											style="color: white;"> <b> <%=line%>
											</b>
										</span>
										</a>
									</div> <%
 	} else {
 %><div class="linebox2" align="center">
										<a href="NoticeInfo.do?count2=<%=line%>" class="linetag2">
											<span style="color: #555555;"> <b> <%=line%>
											</b>
										</span>
										</a>
									</div> <%
 	}
 %> <%
 	}
 %> <%
 	} else {
 		int color = count2 + 1;
 %>
									<div class="linebox3" align="center">
										<a href="NoticeInfo.do?count2=<%=count2 / 10 * 10 - 9%>"
											class="linetag3"> <span style="color: #999999;"> <b>
													< </b>
										</span>
										</a>
									</div> <%
 	for (line = count2 / 10 * 10 + 1; line <= count2 / 10 * 10 + 10; line++) {
 %> <%
 	if (color == line) {
 %><div class="linebox" align="center">
										<a href="NoticeInfo.do?count2=<%=line%>" class="linetag"> <span
											style="color: white;"> <b> <%=line%>
											</b>
										</span>
										</a>
									</div> <%
 	} else {
 %><div class="linebox2" align="center">
										<a href="NoticeInfo.do?count2=<%=line%>" class="linetag2">
											<span style="color: #555555;"> <b> <%=line%>
											</b>
										</span>
										</a>
									</div> <%
 	}
 %> <%
 	}
 %>
									<div class="linebox3" align="center">
										<a href="NoticeInfo.do?count2=<%=count2 / 10 * 10 + 11%>"
											class="linetag3"> <span style="color: #999999;"> <b>
													> </b>
										</span>
										</a>
									</div> <%
 	}
 %>
								</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
</body>
</html>
