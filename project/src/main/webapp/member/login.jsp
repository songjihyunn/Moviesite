<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<style>
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
        /*아이디, 비밀번호, 이름, 닉네임, 생년월일, 휴대전화번호*/
        #aa{
            height: 100px;
            font-size: 20px; 
            font-weight: bold;
            text-align: right;
        }
        /*아이디, 비밀번호, 이름, 닉네임, 생년월일, 휴대전화번호 input*/
        #id, #pw, #name, #nickname, #birth, #phone{
            height: 50px; 
            width: 500px; 
            background-color: lightgray; 
            border-radius: 0px solid black; 
            border-radius: 10px;
            padding-left: 20px;
            margin-left: 50px;
        }
        /*등록 버튼*/
        #create{
            width: 300px;
            height: 80px;
            border: 1px solid gray;
            background-color: skyblue;
            color: white;
            border-radius: 10px;
            font-size: 20px;
            font-weight: bold;
            border-style: none;
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
        function join(){
            if(id.value == ""){
                alert("아이디를 입력하세요.");
                return false;
            }
            if(id.value.length < 3){
                alert("아이디 4자리 이상 입력하세요.");
                return false;
            }
            if(pw.value == ""){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            if(pw.value.length < 5){
                alert("비밀번호 6자리 이상 입력하세요.");
                return false;
            }
        }
        
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
<body onload="getTime()">

    <form action="login_update.jsp" method="post" onsubmit="return join();">
        <table width="1500" border=0>
            <tr>
                <td colspan="8" style="height: 50px;"></td>
            </tr>
            <tr>
                <td colspan="8" style="text-align: center; font-size: 30px; font-weight: bold; padding-bottom: 10px;">로그인</td>
            </tr>
            <tr>
                <td width = 130></td>
                <td id="aa" style="width: 300px;">* 아이디</td>    <!--아이디-->
                <td>
                   <table>
                       <tr>
                           <td><input type="text" id="id" placeholder="아이디를 입력하시오." name = "id"></td>
                       </tr>
                   </table>
                </td>
                <td colspan="5" rowspan="6"></td>
            </tr>
            <tr>
                <td></td>
                <td id="aa">* 비밀번호</td>    <!--비밀번호-->
                <td>
                    <table>
                       <tr>
                           <td><input type="password" id="pw" placeholder="비밀번호를 입력하시오." name = "pw"></td>
                       </tr>
                   </table>
                </td>
            </tr>
            
            <tr>
                <td colspan="8" align="center" style="padding-top: 30px;"><button id="create">로그인</button></td>
            </tr>  
        </table>
    </form> 
</body>
<br>
<%@ include file="/include/footer.jsp" %>
