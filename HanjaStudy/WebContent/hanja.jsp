<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한자공부</title>
<style>
	@font-face{
		font-family:KoPubGothic;
		src:url('KoPubDotumMedium.ttf') format('truetype');
	}
	body{
		font-family:KoPubGothic,'NanumGothic';
	}
	#h{
		margin-top:30px;
		color: white;
		font-size: 10em;
	}
	#r{
		margin-top:10px;
		font-size: 1.5em;
		color:white;
		text-shadow: -2px 1px 0 #e39c03,-1px 1px 0 #e39c03, -2px -1px 0 #e39c03,-1px -1px 0 #e39c03 ,0px 0px 0 #e39c03, 1px 1px 0 #e39c03 , 2px 1px 0 #e39c03, 1px -1px 0 #e39c03 , 2px -1px 0 #e39c03;
	}
	#m{
		color:white;
		margin:30px;
	}
</style>
</head>
<body style="background-color: #ecba03">
	<%
		request.setCharacterEncoding("UTF-8");
		int d = Integer.parseInt(request.getParameter("I"));
		int j = Integer.parseInt(request.getParameter("J"));

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
			for (int i = 0; i < d + 1; i++) {
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

		//배운 한자 저장
		String st = "";
		String stAll = "";

		try {
			String filePath = application.getRealPath("/WEB-INF/배운한자.txt");
			reader = new BufferedReader(new FileReader(filePath));

			while (true) {
				st = reader.readLine();
				if (st == null)
					break;
				stAll += (st + " ");
			}

		} catch (Exception e) {
		}
		PrintWriter wr = null;
		if (!stAll.contains(sj.get(d).han[j])) {
			try {
				String filePath = application.getRealPath("/WEB-INF/배운한자.txt");
				wr = new PrintWriter(new FileWriter(filePath, true));
				BufferedWriter bw = new BufferedWriter(wr);

				bw.newLine();
				bw.write(sj.get(d).han[j]);
				bw.close();
				wr.flush();

			} catch (Exception e) {
			}
		}

		str = "";
		String strAll = "";
		String[] cf = new String[4];
		int k = 0;

		try {
			String filePath = application.getRealPath("/WEB-INF/confirm.txt");
			reader = new BufferedReader(new FileReader(filePath));

			while (true) {
				str = reader.readLine();
				if (str == null)
					break;
				cf[k] = str;
				k++;
			}

		} catch (Exception e) {
		}

		PrintWriter writer = null;

		try {
			String filePath = application.getRealPath("/WEB-INF/confirm.txt");
			writer = new PrintWriter(new FileWriter(filePath));
			BufferedWriter bw = new BufferedWriter(writer);
			
			bw.write("true");
			bw.newLine();
			for(int i=0;i<3;i++){
				bw.write(cf[i]);
				if(i<2)bw.newLine();
			}
			bw.close();
			writer.flush();

		} catch (Exception e) {
		}

		strAll+="true ";
		for (int i = 0; i < 3; i++) {
			strAll += (cf[i] + " ");
		}

		if (!strAll.contains("false")) {
			//배운 사자성어 추가
			str = "";
			strAll = "";

			writer = null;

			try {
				String filePath = application.getRealPath("/WEB-INF/배운사자성어.txt");
				reader = new BufferedReader(new FileReader(filePath));

				while (true) {
					str = reader.readLine();
					if (str == null)
						break;
					strAll += (str + " ");
				}

			} catch (Exception e) {
			}
			writer = null;

			if (!strAll.contains(sj.get(d).saja)) {
				try {
					String filePath = application.getRealPath("/WEB-INF/배운사자성어.txt");
					writer = new PrintWriter(new FileWriter(filePath, true));
					BufferedWriter bw = new BufferedWriter(writer);

					bw.newLine();
					bw.write(sj.get(d).saja + "_ " + sj.get(d).read);
					bw.close();
					writer.flush();

				} catch (Exception e) {
				}
				//오늘 날짜 저장
				try {
					String filePath = application.getRealPath("/WEB-INF/day.txt");
					reader = new BufferedReader(new FileReader(filePath));

					while (true) {
						str = reader.readLine();
						if (str == null)
							break;
						strAll += (str + " ");
					}

				} catch (Exception e) {
				}

				Date day = new Date();//오늘 날짜
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String today = sdf.format(day);

				if (!strAll.contains(today)) {
					try {
						String filePath = application.getRealPath("/WEB-INF/day.txt");
						writer = new PrintWriter(new FileWriter(filePath, true));
						BufferedWriter bw = new BufferedWriter(writer);

						bw.newLine();
						bw.write(today);
						bw.close();
						writer.flush();

					} catch (Exception e) {
					}
				}
			}
		}
	%>
	<center>
		<div id="h"><%=sj.get(d).han[j]%></div>
		<div id="r"><%=sj.get(d).hanRead[j]%></div>
		<div id="m"><%=sj.get(d).hanMean[j]%></div>
	</center>
</body>
</html>