<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Dongle&family=Sunflower:wght@300&display=swap')
        /*전체*/
        *{
            padding: 0px;
            margin: 0px;
            position: relative;
            font-family: "Sunflower", sans-serif;
        }
        /*전체form*/
        form{
            display:grid;
            justify-content: center;
        }
        /*상단 메뉴바*/
        a{
            margin-left: 10px;
            text-align: left;
            word-spacing: 20px;
            font-size: 20px;
            font-weight: bold;
            color: white;
            text-align: center;
            text-decoration: none;
        }
        /*전체 게시판 메뉴바(번호, 제목, 글쓴이, 날짜)*/
        #all_bar{
            text-align: center;
            font-weight: bold;
            font-size: 18px;
            background-color: aliceblue;
        }
        /*글쓰기 버튼*/
        #write{
            width: 100px;
            height: 50px;
            border: 1px solid gray;
            background-color: skyblue;
            color: white;
            border-radius: 10px;
            font-size: 15px;
            font-weight: bold;
            border-style: none;
        }
        /*게시판 전체*/
        #all_table{
            border: 1px solid gray; 
            border-radius: 5px;
            border-collapse: collapse;
        }

       table.all_table1 tr.colored:nth-child(2n){
            background-color: #ABDFFE;
        }
        /*상단 로그인, 비밀번호 버튼*/
        #login, #register{
            width: 100px;
            height: 50px;
            border: 1px solid gray;
            border-radius: 10px;
            font-size: 15px;
            font-weight: bold;
            border-style: none;
            background-color: white;
        }
    </style>
    <script>
        function getTime() {
            var d = new Date();
            var hur = d.getHours();		// 시
            var min = d.getMinutes();	//분
            var sec = d.getSeconds();	//초

            var timeBoard = document.getElementById("WhatTimeIsItNow"); // 값이 입력될 공간

            var time =hur + "시 " + min + "분 " + sec + "초"	// 형식 지정

            timeBoard.innerHTML = time;	// 출력

            setTimeout(getTime, 1000);	//1000밀리초(1초) 마다 반복
        }
    </script>
</head>
<body id="bd" onload="getTime()">
    <form action="" onsubmit="return join();">
        <table width="1500" border=0>
           <tr height="50">
               <td colspan="8"></td>
           </tr>
            <tr>
                <td width="150"></td>
                <td></td>
                <td width="200" >
                   <div id="current_date" style="font-weight: bold;">
                        <script>
                            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                            document.getElementById("current_date").innerHTML = new Date().toLocaleDateString('ko-KR', options);
                        </script>
                    </div>
                    <p id="WhatTimeIsItNow" style="font-weight: bold;"></p>
                </td>     <!--로고-->
                <td width="700" colspan="3" style="text-align: center;">
                   <a href="../index.jsp">
                        <img src="../img/logo2.PNG" style="width:100px; height: 100px; padding-left: 100px;">
                    </a>
                </td>
                <td width="300">
                   <table border=0 style="text-align: right; width: 300px;">
                       <tr>
                           <td style="text-align: right;">    <!--상단 로그인 버튼-->
                               <button type="button" id="login" onClick="location.href='../member/login.jsp'" style="width: 80px; height: 70px; text-align: right;">
                                <img src="../img/login.PNG" style="width: 50px; height: 50px; text-align: center; ">
                                   <span>로그인</span>
                               </button>
                           </td>
                           <td style="text-align: left;">        <!--상단 회원가입 버튼-->
                               <button type="button" id="login" onClick="location.href='./member/create.jsp'" style="width: 80px; height: 70px; text-align: right;">
                               <img src="../img/join.PNG" style="width: 50px; height: 50px; text-align: center; ">
                                   <span>회원가입</span>
                                </button>
                           </td>
                       </tr>
                   </table>  
                </td>
                <td width="150"></td>
            </tr>
            <tr>
                <td colspan="8" style="height: 20px;"></td>
            </tr>
            <tr><!--상단 메뉴바-->
               <td></td>
               <td  colspan="6" style="background-color: skyblue; height: 50px; border-radius: 5px;">
               <table id="menu">
                   <tr>
                       <td style="padding-left: 10px;"><a href="../contents/all.jsp">전체</a></td>
	                   <td style="padding-left: 50px;"><a href="../contents/free.jsp">자유게시판</a></td>
	                    <td style="padding-left: 50px;"><a href="../contents/best.jsp">Best</a></td>
	                    <td style="padding-left: 50px;"><a href="../contents/info.jsp">영화정보</a></td>
	                    <td style="padding-left: 50px;"><a href="../contents/notice.jsp">공지사항</a></td>
	                    <td style="padding-left: 50px;"><a href="../contents/qa.jsp">Q&A</a></td>
                   </tr>
               </table>
               </td>
               <td></td>
            </tr>
            <tr>
                <td colspan="8" style="height: 50px;"></td>
            </tr>  
            <tr>
                <td></td>
                <td colspan="7" style=" font-size: 25px; font-weight: bold;">파묘(Exhuma)</td>
            </tr>
            <tr>
                <td colspan="8" style="height: 30px;"></td>
            </tr>
            <tr>
                <td></td>
                <td colspan="6">
                    <table border=0 id="info">
                        <tr>
                            <td rowspan="4" style="width: 310px; height: 510px;"><img src="../img/movie1.PNG" style="width: 350px; height: 500px;"></td>
                            <td style="width: 50px; height: 160px; font-size: 15px; font-weight: bold; background-color: lightgray; text-align: center;">장르</td>
                            <td colspan="3">미스터리, 스릴러, 공포, 오컬트, 서스펜스, 포크 호러, 다크 판타지, 어반 판타지</td>
                        </tr>
                        <tr>
                            <td style="width: 50px; height: 80px;font-size: 15px; font-weight: bold; padding-left: 10px; background-color: lightgray; text-align: center;">감독</td>
                            <td style="padding-left: 10px;">장재현</td>
                            <td style="width: 50px; height: 80px;font-size: 15px; font-weight: bold;padding-left: 10px; background-color: lightgray; text-align: center;">출연</td>
                            <td style="padding-left: 10px;">최민식, 김고은, 유해진, 이도현 外</td>
                        </tr>
                        <tr>
                            
                        </tr>
                        <tr>
                            <td style="width: 50px; height: 80px;font-size: 15px; font-weight: bold;padding-left: 10px; background-color: lightgray; text-align: center;">개봉일</td>
                            <td style="width: 300px;padding-left: 10px;">2024년 2월 22일</td>
                            <td style="width: 80px;padding-left: 10px; font-weight: bold; background-color: lightgray; text-align: center;">상영시간</td>
                            <td style="width: 400px;padding-left: 10px;">134분</td>
                        </tr>
                        <tr>
                        	<td colspan="8" style="height: 20px;"></td>
                        </tr>
                        <tr >
                            <td colspan="7" style="font-size: 20px; font-weight: bold; padding-top: 10px; padding-bottom: 5px;padding-left: 10px;  background-color: lightgray; text-align: center;">시놉시스</td>
                        </tr>
                        <tr>
                            <td colspan="5" style="padding-left: 10px;">
                               미국 LA, 거액의 의뢰를 받은 무당 ‘화림’(김고은)과 ‘봉길’(이도현)은 기이한 병이 대물림되는 집안의 장손을 만난다.
                                조상의 묫자리가 화근임을 알아챈 ‘화림’은 이장을 권하고,
                                돈 냄새를 맡은 최고의 풍수사 ‘상덕’(최민식)과 장의사 ‘영근’(유해진)이 합류한다.

                                “전부 잘 알 거야… 묘 하나 잘못 건들면 어떻게 되는지”

                                절대 사람이 묻힐 수 없는 악지에 자리한 기이한 묘.
                                ‘상덕’은 불길한 기운을 느끼고 제안을 거절하지만,
                                ‘화림’의 설득으로 결국 파묘가 시작되고….

                                나와서는 안될 것이 나왔다.
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form> 
</body>
</html>