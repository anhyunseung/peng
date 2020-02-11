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
	Date dt = new Date();
	Random randomGenerator = new Random();
	int year = dt.getYear() + 1900;
	int day = dt.getDate() - 1;
	int mon = dt.getMonth();

	int randomyearsub = year - 2010;
	int randomyear = randomGenerator.nextInt(randomyearsub);
	int randommonth = randomGenerator.nextInt(11);
	int randomday = randomGenerator.nextInt(30) + 1;

	if (randomyear == year) {
		if (randommonth > mon) {
			randomday = randomGenerator.nextInt(30) + 1;
		}
		if (randommonth == mon) {
			randomday = randomGenerator.nextInt(day) + 1;
		}
	}

	if (randommonth == 3 || randommonth == 5 || randommonth == 8 || randommonth == 10) {
		if (randomday == 31) {
			randomday = randomGenerator.nextInt(29) + 1;
		}
	}

	if (randommonth == 1) {
		if (randomday >= 29) {
			randomday = randomGenerator.nextInt(27) + 1;
		}
	}

	year = randomyear + 2010;
	mon = randommonth + 1;
	String month = "";
	if (mon < 10) {
		month = "0" + mon;
	} else {
		month = "" + mon;
	}

	day = randomday;
	String day2 = "";
	if (day < 10) {
		day2 = "0" + day;
	} else {
		day2 = "" + day;
	}
	String date = year + month + day2;
	System.out.println(date);

	String targetDt = date;
	String itemPerPage = request.getParameter("itemPerPage") == null
			? "10"
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
				<c:forEach items="${map.boxOfficeResult.dailyBoxOfficeList}"
					var="boxoffice">
					<%
					try{
						String moviec2[] = moviec[i].split(", openDt");
							String movied2[] = movied[i].split("-");
							System.out.println(moviec2[0] + " " + movied2[0]);
							if (moviec2[0].contains("<")){
								String moviec3[]=moviec2[0].split("<");
								moviec2[0] = "";
								for (int hk = 0; hk < moviec3.length; hk++) {
									moviec2[0] = moviec2[0] + moviec3[hk];
								}
							}
							if (moviec2[0].contains(">")){
								String moviec3[]=moviec2[0].split(">");
								moviec2[0] = "";
								for (int hk = 0; hk < moviec3.length; hk++) {
									moviec2[0] = moviec2[0] + moviec3[hk];
								}
							}
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
							if (movied2[0].length() > 4) {
								break;
							}
							if (moviec2[0].equals("헨젤과 그레텔: 마녀 사냥꾼 3D")) {
								moviec2[0] = "헨젤과 그레텔: 마녀 사냥꾼";
							}
							if (moviec2[0].equals("비정한 도시 감독판")) {
								moviec2[0] = "비정한 도시";
							}
							if (moviec2[0].equals("반지의 제왕 : 두개의 탑 (확장판)")) {
								moviec2[0] = "반지의 제왕 : 두개의 탑";
							}
							if (moviec2[0].equals("반지의 제왕 : 반지원정대 (확장판)")) {
								moviec2[0] = "반지의 제왕 : 반지원정대";
							}
							if (moviec2[0].equals("반지의 제왕 : 왕의 귀환 (확장판)")) {
								moviec2[0] = "반지의 제왕 : 왕의 귀환";
							}
							String movienameback = "";
							if (moviec2[0].equals("딥") || moviec2[0].equals("더 서클") || moviec2[0].equals("더 보이")
									|| moviec2[0].equals("레전드") || moviec2[0].equals("홈") || moviec2[0].equals("스파이")
									|| moviec2[0].equals("신들의 전쟁") || moviec2[0].equals("블라인드") || moviec2[0].equals("레지던트")
									|| moviec2[0].equals("레드") || moviec2[0].equals("골든 슬럼버")) {
								movienameback = moviec2[0];
								moviec2[0] = moviec2[0] + movied2[0];
							}
							if (moviec2[0].equals("라이언") || moviec2[0].equals("그녀") || moviec2[0].equals("슈퍼히어로")
									|| moviec2[0].equals("눈의 여왕")) {
								movienameback = moviec2[0];
								moviec2[0] = moviec2[0] + (Integer.parseInt(movied2[0]) - 1);
							}
							if (moviec2[0].equals("비지터") || moviec2[0].equals("파라노말 액티비티")) {
								moviec2[0] = moviec2[0] + "2007";
							}
							if (moviec2[0].equals("노트북")) {
								movienameback = moviec2[0];
								moviec2[0] = moviec2[0] + 2004;
							}
							if (moviec2[0].equals("러브 액츄얼리")) {
								movienameback = moviec2[0];
								moviec2[0] = moviec2[0] + 2003;
							}
							if (moviec2[0].equals("마스터 ") && (Integer.parseInt(movied2[0]) == 2013)) {
								movienameback = moviec2[0];
								moviec2[0] = moviec2[0] + (Integer.parseInt(movied2[0]) - 1);
							}
							String link = "https://movie.naver.com/movie/search/result.nhn?section=movie&query=" + moviec2[0]
									+ "&section=all&ie=utf8";
							if (moviec2[0].equals(movienameback + movied2[0])
									|| moviec2[0].equals(movienameback + (Integer.parseInt(movied2[0]) - 1))
									|| moviec2[0].equals(movienameback + 2004) || moviec2[0].equals(movienameback + 2003)
									|| moviec2[0].equals(movienameback + 2007)) {
								moviec2[0] = movienameback;
							}
							if (moviec2[0].contains("%25")) {
								moviec2[0] = moviec2[0].replaceAll("%25", "%");
							}
							if (moviec2[0].contains("%26")) {
								moviec2[0] = moviec2[0].replaceAll("%26", "&");
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
									if (moviec2[0].equals("데블")) {
										tj = 7;
									}
								}
								if (wpq <= con5[0].length() || moviec2[0].equals("가디언즈 오브 갤럭시") || moviec2[0].equals("개구쟁이 스머프")) {
									String con6[] = conn.split("year=");
									int cnn2 = Integer.parseInt(con6[1].substring(0, 4));
									if (cnn2 <= Integer.parseInt(movied2[0]) && cnn2 >= Integer.parseInt(movied2[0]) - 4) {
										wpq = con5[0].length();
										System.out.println(wpq);
										png3[0] = con3[0].substring(1, con3[0].length() - 1);
									}
								}
								tj = tj + 1;
								if (tj == 9 || moviec2[0].equals("패션왕") || moviec2[0].equals("콜드 워") || moviec2[0].equals("그것")
										|| moviec2[0].equals("더 플랜") || moviec2[0].equals("링스") || moviec2[0].equals("눈길")
										|| moviec2[0].equals("그레이트 월") || moviec2[0].equals("트롤") || moviec2[0].equals("선생님의 일기")
										|| moviec2[0].equals("대결") || moviec2[0].equals("빅") || moviec2[0].equals("부활")
										|| moviec2[0].equals("괴물의 아이") || moviec2[0].equals("카트") || moviec2[0].equals("이브 생 로랑")
										|| moviec2[0].equals("살인자") || moviec2[0].equals("링컨") || moviec2[0].equals("더 자이언트")
										|| moviec2[0].equals("용의자X") || moviec2[0].equals("나는 왕이로소이다") || moviec2[0].equals("50/50")
										|| moviec2[0].equals("레지던트") || moviec2[0].equals("발렌타인 데이")
										|| moviec2[0].equals("공주와 개구리")) {
									break;
								}
							}

							String linkHref = "https://movie.naver.com/" + png3[0];
							String[] moviecodeout = linkHref.split("code=");
							moviecode = moviecodeout[1];
							Document doc2 = Jsoup.connect(linkHref).get();
							Elements pngs2 = doc2.select("div.mv_info_area div.poster a img");
							String linkHref2 = pngs2.attr("src");
							String bigimg = "https://movie.naver.com/movie/bi/mi/photoViewPopup.nhn?movieCode=" + moviecode;
							Document doc3 = Jsoup.connect(bigimg).get();
							Elements pngs3 = doc3.select("div#page_content a img#targetImage");
							String bigimg2 = pngs3.attr("src");
							i = i + 1;
					%>
					<div class="mainmenu"
						style="background-image: url('<%=bigimg2%>');">
							<div class="mainmenuin">
								<span class="moviename" style="color: white; font-weight: bold;">
								<a href="/movieInfo.do?moviecode=<%=moviecode%>" class="user">
									<font face='Malgun Gothic' size="10px">
										${boxoffice.movieNm}</font>
										</a>
										 <br />
								<br /> 
								<a href="/movieInfo.do?moviecode=<%=moviecode%>">
								<font face='Malgun Gothic' size="3px" class="namefont">
										랜덤 추천 결과 입니다.</font>
								</a>
								</span> 
								<a href="/movieInfo.do?moviecode=<%=moviecode%>">
								<img class="movieimg" src="<%=linkHref2%>">
								</a>
							</div>
					</div>
					<%}catch (Exception e) {
						// TODO: handle exception
					%>
					<script>
					location.href = "/top.do";
					</script>
					<%} %>
				</c:forEach>
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