<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
@font-face {
	font-family: KoPubGothic;
	src: url('KoPubDotumMedium.ttf') format('truetype');
}

body {
	font-family: KoPubGothic, 'NanumGothic';
}
#back{
	color:white;
	font-size:6em;
	margin-top:350px;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int score= Integer.parseInt(request.getParameter("s"));
	int d= Integer.parseInt(request.getParameter("d"));
	
	int[] s=new int[5];
	
	try {
		String filePath = application.getRealPath("/WEB-INF/score.txt");
		BufferedReader reader = new BufferedReader(new FileReader(filePath));
		String str="";
		int i=0;
		
		while (true) {
			str = reader.readLine();
			if (str == null)
				break;
			s[i++]=Integer.parseInt(str);
		}
		reader.close();
	} catch (Exception e) {
		System.out.println(e.toString());
	}
	
	if(s[(d/5)-1]<score) {
		s[(d/5)-1]=score;
		System.out.println("얍");
	}
	
	try {
		String filePath = application.getRealPath("/WEB-INF/score.txt");
		PrintWriter wr = new PrintWriter(new FileWriter(filePath));
		BufferedWriter bw = new BufferedWriter(wr);

		for(int i=0;i<5;i++){
			bw.write(Integer.toString(s[i]));
			if(i<4)bw.newLine();
		}
		bw.close();
		wr.flush();

	} catch (Exception e) {
	}
	
	String str="";
	String strAll="";
	int cnt=0;
	//오늘 날짜 저장
	try {
		String filePath = application.getRealPath("/WEB-INF/day.txt");
		BufferedReader reader = new BufferedReader(new FileReader(filePath));
		
		while (true) {
			str = reader.readLine();
			if (str == null)
				break;
			strAll += (str + " ");
			cnt++;
		}
		reader.close();

	} catch (Exception e) {
	}

	Date day = new Date();//오늘 날짜
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(day);

	if (!strAll.contains(today)&&cnt==d-1) {
		try {
			String filePath = application.getRealPath("/WEB-INF/day.txt");
			PrintWriter writer = new PrintWriter(new FileWriter(filePath, true));
			BufferedWriter bw = new BufferedWriter(writer);

			bw.newLine();
			bw.write(today);
			bw.close();
			writer.flush();

		} catch (Exception e) {
		}
	}
%>

<div style="background: url('resources/gameEnd.png'); background-repeat: no-repeat; width: 1330px; height: 100%; margin: auto; border: 15px solid #333538; border-radius: 10px;">
	<div id="back"><%= score %></div>
	<a href="main.jsp"><img src='resources/gomain.png' style="margin-top: 74px; cursor: pointer;"></a>
</div>
</body>
</html>