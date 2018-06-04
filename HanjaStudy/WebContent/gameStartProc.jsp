<%@page import="java.util.StringTokenizer"%>
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

#Qcnt {
	float: left;
	margin-left: 210px;
	margin-top: 25px;
	color: #483f34;
	font-size: 2em;
}

#score {
	float: right;
	margin-right: 50px;
	margin-top: 25px;
	color: #483f34;
	font-size: 2em;
}

#question {
	font-size: 5em;
	margin-top: 170px;
}

.timer {
	color: #ecba03;
	font-size: 10em;
	font-weight: bold;
}

#timer1 {
	float: left;
	margin-left: 0px;
	margin-top: 130px;
}

#timer2 {
	float: right;
	margin-right: 155px;
	margin-top: 130px;
}

#a1 {
	width:443px;
	color: white;
	font-size: 4em;
	position: absolute;
	float: left;
	margin-left:0px;
	top: 731px;
	text-align:center;
}

#a2 {
	width:443px;
	color: white;
	font-size: 4em;
	position: absolute;
	float: left;
	margin-left:443px;
	top: 731px;
	text-align:center;
}

#a3 {
	width:443px;
	color: white;
	font-size: 4em;
	position: absolute;
	float: left;
	margin-left:886px;
	top: 731px;
	text-align:center;
}

#character {
	position: absolute;
	top: 490px;
	left: 870px;
}

#box1 {
	position: absolute;
	float: left;
	top: 581px;
}

#box2 {
	position: absolute;
	float: left;
	margin-left: 443px;
	top: 581px;
}

#box3 {
	position: absolute;
	float: right;
	margin-left: 886px;
	top: 581px;
}
</style>
<script>
	var t = 5;
	var qCnt = 10;
	var score = 0;
	var x=870;
	var answer="";
	var select="";
	
	window.onload = function() {
		document.getElementById("question").innerHTML="시작";
		document.getElementById("box1").style.display = "none";
		document.getElementById("box2").style.display = "none";
		document.getElementById("box3").style.display = "none";
		
		setInterval(back,10);
		setInterval(timerCnt, 1000);
	}
	
	window.onkeydown = function() {
		  if(event.keyCode==37){//왼
			  document.getElementById("character").innerHTML="<img src='resources/left.png'>";
			  if(x>315){
				  x-=20;
				  document.getElementById("character").style.left=x+'px';
			  }
		  }else if(event.keyCode==39){
			  document.getElementById("character").innerHTML="<img src='resources/right.png'>";
			  if(x<1440){
				  x+=20;
				  document.getElementById("character").style.left=x+'px';
			  }
		  }
	}
	
	window.onkeyup = function() {
		document.getElementById("character").innerHTML="<img src='resources/character.png'>";
	}

	function timerCnt() {
		t--;
		document.getElementById("timer1").innerHTML = t;
		document.getElementById("timer2").innerHTML = t;
		b=["a1","a2","a3"];

		if (t == 5){
			for(i=0;i<10;i++){
				rand=Math.floor(Math.random()*3);
				rand2=Math.floor(Math.random()*3);
				tmp=b[rand];
				b[rand]=b[rand2];
				b[rand2]=tmp;
			}
			document.getElementById("question").innerHTML = document.getElementById("Q" + qCnt).value;
			document.getElementById(b[0]).innerHTML = document.getElementById("i" + qCnt+"_1").value;
			document.getElementById(b[1]).innerHTML = document.getElementById("i" + qCnt+"_2").value;
			document.getElementById(b[2]).innerHTML = document.getElementById("i" + qCnt+"_3").value;
			answer=document.getElementById("A"+qCnt).value;
		}

		if (qCnt == 10 && t==1) {
			t = 6;
			document.getElementById("timer1").innerHTML = "시";
			document.getElementById("timer2").innerHTML = "작";
			qCnt--;
			document.getElementById("Qcnt").innerHTML = qCnt;
		} 
		else if (qCnt > 0&& t == 1 && select==answer) {
			t = 6;
			document.getElementById("timer1").innerHTML = "정";
			document.getElementById("timer2").innerHTML = "답";
			score+=100;
			document.getElementById("score").innerHTML = score;
			qCnt--;
			document.getElementById("Qcnt").innerHTML = qCnt;
		}else if ((t == 1 && qCnt == 0)||(qCnt!=10 && select!=answer && t<=1)) {
			document.getElementById("timer1").innerHTML = "종";
			document.getElementById("timer2").innerHTML = "료";
			//location.href = "gameEnd.jsp?s=" + score+"&d=";
			if(qCnt==0 && select==answer)score+=100;
			document.getElementById("s").value=score;
			document.getElementById('end').submit();
		}
	}
	
	function back(){
		center=x+84;
		if(center>295&&center<733){
			document.getElementById("box1").style.display = "block";
			document.getElementById("box2").style.display = "none";
			document.getElementById("box3").style.display = "none";
			select=document.getElementById("a1").innerHTML;
		}else if(center>732&&center<1170){
			document.getElementById("box1").style.display = "none";
			document.getElementById("box2").style.display = "block";
			document.getElementById("box3").style.display = "none";
			select=document.getElementById("a2").innerHTML;
		}else{
			document.getElementById("box1").style.display = "none";
			document.getElementById("box2").style.display = "none";
			document.getElementById("box3").style.display = "block";
			select=document.getElementById("a3").innerHTML;
		}
	}
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		int a = Integer.parseInt(request.getParameter("DAY"));

		String[][] question = new String[20][5];
		String[] hanQA = new String[80];//한자 객관식 문항
		String[] readQA = new String[80];//한자 읽기 객관식 문항
		String[] sajaQA = new String[20];//사자성어 객관식 문항
		String[] sajaReadQA = new String[20];//사자성어 읽기 객관식 문항

		//한자 얻어오기
		try {
			String filePath = application.getRealPath("/WEB-INF/한자.txt");
			BufferedReader reader = new BufferedReader(new FileReader(filePath));
			String csvStr = "";
			String tmpStr = "";

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "`";
				}
			} while (tmpStr != null);
			
			reader.close();
			StringTokenizer parse = new StringTokenizer(csvStr, "`");
			for (int i = 0; i < 20; i++) {
				sajaQA[i] = parse.nextToken();
				sajaReadQA[i] = parse.nextToken();
				parse.nextToken();
				parse.nextToken();
				hanQA[i * 4] = parse.nextToken();
				readQA[i * 4] = parse.nextToken();
				parse.nextToken();
				hanQA[i * 4 + 1] = parse.nextToken();
				readQA[i * 4 + 1] = parse.nextToken();
				parse.nextToken();
				hanQA[i * 4 + 2] = parse.nextToken();
				readQA[i * 4 + 2] = parse.nextToken();
				parse.nextToken();
				hanQA[i * 4 + 3] = parse.nextToken();
				readQA[i * 4 + 3] = parse.nextToken();
				parse.nextToken();
			}

		} catch (Exception e) {
			out.println("파일을 읽을 수 없습니다.");
		}

		//그 주의 한자 불러오기
		try {
			String filePath = application.getRealPath("/WEB-INF/" + (a / 5) + ".txt");
			BufferedReader reader = new BufferedReader(new FileReader(filePath));
			String csvStr = "";
			String tmpStr = "";

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "!";
				}
			} while (tmpStr != null);
			StringTokenizer parse = new StringTokenizer(csvStr, "!");
			for (int i = 0; i < 20; i++) {
				int rand = (int) (Math.random() * 2);
				if (rand == 1) {//문제를 한자로 할지 읽는 걸로 할지 랜덤
					question[i][0] = parse.nextToken();
					question[i][1] = parse.nextToken();
				} else {
					question[i][1] = parse.nextToken();
					question[i][0] = parse.nextToken();
				}
			}
			reader.close();
		} catch (Exception e) {
			out.println("파일을 읽을 수 없습니다.");
		}

		String[][] tmp = new String[1][2];
		String tmp2 = "";
		int rand;
		int rand2;

		for (int i = 0; i < 100; i++) { //문제 순서, 답순서 랜덤
			//문제 랜덤
			rand = (int) (Math.random() * 20);
			rand2 = (int) (Math.random() * 20);
			tmp[0] = question[rand];
			question[rand] = question[rand2];
			question[rand2] = tmp[0];
		}
		for (int i = 0; i < 200; i++) {
			//객관식 답 순서 랜덤
			rand = (int) (Math.random() * 80);
			rand2 = (int) (Math.random() * 80);
			tmp2 = hanQA[rand];
			hanQA[rand] = hanQA[rand2];
			hanQA[rand2] = tmp2;

			rand = (int) (Math.random() * 80);
			rand2 = (int) (Math.random() * 80);
			tmp2 = readQA[rand];
			readQA[rand] = readQA[rand2];
			readQA[rand2] = tmp2;

			rand = (int) (Math.random() * 20);
			rand2 = (int) (Math.random() * 20);
			tmp2 = sajaQA[rand];
			sajaQA[rand] = sajaQA[rand2];
			sajaQA[rand2] = tmp2;

			rand = (int) (Math.random() * 20);
			rand2 = (int) (Math.random() * 20);
			tmp2 = sajaReadQA[rand];
			sajaReadQA[rand] = sajaReadQA[rand2];
			sajaReadQA[rand2] = tmp2;
		}

		for (int i = 0; i < 10; i++) {//문제 객관식 답 넣기
			String regEx = ".*[\u2e80-\u2eff\u31c0-\u31ef\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fbf\uf900-\ufaff].*";
			int j;
			int k = 0;
			String[] QA;

			if (question[i][1].matches(regEx)) {//문제의 답이 한자일 때
				if (question[i][1].length() == 1) {
					j = (int) (Math.random() * 77);
					QA = hanQA;
				} else {
					j = (int) (Math.random() * 17);
					QA = sajaQA;
				}
				while (true) {
					if (k >= 2)
						break;
					if (!question[i][1].equals(QA[j])) {
						question[i][2 + k] = QA[j++];
						k++;
					}
				}
			} else {
				if (question[i][1].contains(" ")) {//한자 하나 읽는 거일때
					j = (int) (Math.random() * 77);
					QA = readQA;
				} else {
					j = (int) (Math.random() * 17);
					QA = sajaReadQA;
				}
				while (true) {
					if (k >= 2)
						break;
					if (!question[i][1].equals(QA[j])) {
						question[i][2 + k] = QA[j++];
						k++;
					}
				}
			}
			question[i][4] = question[i][1];
		}

		System.out.println("게임준비성공");

		for (int i = 0; i < 10; i++) {

			out.println("<input type='hidden' id='Q" + i + "' value='" + question[i][0] + "'>");
			out.println("<input type='hidden' id='A" + i + "' value='" + question[i][1] + "'>");
			out.println("<input type='hidden' id='i" + i + "_1' value='" + question[i][2] + "'>");
			out.println("<input type='hidden' id='i" + i + "_2' value='" + question[i][3] + "'>");
			out.println("<input type='hidden' id='i" + i + "_3' value='" + question[i][4] + "'>");
		}
	%>
	<div
		style="background: url('resources/gameBack.png'); background-repeat: no-repeat; width: 1330px; height: 100%; margin: auto; border: 15px solid #ecba03; border-radius: 10px;">
		<p id="Qcnt">10</p>
		<p id="score">0</p>
		<div id="timer1" class="timer">5</div>
		<div id="timer2" class="timer">5</div>
		<p id="question"></p>
		<div id="a1" style="z-index: 2;"></div>
		<div id="a2" style="z-index: 2;" ></div>
		<div id="a3" style="z-index: 2;" ></div>
		<div id="box1">
			<img src="resources/first.JPG" width="443px" height="282px;">
		</div>
		<div id="box2">
			<img src="resources/second.JPG" width="443px" height="282px;">
		</div>
		<div id="box3">
			<img src="resources/third.JPG" width="443px" height="282px;">
		</div>
		<div id="character">
			<img src="resources/character.png">
		</div>
	</div>
	<form action="gameEnd.jsp" method="post" id="end">
		<input type="hidden" id="s" name="s" value="0">
		<input type="hidden" name="d" value="<%=a%>">
	</form> 
</body>
</html>