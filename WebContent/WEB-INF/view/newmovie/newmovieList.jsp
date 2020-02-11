<%@ page import="poly.util.CmmUtil"%>
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
	session.setAttribute("url", "/newmovie/newmovieList.do");
	String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
	System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
	System.out.println("ss_user_id : " + SESSION_USER_ID);

	Date dt = new Date();
	dt.setDate(dt.getDate() - 1);
	int year = dt.getYear() + 1900;
	int day = dt.getDate();
	int mon = dt.getMonth() + 1;

	String month = "";
	if (mon < 10) {
		month = "0" + mon;
	} else {
		month = "" + mon;
	}

	String day2 = "";
	if (day < 10) {
		day2 = "0" + day;
	} else {
		day2 = "" + day;
	}
	String date = year + month + day2;
	System.out.println(date);

	String targetDt = date;
	String itemPerPage = request.getParameter("itemPerPage") == null ? "9"
			: request.getParameter("itemPerPage");
	String key = "257a360ca175e71f65d605e4238a4d90";
	KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
	String dailyResponse = service.getDailyBoxOffice(true, targetDt, itemPerPage, "", "", "");
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String, Object> map = mapper.readValue(dailyResponse, HashMap.class);

	Iterator<String> mapIter = map.keySet().iterator();
	String movie = "";
	String key2 = "";
	Object value = "";
	while (mapIter.hasNext()) {
		key2 = mapIter.next();
		value = map.get(key2);
	}
	movie = value.toString();
	System.out.println(movie);
	String moviec[] = movie.split("movieNm=");
	String movied[] = movie.split("openDt=");
	int i = 1;
	request.setAttribute("map", map);
	String moviecode = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon"
	href="http://localhost:8080/newmovie/newmovieList.do/../../img/common/icon.ico"
	type="image/x-icon" />
<title>최신영화 : Lovie</title>
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

div.writemenu>div>div {
	display: inline-block;
}

div.movie {
	width: 210px;
	vertical-align: top;
	padding: 0 0 60px 0;
}

img.poster {
	box-shadow: 0px 0px 5px 3px rgba(100, 100, 100, 0.6);
}

img.poster:hover {
	cursor: pointer;
	-webkit-transform: scale(1.1); /*  크롬 */
	-moz-transform: scale(1.1); /* FireFox */
	-o-transform: scale(1.1); /* Opera */
	transform: scale(1.1);
	transition: transform .5s;
	-o-transition: transform .5s;
	-moz-transition: transform .5s;
	-webkit-transition: transform .5s;
}

a.moviename {
	color: #888888;
	font-weight: bold;
}

a.moviename:hover {
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
						src="../img/total/listnewmo2.jpg">
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
						<b>최신영화 TOP.9</b>
					</font>
				</div>
				<div style="height: 33px"></div>
				<div style="height: 3px; background-color: #dddddd;"></div>
				<div style="height: 20px;"></div>
				<c:if test="${not empty map.boxOfficeResult.dailyBoxOfficeList}">
					<div align="center" class="divline">
						<c:forEach items="${map.boxOfficeResult.dailyBoxOfficeList}"
							var="boxoffice">
							<%
								if (i <= 3) {
											if (i == 2) {
							%>
							<div style="padding: 0 25px 60px 25px" class="movie">
								<%
									} else {
								%>
								<div class="movie">
									<%
										}
									%>
									<%
										String moviec2[] = moviec[i].split(", openDt");
													String movied2[] = movied[i].split("-");
													System.out.println(moviec2[0] + " " + movied2[0]);
													if (moviec2[0].contains("%")) {
														String moviec3[] = moviec2[0].split("%");
														moviec2[0] = "";
														for (int hk = 0; hk < moviec3.length; hk++) {
															if (hk == moviec3.length - 1) {
																moviec2[0] = moviec2[0] + moviec3[hk];
															} else {
																moviec2[0] = moviec2[0] + moviec3[hk] + "%25";
															}
															if (moviec3.length - 1 == 0) {
																moviec2[0] = moviec3[hk] + "%25";
															}
														}
													}
													if (moviec2[0].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
														moviec2[0] = "헨젤과 그레텔: 마녀 사냥꾼";
													}
													String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query="
															+ moviec2[0] + "&section=all&ie=utf8";
													System.out.println(link);
													Document doc = Jsoup.connect(link).get();

													Elements pngs = doc.select("ul.search_list_1 li dl");

													String[] png3 = new String[1];

													int tj = 0;
													int wpq = 0;
													for (Element pngs2 : pngs) {
														String con = pngs2.text();
														String con2[] = pngs2.toString().split("href=");

														String con3[] = con2[1].split(">");
														String conn = pngs2.toString();
														String con4[] = conn.split("<em class=\"" + "cuser_cnt" + "\">");
														String con5[] = con4[1].split("</em>");

														if (tj == 0) {
															wpq = con5[0].length();
															png3[0] = con3[0].substring(1, con3[0].length() - 1);
														}
														if (wpq <= con5[0].length()) {
															String con6[] = conn.split("year=");
															int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
															if (cnn2 <= Integer.parseInt(movied2[0]) && cnn2 >= Integer.parseInt(movied2[0]) - 4) {
																wpq = con5[0].length();
																System.out.println(wpq);
																png3[0] = con3[0].substring(1, con3[0].length() - 1);
															}
														}
														tj = tj + 1;
														if (tj == 9) {
															break;
														}
													}

													String linkHref = "https://movie.naver.com/" + png3[0];
													String[] moviecodeout = linkHref.split("code=");
													moviecode = moviecodeout[1];
													Document doc2 = Jsoup.connect(linkHref).get();
													Elements pngs2 = doc2.select("div.mv_info_area div.poster a img");

													String linkHref2 = pngs2.attr("src");
													i = i + 1;
									%>
									<a href="/movieInfo.do?moviecode=<%=moviecode%>"> <img
										src="<%=linkHref2%>" class="poster" />
									</a> <br> <a href="/movieInfo.do?moviecode=<%=moviecode%>"
										class="moviename"> ${boxoffice.movieNm} </a>
								</div>
								<%
									} else if (i > 3 && i < 7) {
												if (i == 4) {
								%>
							</div>
							<div align="center" class="divline">
								<%
									}
												if (i == 5) {
								%>
								<div style="padding: 0 25px 60px 25px" class="movie">
									<%
										} else {
									%>
									<div class="movie">
										<%
											}
														String moviec2[] = moviec[i].split(", openDt");
														String movied2[] = movied[i].split("-");
														System.out.println(moviec2[0] + movied2[0]);
														if (moviec2[0].contains("%")) {
															String moviec3[] = moviec2[0].split("%");
															moviec2[0] = "";
															for (int hk = 0; hk < moviec3.length; hk++) {
																if (hk == moviec3.length - 1) {
																	moviec2[0] = moviec2[0] + moviec3[hk];
																} else {
																	moviec2[0] = moviec2[0] + moviec3[hk] + "%25";
																}
																if (moviec3.length - 1 == 0) {
																	moviec2[0] = moviec3[hk] + "%25";
																}
															}
														}
														if (moviec2[0].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
															moviec2[0] = "헨젤과 그레텔: 마녀 사냥꾼";
														}
														String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query="
																+ moviec2[0] + "&section=all&ie=utf8";
														System.out.println(link);
														Document doc = Jsoup.connect(link).get();

														Elements pngs = doc.select("ul.search_list_1 li dl");

														String[] png3 = new String[1];

														int tj = 0;
														int wpq = 0;
														for (Element pngs2 : pngs) {
															String con = pngs2.text();
															String con2[] = pngs2.toString().split("href=");

															String con3[] = con2[1].split(">");
															String conn = pngs2.toString();
															String con4[] = conn.split("<em class=\"" + "cuser_cnt" + "\">");
															String con5[] = con4[1].split("</em>");

															if (tj == 0) {
																wpq = con5[0].length();
																png3[0] = con3[0].substring(1, con3[0].length() - 1);
															}
															if (wpq <= con5[0].length()) {
																String con6[] = conn.split("year=");
																int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
																if (cnn2 <= Integer.parseInt(movied2[0]) && cnn2 >= Integer.parseInt(movied2[0]) - 4) {
																	wpq = con5[0].length();
																	System.out.println(wpq);
																	png3[0] = con3[0].substring(1, con3[0].length() - 1);
																}
															}
															tj = tj + 1;
															if (tj == 9) {
																break;
															}
														}

														String linkHref = "https://movie.naver.com/" + png3[0];
														String[] moviecodeout = linkHref.split("code=");
														moviecode = moviecodeout[1];
														Document doc2 = Jsoup.connect(linkHref).get();
														Elements pngs2 = doc2.select("div.mv_info_area div.poster a img");

														String linkHref2 = pngs2.attr("src");
														i = i + 1;
										%>
										<a href="/movieInfo.do?moviecode=<%=moviecode%>"> <img
											src="<%=linkHref2%>" class="poster" />
										</a> <br> <a href="/movieInfo.do?moviecode=<%=moviecode%>"
											class="moviename"> ${boxoffice.movieNm} </a>
									</div>
									<%
										} else {
									%>
									<%
										if (i == 7) {
									%>
								</div>
								<div align="center" class="divline">
									<%
										}
													if (i == 8) {
									%>
									<div class="movie" style="padding: 0 25px 30px 25px">
										<%
											} else {
										%>
										<div class="movie" style="padding: 0 0px 30px 0px">
											<%
												}
															String moviec2[] = moviec[i].split(", openDt");
															String movied2[] = movied[i].split("-");
															System.out.println(moviec2[0] + movied2[0]);
															if (moviec2[0].contains("%")) {
																String moviec3[] = moviec2[0].split("%");
																moviec2[0] = "";
																for (int hk = 0; hk < moviec3.length; hk++) {
																	if (hk == moviec3.length - 1) {
																		moviec2[0] = moviec2[0] + moviec3[hk];
																	} else {
																		moviec2[0] = moviec2[0] + moviec3[hk] + "%25";
																	}
																	if (moviec3.length - 1 == 0) {
																		moviec2[0] = moviec3[hk] + "%25";
																	}
																}
															}
															if (moviec2[0].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
																moviec2[0] = "헨젤과 그레텔: 마녀 사냥꾼";
															}
															String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query="
																	+ moviec2[0] + "&section=all&ie=utf8";
															System.out.println(link);
															Document doc = Jsoup.connect(link).get();

															Elements pngs = doc.select("ul.search_list_1 li dl");

															String[] png3 = new String[1];

															int tj = 0;
															int wpq = 0;
															for (Element pngs2 : pngs) {
																String con = pngs2.text();
																String con2[] = pngs2.toString().split("href=");

																String con3[] = con2[1].split(">");
																String conn = pngs2.toString();
																String con4[] = conn.split("<em class=\"" + "cuser_cnt" + "\">");
																String con5[] = con4[1].split("</em>");

																if (tj == 0) {
																	wpq = con5[0].length();
																	png3[0] = con3[0].substring(1, con3[0].length() - 1);
																}
																if (wpq <= con5[0].length()) {
																	String con6[] = conn.split("year=");
																	int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
																	if (cnn2 <= Integer.parseInt(movied2[0]) && cnn2 >= Integer.parseInt(movied2[0]) - 4) {

																		wpq = con5[0].length();
																		System.out.println(wpq);
																		png3[0] = con3[0].substring(1, con3[0].length() - 1);
																	}
																}
																tj = tj + 1;
																if (tj == 9) {
																	break;
																}

															}

															String linkHref = "https://movie.naver.com/" + png3[0];
															String[] moviecodeout = linkHref.split("code=");
															moviecode = moviecodeout[1];
															Document doc2 = Jsoup.connect(linkHref).get();
															Elements pngs2 = doc2.select("div.mv_info_area div.poster a img");

															String linkHref2 = pngs2.attr("src");
															i = i + 1;
											%>
											<a href="/movieInfo.do?moviecode=<%=moviecode%>"> <img
												src="<%=linkHref2%>" class="poster" />
											</a> <br> <a href="/movieInfo.do?moviecode=<%=moviecode%>"
												class="moviename"> ${boxoffice.movieNm} </a>
										</div>
										<%
											}
										%>
									
						</c:forEach>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>