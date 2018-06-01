<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
.saja {
	color: #abd8ff;
	font-size: 7em;
}

a:link, a:visited, a:active {
	color: #ecba03;
	font-size: 10em;
	text-decoration: none;
}

a:hover {
	color: #ee8585;
	font-size: 10em;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		int dayCnt = Integer.parseInt(request.getParameter("DAY"));

		PrintWriter r = null;
		try {
			String filePath = application.getRealPath("/WEB-INF/confirm.txt");
			r = new PrintWriter(new FileWriter(filePath));
			BufferedWriter bw = new BufferedWriter(r);
			
			for (int i = 0; i < 4; i++) {
				bw.write("false");
				if(i<3)bw.newLine();
			}
			bw.close();
			r.flush();

		} catch (Exception e) {
		}
		
		switch(dayCnt/5){
		case 1:dayCnt-=1;break;
		case 2:dayCnt-=2;break;
		case 3:dayCnt-=3;break;
		case 4:dayCnt-=4;break;
		}

		class Saja {
			String saja = "";//사자성어
			String read = "";//읽기
			String imgUrl = "";//이미지
			String mean = "";//뜻

			String[] han = new String[4];//각 한자
			String[] hanRead = new String[4];//각 한자 읽기
			String[] hanMean = new String[4];//각 한자의 의미

			public Saja() {
			}

			public Saja(String saja, String read, String imgUrl, String mean, String han1, String han2, String han3,
					String han4, String hanRead1, String hanRead2, String hanRead3, String hanRead4,
					String hanMean1, String hanMean2, String hanMean3, String hanMean4) {
				this.saja = saja;
				this.read = read;
				this.imgUrl = imgUrl;
				this.mean = mean;
				this.han[0] = han1;
				this.han[1] = han2;
				this.han[2] = han3;
				this.han[3] = han4;
				this.hanRead[0] = hanRead1;
				this.hanRead[1] = hanRead2;
				this.hanRead[2] = hanRead3;
				this.hanRead[3] = hanRead4;
				this.hanMean[0] = hanMean1;
				this.hanMean[1] = hanMean2;
				this.hanMean[2] = hanMean3;
				this.hanMean[3] = hanMean4;
			}
		}

		String str = "";
		BufferedReader reader = null;

		ArrayList<Saja> sj = new ArrayList<Saja>();

		//한자 얻어오기
		try {
			String filePath = application.getRealPath("/WEB-INF/한자.txt");
			reader = new BufferedReader(new FileReader(filePath));
			String csvStr = "";
			String tmpStr = "";

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "`";
				}
			} while (tmpStr != null);
			StringTokenizer parse = new StringTokenizer(csvStr, "`");
			for (int i = 0; i < dayCnt; i++) {
				String saja = parse.nextToken();
				String read = parse.nextToken();
				String mean = parse.nextToken();
				String img = parse.nextToken();
				String han1 = parse.nextToken();
				String hanRead1 = parse.nextToken();
				String hanMean1 = parse.nextToken();
				String han2 = parse.nextToken();
				String hanRead2 = parse.nextToken();
				String hanMean2 = parse.nextToken();
				String han3 = parse.nextToken();
				String hanRead3 = parse.nextToken();
				String hanMean3 = parse.nextToken();
				String han4 = parse.nextToken();
				String hanRead4 = parse.nextToken();
				String hanMean4 = parse.nextToken();
				sj.add(new Saja(saja, read, img, mean, han1, han2, han3, han4, hanRead1, hanRead2, hanRead3,
						hanRead4, hanMean1, hanMean2, hanMean3, hanMean4));
			}

		} catch (Exception e) {
			out.println("파일을 읽을 수 없습니다.");
		}
	%>
	<table
		style="text-align: center; width: 70%; height: 95%; margin: auto; border-collapse: collapse;"
		border="0" cellpadding="0" cellspacing="0">
		<tr height="35%">
			<td width="50%" rowspan="2" colspan="2"><img height="50%"
				src="<%=sj.get(dayCnt - 1).imgUrl%>"></td>
			<td width="50%" colspan="2"><span class="saja"><%=sj.get(dayCnt - 1).saja%></span><br>
				<br> <span style="font-size: 2em;"><b><%=sj.get(dayCnt - 1).read%></b></span></td>
		</tr>
		<tr height="15%">
			<td colspan="2"><p>
					의미&nbsp;▷&nbsp;&nbsp;<%=sj.get(dayCnt - 1).mean%></p></td>
		</tr>
		<tr>
			<td colspan="4"><span style="color: #D5D5D5">아래 있는 한자를
					클릭해 학습하세요!</span></td>
		</tr>
		<tr height="50%">
			<td width="25%"><a href="#"
				onclick="window.open('hanja.jsp?I=<%=dayCnt - 1%>&J=0','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=450,height=450,left=730, top=230, scrollbars=yes');return false"><%=sj.get(dayCnt - 1).han[0]%></a><br>
				<br> <b><%=sj.get(dayCnt - 1).hanRead[0]%></b></td>
			<td width="25%"><a href="#"
				onclick="window.open('hanja.jsp?I=<%=dayCnt - 1%>&J=1','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=450,height=450,left=730, top=230, scrollbars=yes');return false"><%=sj.get(dayCnt - 1).han[1]%></a><br>
				<br> <b><%=sj.get(dayCnt - 1).hanRead[1]%></b></td>
			<td width="25%"><a href="#"
				onclick="window.open('hanja.jsp?I=<%=dayCnt - 1%>&J=2','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=450,height=450,left=730, top=230, scrollbars=yes');return false"><%=sj.get(dayCnt - 1).han[2]%></a><br>
				<br> <b><%=sj.get(dayCnt - 1).hanRead[2]%></b></td>
			<td width="25%"><a href="#"
				onclick="window.open('hanja.jsp?I=<%=dayCnt - 1%>&J=3','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=450,height=450,left=730, top=230, scrollbars=yes');return false"><%=sj.get(dayCnt - 1).han[3]%></a><br>
				<br> <b><%=sj.get(dayCnt - 1).hanRead[3]%></b></td>
		</tr>
	</table>
</body>
</html>