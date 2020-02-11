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
	session.setAttribute("url", "/upmovie/upmovieList.do");
	String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
	String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
	String SES_year = CmmUtil.nvl((String) session.getAttribute("upmyear"));
	String SES_month = CmmUtil.nvl((String) session.getAttribute("upmmonth"));
	System.out.println("ss_user_no : " + CmmUtil.nvl((String) session.getAttribute("USER_NO")));
	System.out.println("ss_user_id : " + SESSION_USER_ID);

	int count = (int) request.getAttribute("count");
	System.out.println("count : " + count);

	Date dt = new Date();
	dt.setDate(dt.getDate() - 4);
	int year3 = dt.getYear() + 1900;
	int mon3 = dt.getMonth() + 1;
	int day3 = dt.getDate();

	if (SES_year.isEmpty()) {
		SES_year = year3 + "";
	}
	if (SES_month.isEmpty()) {
		SES_month = mon3 + "";
	}

	int year1 = Integer.parseInt(SES_year);
	int mon1 = Integer.parseInt(SES_month);
	int day1 = 1;

	int day4 = 28;
	int i = 0;
	int n = mon1 + 1;

	String month = "";
	String day2 = "";

	day4 = 28;
	String[] date1 = new String[7];

	for (mon1 = Integer.parseInt(SES_month); mon1 <= n; mon1++) {
		if (mon1 == n) {
			day4 = 1;
		}
		if (Integer.parseInt(SES_year) == year3 && Integer.parseInt(SES_month) == mon3) {
			n = mon1;
			day4 = day3;
		}

		for (day1 = 1; day1 <= day4; day1 = day1 + 5) {

			if (mon1 < 10) {
				month = "0" + mon1;
			} else {
				month = "" + mon1;
			}

			if (day1 < 10) {
				day2 = "0" + day1;
			} else {
				day2 = "" + day1;
			}
			date1[i] = year1 + month + day2;
			System.out.println(date1[i] + " " + i);
			i++;
		}
	}

	mon1 = Integer.parseInt(SES_month);
	int q = 0;
	String mon5 = "";
	if (mon1 < 10) {
		mon5 = "0" + mon1;
	} else {
		mon5 = "" + mon1;
	}

	String[] moviename22 = new String[50];
	for (int c = 0; c < i; c++) {

		String targetDt = date1[c];
		String itemPerPage = "10";
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
		String moviecc[] = movie.split("openDt=");

		int a = 0;

		for (int con = 1; con < moviec.length; con++) {
			String moviec2[] = moviec[con].split(",");
			a = a + 1;
		}

		String[] moviename = new String[a];
		for (int con = 1; con < moviec.length; con++) {
			String moviec2[] = moviec[con].split(", openDt=");
			String moviecc2[] = moviecc[con].split(",");
			if (moviecc2[0].equals(" ")) {

			} else {
				String openDTy = moviecc2[0].substring(5, 7);
				if (openDTy.equals(mon5)) { //1월이면
					int nn = 0;
					moviename22[q] = "";
					for (int ad = 0; ad <= q; ad++) { //중복있는지 확인한다
						if (moviename22[ad].equals(moviec2[0])) {
							nn = 1;
						}
					}
					if (nn == 0) {
						moviename22[q] = moviec2[0];
						System.out.println(moviename22[q] + " " + (q));
						q = q + 1;
					}
				}
				if (q > count * 9 + 9) {
					break;
				}
			}
		}
	}
	i = 1;
	String moviecode = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon"
	href="http://localhost:8080/upmovie/upmovieList.do/../../img/common/icon.ico"
	type="image/x-icon" />
<title><%=SES_year%>년 <%=SES_month%>월 추천영화 : Lovie</title>
<script type="text/javascript">
function doSubmit(s) {
	var now = new Date();
	now.setDate(now.getDate()-1);
	var nowY = now.getFullYear();
	var nowM = now.getMonth()+1;
	   if(s.year.value == nowY){
		   if(s.month.value>nowM){
	      alert("아직 개봉되지 않은 날자입니다.");
	      s.month.focus();
	      return false;
		   }
	   }
}
</script>
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

.select{
	outline-color: #888888;
	height: 28px;
	width: 65px;
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
<form name="s" method="post" action="/upmovie/upmovieDate.do" style="height: 100%;" onsubmit="return doSubmit(this);">
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
							href="/user/userInfo.do" " class="user"> <%=SESSION_USER_ID%>
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
						src="../img/total/listupmo2.jpg">
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
						<b>추천영화</b>
					</font>
				</div>
				<div align="right" style="padding: 0 0 5px 0;">
				<div style="vertical-align: bottom;">
				<select name="year" class="select">
			<%for(int cyear=year3;cyear>=2010;cyear--) {%>
			 <option value="<%=cyear%>" 
			 <%if(cyear==Integer.parseInt(SES_year)){%>
			 selected="selected"
			 <%} %>
			 ><%=cyear%></option>
			 <%} %>
            </select>
            <font face='Malgun Gothic' size="4px" style="color: #555555;">
						<b>년</b>
					</font>
            <select name="month" class="select" style="width: 45px">
			<%for(int cmonth=1;cmonth<=12;cmonth++) {%>
			 <option value="<%=cmonth%>"
			 <%if(cmonth==Integer.parseInt(SES_month)){%>
			 selected="selected"
			 <%} %>
			 ><%=cmonth%></option>
			 <%} %>
            </select>
            <font face='Malgun Gothic' size="4px" style="color: #555555;">
						<b>월</b>
					</font>
			</div>
			<div style="vertical-align: bottom;">
            <button  type="submit" style="background-color: rgba(0,0,0,0); 
				border: 0; outline:0; width:64px; height: 29px; margin: 0 6px 0 0;">
				<img style="cursor: pointer;" src="../img/button/sign.png"
							onmouseover="this.src='../img/button/sign2.png'"
							onmouseout="this.src='../img/button/sign.png'" />
				</button>
			</div>
            </div>
				<div style="height: 3px; background-color: #dddddd;"></div>
				<div style="height: 20px;"></div>
				<div align="center" class="divline">
					<%
						int count2 = 9 + count * 9;
						if (count2 >= q) {
							count2 = q;
						}
						for (int qe = count * 9; qe < count2; qe++) {
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
								System.out.println(moviename22[qe] + " " + year1);
										if (moviename22[qe].contains("%")) {
											moviename22[qe] = moviename22[qe].replaceAll("%", "%25");
										}
										if (moviename22[qe].contains("&")) {
											moviename22[qe] = moviename22[qe].replaceAll("&", "%26");
										}
										if (moviename22[qe].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
											moviename22[qe] = "헨젤과 그레텔: 마녀 사냥꾼";
										}
										if (moviename22[qe].equals("비정한 도시 감독판")) {
											moviename22[qe] = "비정한 도시";
										}
										if (moviename22[qe].equals("반지의 제왕 : 두개의 탑 (확장판)")) {
											moviename22[qe] = "반지의 제왕 : 두개의 탑";
										}
										if (moviename22[qe].equals("반지의 제왕 : 반지원정대 (확장판)")) {
											moviename22[qe] = "반지의 제왕 : 반지원정대";
										}
										if (moviename22[qe].equals("반지의 제왕 : 왕의 귀환 (확장판)")) {
											moviename22[qe] = "반지의 제왕 : 왕의 귀환";
										}
										String movienameback = "";
										if (moviename22[qe].equals("딥") || moviename22[qe].equals("더 서클") || moviename22[qe].equals("더 보이")
												|| moviename22[qe].equals("홈") || moviename22[qe].equals("레전드")
												|| moviename22[qe].equals("스파이") || moviename22[qe].equals("신들의 전쟁")
												|| moviename22[qe].equals("블라인드") || moviename22[qe].equals("레지던트")
												|| moviename22[qe].equals("레드") || moviename22[qe].equals("골든 슬럼버")) {
											movienameback = moviename22[qe];
											moviename22[qe] = moviename22[qe] + year1;
										}
										if (moviename22[qe].equals("라이언") || moviename22[qe].equals("그녀") || moviename22[qe].equals("슈퍼히어로")
												|| moviename22[qe].equals("눈의 여왕")) {
											movienameback = moviename22[qe];
											moviename22[qe] = moviename22[qe] + (year1 - 1);
										}
										if (moviename22[qe].equals("비지터") || moviename22[qe].equals("파라노말 액티비티")) {
											moviename22[qe] = moviename22[qe] + "2007";
										}

										if (moviename22[qe].equals("노트북")) {
											movienameback = moviename22[qe];
											moviename22[qe] = moviename22[qe] + 2004;
										}
										if (moviename22[qe].equals("러브 액츄얼리")) {
											movienameback = moviename22[qe];
											moviename22[qe] = moviename22[qe] + 2003;
										}
										if (moviename22[qe].equals("마스터 ") && year1 == 2013) {
											movienameback = moviename22[qe];
											moviename22[qe] = moviename22[qe] + (year1 - 1);
										}
										String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query="
												+ moviename22[qe] + "&section=all&ie=utf8";
										if (moviename22[qe].equals(movienameback + year1)
												|| moviename22[qe].equals(movienameback + (year1 - 1))
												|| moviename22[qe].equals(movienameback + 2004)
												|| moviename22[qe].equals(movienameback + 2003)
												|| moviename22[qe].equals(movienameback + 2007)) {
											moviename22[qe] = movienameback;
										}
										if (moviename22[qe].contains("%25")) {
											moviename22[qe] = moviename22[qe].replaceAll("%25", "%");
										}
										if (moviename22[qe].contains("%26")) {
											moviename22[qe] = moviename22[qe].replaceAll("%26", "&");
										}
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
												if (moviename22[qe].equals("데블")) {
													tj = 7;
												}
											}
											if (wpq <= con5[0].length() || moviename22[qe].equals("가디언즈 오브 갤럭시")
													|| moviename22[qe].equals("개구쟁이 스머프")) {
												String con6[] = conn.split("year=");
												int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
												if (cnn2 <= year1 && cnn2 >= year1 - 4) {
													wpq = con5[0].length();
													System.out.println(wpq);
													png3[0] = con3[0].substring(1, con3[0].length() - 1);
												}
											}
											tj = tj + 1;
											if (tj == 9 || moviename22[qe].equals("패션왕") || moviename22[qe].equals("콜드 워")
													|| moviename22[qe].equals("그것") || moviename22[qe].equals("더 플랜")
													|| moviename22[qe].equals("링스") || moviename22[qe].equals("눈길")
													|| moviename22[qe].equals("그레이트 월") || moviename22[qe].equals("트롤")
													|| moviename22[qe].equals("선생님의 일기") || moviename22[qe].equals("대결")
													|| moviename22[qe].equals("빅") || moviename22[qe].equals("부활")
													|| moviename22[qe].equals("괴물의 아이") || moviename22[qe].equals("카트")
													|| moviename22[qe].equals("이브 생 로랑") || moviename22[qe].equals("살인자")
													|| moviename22[qe].equals("링컨") || moviename22[qe].equals("더 자이언트")
													|| moviename22[qe].equals("용의자X") || moviename22[qe].equals("나는 왕이로소이다")
													|| moviename22[qe].equals("50/50") || moviename22[qe].equals("레지던트")
													|| moviename22[qe].equals("발렌타인 데이") || moviename22[qe].equals("공주와 개구리")) {
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
								class="moviename"> <%=moviename22[qe]%>
							</a>
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
											System.out.println(moviename22[qe] + " " + year1);
											if (moviename22[qe].contains("%")) {
												String moviec3[] = moviename22[qe].split("%");
												moviename22[qe] = "";
												for (int hk = 0; hk < moviec3.length; hk++) {
													if (hk == moviec3.length - 1) {
														moviename22[qe] = moviename22[qe] + moviec3[hk];
													} else {
														moviename22[qe] = moviename22[qe] + moviec3[hk] + "%25";
													}
													if (moviec3.length - 1 == 0) {
														moviename22[qe] = moviec3[hk] + "%25";
													}
												}
											}
											if (moviename22[qe].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
												moviename22[qe] = "헨젤과 그레텔: 마녀 사냥꾼";
											}
											if (moviename22[qe].equals("비정한 도시 감독판")) {
												moviename22[qe] = "비정한 도시";
											}
											if (moviename22[qe].equals("반지의 제왕 : 두개의 탑 (확장판)")) {
												moviename22[qe] = "반지의 제왕 : 두개의 탑";
											}
											if (moviename22[qe].equals("반지의 제왕 : 반지원정대 (확장판)")) {
												moviename22[qe] = "반지의 제왕 : 반지원정대";
											}
											if (moviename22[qe].equals("반지의 제왕 : 왕의 귀환 (확장판)")) {
												moviename22[qe] = "반지의 제왕 : 왕의 귀환";
											}
											String movienameback = "";
											if (moviename22[qe].equals("딥") || moviename22[qe].equals("더 서클") || moviename22[qe].equals("더 보이")
													|| moviename22[qe].equals("홈") || moviename22[qe].equals("레전드")
													|| moviename22[qe].equals("스파이") || moviename22[qe].equals("신들의 전쟁")
													|| moviename22[qe].equals("블라인드") || moviename22[qe].equals("레지던트")
													|| moviename22[qe].equals("레드") || moviename22[qe].equals("골든 슬럼버")) {
												movienameback = moviename22[qe];
												moviename22[qe] = moviename22[qe] + year1;
											}
											if (moviename22[qe].equals("라이언") || moviename22[qe].equals("그녀") || moviename22[qe].equals("슈퍼히어로")
													|| moviename22[qe].equals("눈의 여왕")) {
												movienameback = moviename22[qe];
												moviename22[qe] = moviename22[qe] + (year1 - 1);
											}
											if (moviename22[qe].equals("비지터") || moviename22[qe].equals("파라노말 액티비티")) {
												moviename22[qe] = moviename22[qe] + "2007";
											}

											if (moviename22[qe].equals("노트북")) {
												movienameback = moviename22[qe];
												moviename22[qe] = moviename22[qe] + 2004;
											}
											if (moviename22[qe].equals("러브 액츄얼리")) {
												movienameback = moviename22[qe];
												moviename22[qe] = moviename22[qe] + 2003;
											}
											if (moviename22[qe].equals("마스터 ") && year1 == 2013) {
												movienameback = moviename22[qe];
												moviename22[qe] = moviename22[qe] + (year1 - 1);
											}
											String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query="
													+ moviename22[qe] + "&section=all&ie=utf8";
											if (moviename22[qe].equals(movienameback + year1)
													|| moviename22[qe].equals(movienameback + (year1 - 1))
													|| moviename22[qe].equals(movienameback + 2004)
													|| moviename22[qe].equals(movienameback + 2003)
													|| moviename22[qe].equals(movienameback + 2007)) {
												moviename22[qe] = movienameback;
											}
											if (moviename22[qe].contains("%25")) {
												moviename22[qe] = moviename22[qe].replaceAll("%25", "%");
											}
											if (moviename22[qe].contains("%26")) {
												moviename22[qe] = moviename22[qe].replaceAll("%26", "&");
											}
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
													if (moviename22[qe].equals("데블")) {
														tj = 7;
													}
												}
												if (wpq <= con5[0].length() || moviename22[qe].equals("가디언즈 오브 갤럭시")
														|| moviename22[qe].equals("개구쟁이 스머프")) {
													String con6[] = conn.split("year=");
													int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
													if (cnn2 <= year1 && cnn2 >= year1 - 4) {
														wpq = con5[0].length();
														System.out.println(wpq);
														png3[0] = con3[0].substring(1, con3[0].length() - 1);
													}
												}
												tj = tj + 1;
												if (tj == 9 || moviename22[qe].equals("패션왕") || moviename22[qe].equals("콜드 워")
														|| moviename22[qe].equals("그것") || moviename22[qe].equals("더 플랜")
														|| moviename22[qe].equals("링스") || moviename22[qe].equals("눈길")
														|| moviename22[qe].equals("그레이트 월") || moviename22[qe].equals("트롤")
														|| moviename22[qe].equals("선생님의 일기") || moviename22[qe].equals("대결")
														|| moviename22[qe].equals("빅") || moviename22[qe].equals("부활")
														|| moviename22[qe].equals("괴물의 아이") || moviename22[qe].equals("카트")
														|| moviename22[qe].equals("이브 생 로랑") || moviename22[qe].equals("살인자")
														|| moviename22[qe].equals("링컨") || moviename22[qe].equals("더 자이언트")
														|| moviename22[qe].equals("용의자X") || moviename22[qe].equals("나는 왕이로소이다")
														|| moviename22[qe].equals("50/50") || moviename22[qe].equals("레지던트")
														|| moviename22[qe].equals("발렌타인 데이") || moviename22[qe].equals("공주와 개구리")) {
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
									class="moviename"> <%=moviename22[qe]%>
								</a>
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
												System.out.println(moviename22[qe] + " " + year1);
												if (moviename22[qe].contains("%")) {
													String moviec3[] = moviename22[qe].split("%");
													moviename22[qe] = "";
													for (int hk = 0; hk < moviec3.length; hk++) {
														if (hk == moviec3.length - 1) {
															moviename22[qe] = moviename22[qe] + moviec3[hk];
														} else {
															moviename22[qe] = moviename22[qe] + moviec3[hk] + "%25";
														}
														if (moviec3.length - 1 == 0) {
															moviename22[qe] = moviec3[hk] + "%25";
														}
													}
												}
												if (moviename22[qe].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
													moviename22[qe] = "헨젤과 그레텔: 마녀 사냥꾼";
												}
												if (moviename22[qe].equals("비정한 도시 감독판")) {
													moviename22[qe] = "비정한 도시";
												}
												if (moviename22[qe].equals("반지의 제왕 : 두개의 탑 (확장판)")) {
													moviename22[qe] = "반지의 제왕 : 두개의 탑";
												}
												if (moviename22[qe].equals("반지의 제왕 : 반지원정대 (확장판)")) {
													moviename22[qe] = "반지의 제왕 : 반지원정대";
												}
												if (moviename22[qe].equals("반지의 제왕 : 왕의 귀환 (확장판)")) {
													moviename22[qe] = "반지의 제왕 : 왕의 귀환";
												}
												String movienameback = "";
												if (moviename22[qe].equals("딥") || moviename22[qe].equals("더 서클") || moviename22[qe].equals("더 보이")
														|| moviename22[qe].equals("홈") || moviename22[qe].equals("레전드")
														|| moviename22[qe].equals("스파이") || moviename22[qe].equals("신들의 전쟁")
														|| moviename22[qe].equals("블라인드") || moviename22[qe].equals("레지던트")
														|| moviename22[qe].equals("레드") || moviename22[qe].equals("골든 슬럼버")) {
													movienameback = moviename22[qe];
													moviename22[qe] = moviename22[qe] + year1;
												}
												if (moviename22[qe].equals("라이언") || moviename22[qe].equals("그녀") || moviename22[qe].equals("슈퍼히어로")
														|| moviename22[qe].equals("눈의 여왕")) {
													movienameback = moviename22[qe];
													moviename22[qe] = moviename22[qe] + (year1 - 1);
												}
												if (moviename22[qe].equals("비지터") || moviename22[qe].equals("파라노말 액티비티")) {
													moviename22[qe] = moviename22[qe] + "2007";
												}

												if (moviename22[qe].equals("노트북")) {
													movienameback = moviename22[qe];
													moviename22[qe] = moviename22[qe] + 2004;
												}
												if (moviename22[qe].equals("러브 액츄얼리")) {
													movienameback = moviename22[qe];
													moviename22[qe] = moviename22[qe] + 2003;
												}
												if (moviename22[qe].equals("마스터 ") && year1 == 2013) {
													movienameback = moviename22[qe];
													moviename22[qe] = moviename22[qe] + (year1 - 1);
												}
												String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query="
														+ moviename22[qe] + "&section=all&ie=utf8";
												if (moviename22[qe].equals(movienameback + year1)
														|| moviename22[qe].equals(movienameback + (year1 - 1))
														|| moviename22[qe].equals(movienameback + 2004)
														|| moviename22[qe].equals(movienameback + 2003)
														|| moviename22[qe].equals(movienameback + 2007)) {
													moviename22[qe] = movienameback;
												}
												if (moviename22[qe].contains("%25")) {
													moviename22[qe] = moviename22[qe].replaceAll("%25", "%");
												}
												if (moviename22[qe].contains("%26")) {
													moviename22[qe] = moviename22[qe].replaceAll("%26", "&");
												}
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
														if (moviename22[qe].equals("데블")) {
															tj = 7;
														}
													}
													if (wpq <= con5[0].length() || moviename22[qe].equals("가디언즈 오브 갤럭시")
															|| moviename22[qe].equals("개구쟁이 스머프")) {
														String con6[] = conn.split("year=");
														int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
														if (cnn2 <= year1 && cnn2 >= year1 - 4) {
															wpq = con5[0].length();
															System.out.println(wpq);
															png3[0] = con3[0].substring(1, con3[0].length() - 1);
														}
													}
													tj = tj + 1;
													if (tj == 9 || moviename22[qe].equals("패션왕") || moviename22[qe].equals("콜드 워")
															|| moviename22[qe].equals("그것") || moviename22[qe].equals("더 플랜")
															|| moviename22[qe].equals("링스") || moviename22[qe].equals("눈길")
															|| moviename22[qe].equals("그레이트 월") || moviename22[qe].equals("트롤")
															|| moviename22[qe].equals("선생님의 일기") || moviename22[qe].equals("대결")
															|| moviename22[qe].equals("빅") || moviename22[qe].equals("부활")
															|| moviename22[qe].equals("괴물의 아이") || moviename22[qe].equals("카트")
															|| moviename22[qe].equals("이브 생 로랑") || moviename22[qe].equals("살인자")
															|| moviename22[qe].equals("링컨") || moviename22[qe].equals("더 자이언트")
															|| moviename22[qe].equals("용의자X") || moviename22[qe].equals("나는 왕이로소이다")
															|| moviename22[qe].equals("50/50") || moviename22[qe].equals("레지던트")
															|| moviename22[qe].equals("발렌타인 데이") || moviename22[qe].equals("공주와 개구리")) {
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
										class="moviename"> <%=moviename22[qe]%>
									</a>
							</div>
								<%
									}
									}
								%>
						</div>
					<%if(i!=1){%>
					<div style="height: 3px; background-color: #dddddd;"></div>
					<div style="height: 15px"></div>
					<%} %>
					<div align="center" class="divline">
						<div style="height: 30px;">
								<%
									if (count >= 1) {
								%>
								<a href="upmovieList.do?count=<%=count - 1%>"> 
									<img src="../img/button/before.png"
									onmouseover="this.src='../img/button/before2.png'"
									onmouseout="this.src='../img/button/before.png'">
								</a>
								<%
									}
									if (q > (count + 1) * 9) {
								%>
								<a href="upmovieList.do?count=<%=count + 1%>">
								<img src="../img/button/next.png"
									onmouseover="this.src='../img/button/next2.png'"
									onmouseout="this.src='../img/button/next.png'">
								</a>
								<%
									}
								%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	</body>
</html>