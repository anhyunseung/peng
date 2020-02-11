<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="poly.util.CmmUtil"%>
<%
   //전달받은 메시지
   String url = CmmUtil.nvl((String) session.getAttribute("url"));
if(url.isEmpty()){
	url="/top.do";
}
   session.setAttribute("url", "");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/user/user_logout.do/../../img/common/icon.ico" type="image/x-icon" />
<title>로그아웃 : Lovie</title>
<script type="text/javascript">
   alert("로그아웃을 하였습니다");
   top.location.href="<%=url%>";
</script>
</head>
<body>

</body>
</html>