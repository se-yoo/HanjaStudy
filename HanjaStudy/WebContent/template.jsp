<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title>한자공부</title>
<style>
	@font-face{
		font-family:KoPubGothic;
		src:url('KoPubDotumMedium.ttf') format('truetype');
	}
	body{
		font-family:KoPubGothic,'NanumGothic';
		width:100%;
		margin:0px;
		color:#333538;
	}
	#table{
		/*background-color:#ecba03;노란색*/
		height:950px;
		border:0px;
		margin:0px;
		width:100%;
	}
</style>
</head>
<body>
<%
	String contentpage=request.getParameter("CONTENTPAGE");
%>
<table id="table" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td style="width:90%;text-align:center;">
		<a href="main.jsp"><img src="resources/title.PNG"></a>
	</td>
</tr>
<tr height="75%" style="vertical-align:top;">
	<td style="text-align:center;">
		<jsp:include page="<%= contentpage %>"></jsp:include>
	</td>
</tr>
<tr height="5%">
	<td colspan="2" style="text-align:center;">
		<jsp:include page="bottom.jsp" flush="false"/>
	</td>
</tr>
</table>
</body>
</html>