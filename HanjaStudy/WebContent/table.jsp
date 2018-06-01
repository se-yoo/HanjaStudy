<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
span.day {
	color: #ecba03;
	font-weight: bold;
}

p.h {
	font-size: 1.2em;
}

span.hanja {
	color: #ffffff;
	text-shadow: -2px 1px 0 #ecba03, -1px 1px 0 #ecba03, -2px -1px 0 #ecba03,
		-1px -1px 0 #ecba03, 0px 0px 0 #ecba03, 1px 1px 0 #ecba03, 2px 1px 0
		#ecba03, 1px -1px 0 #ecba03, 2px -1px 0 #ecba03;
}
</style>
</head>
<body>
	<%
		BufferedReader reader = null;
		String str = "";
		String strAll = "";
		int dayCnt = 0;
		int tableDayCnt = 0;
		String[] day = new String[20];
		int index = 0;
		boolean todayLearn = false;
		int[] score = new int[5];

		try {
			String filePath = application.getRealPath("/WEB-INF/day.txt");
			reader = new BufferedReader(new FileReader(filePath));

			while (true) {
				str = reader.readLine();
				if (str == null)
					break;
				strAll += (str + "\n");
				day[index] = str;
				index++;
				dayCnt++;
			}

		} catch (Exception e) {
			out.println("파일을 읽을 수 없습니다.");
		}

		try {
			String filePath = application.getRealPath("/WEB-INF/score.txt");
			reader = new BufferedReader(new FileReader(filePath));
			int i = 0;
			while (true) {
				str = reader.readLine();
				if (str == null)
					break;
				score[i] = Integer.parseInt(str);
				i++;
			}

		} catch (Exception e) {
			out.println("0파일을 읽을 수 없습니다.");
		}

		Date d = new Date();//오늘 날짜
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(d);

		if (strAll.contains(today))
			todayLearn = true;
		if (!todayLearn)
			dayCnt++;

		String[] hanja = new String[20];
		int index2 = 0;
		try {
			String filePath = application.getRealPath("/WEB-INF/배운사자성어.txt");
			reader = new BufferedReader(new FileReader(filePath));

			while (true) {
				str = reader.readLine();
				if (str == null)
					break;
				hanja[index2] = str.replace("_", "</span>");
				index2++;
			}

		} catch (Exception e) {
			out.println("파일1을 읽을 수 없습니다.");
		}

		int hanCnt = 0;
		try {
			String filePath = application.getRealPath("/WEB-INF/배운한자.txt");
			reader = new BufferedReader(new FileReader(filePath));

			while (true) {
				str = reader.readLine();
				if (str == null)
					break;
				hanCnt++;
			}

		} catch (Exception e) {
			out.println("파일2을 읽을 수 없습니다.");
		}
	%>

	<b><%=dayCnt%>일차</b> 입니다 현재까지
	<b><%=hanCnt%>개</b>의 한자,
	<b><%=index2%>개</b>의 사자성어를 공부하셨습니다.
	<br>
	<br>
	<table
		style="text-align: center; width: 70%; height: 95%; margin: auto; border-collapse: collapse;"
		border="1 solid #cecece" cellpadding="0" cellspacing="0">
	<%
		int hanjaday = 0;

		for (int i = 0; i < 5; i++) {
			out.println("<tr height='20%'>");
			for (int j = 0; j < 5; j++) {
				tableDayCnt++;
				if ((tableDayCnt < dayCnt) || (tableDayCnt == dayCnt && todayLearn)) {
					//과거
					if (j == 4)
						out.println("<td style='background-color:#ffe8ab;width:20%;'><span class='day'>"
								+ tableDayCnt + "일차</span> 날짜 : " + day[i * 5 + j] + "<p>최고 점수 : "
								+ score[(tableDayCnt / 5) - 1] + "</p><a href='game.jsp?DAY=" + tableDayCnt
								+ "'><img src='resources/gameBt.png' height='20%'></a></td>");
					else {
						out.println("<td style='width:20%;'><span class='day'>" + tableDayCnt + "일차</span> 학습 날짜 : "
								+ day[i * 5 + j] + "<p class='h'><b><span class='hanja'>" + hanja[hanjaday]
								+ "</b></p>" + "<a href='learn.jsp?DAY=" + tableDayCnt
								+ "'><img src='resources/backLearnBt.png' height='20%'></a></td>");
						hanjaday++;
					}
				} else if (tableDayCnt == dayCnt && !todayLearn) {
					//오늘
					if (j == 4) {
						out.println("<td style='background-color:#ffe8ab;width:20%;'><p><span class='day'>"
								+ tableDayCnt + "일차</span> 최고점수 : " + score[(tableDayCnt / 5) - 1] + "</p>"
								+ "<a href='game.jsp?DAY=" + tableDayCnt
								+ "'><img src='resources/gameBt.png' height='30%'></a></td>");
					} else {
						out.println("<td style='width:20%;'><p><span class='day'>" + tableDayCnt
								+ "일차</span></p><a href='learn.jsp?DAY=" + tableDayCnt
								+ "'><img src='resources/learnBt.PNG' height='30%'></a></td>");
					}
				} else {
					//미래
					if (j == 4)
						out.println("<td style='background-color:#ece2c7;width:20%;'></td>");
					else
						out.println("<td style='background-color:#ececec;width:20%;'></td>");
				}
			}
			out.println("</tr>");
		}
	%>
	</table>
</body>
</html>