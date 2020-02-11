<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Let's see the movie! : Lovie</title>
	<link rel="stylesheet" type="text/css" href="/css/tiles.css"/>
</head>
<body>
	<div class="body">
		<div class="header"><tiles:insertAttribute name="header" /></div>
		<div class="left"><tiles:insertAttribute name="left" /></div>
		<div class="main"><tiles:insertAttribute name="body" /></div>
		<div class="footer"><tiles:insertAttribute name="footer" /></div>
	</div>
</body>
<script type="text/javascript" src="/js/jquery/jquery-3.2.1.min.js"></script>
</html>