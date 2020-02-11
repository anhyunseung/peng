<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil"%>
<%
   //전달받은 메시지
   String msg = CmmUtil.nvl((String) request.getAttribute("msg"));
   String url = CmmUtil.nvl((String) request.getAttribute("url"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="shortcut icon" href="http://localhost:8080/MsgToList.do/../../img/common/icon.ico" type="image/x-icon" />
<title>처리 중 : Lovie</title>
<script type="text/javascript">

<%if(msg==""){%>
   top.location.href="<%=url%>";
<%}else{%>
   alert("<%=msg%>");
   top.location.href="<%=url%>";
<%}%>
</script>
</head>
<body>

</body>
</html>