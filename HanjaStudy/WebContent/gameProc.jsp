<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
</head>
<style>
@font-face {
	font-family: KoPubGothic;
	src: url('KoPubDotumMedium.ttf') format('truetype');
}

body {
	font-family: KoPubGothic, 'NanumGothic';
}
</style>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		int a = Integer.parseInt(request.getParameter("DAY"));

	%>
	<div
		style="background: url('resources/gameExplain.png'); background-repeat: no-repeat; width: 1330px; height: 100%; margin: auto; border: 15px solid #ecba03; border-radius: 10px;">
			
			<a href="gameStart.jsp?DAY=<%=a%>"><img src='resources/gameBt.png'
				style="margin-top: 530px; cursor: pointer;"></a>
	</div>
</body>
</html>