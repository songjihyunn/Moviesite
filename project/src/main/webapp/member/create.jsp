<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
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
            if(name.value == ""){
                alert("이름을 입력하세요.");
                return false;
            }
            if(nickname.value == ""){
                alert("닉네임을 입력하세요.");
                return false;
            }
            if(birth.value == ""){
                alert("생년월일을 입력하세요.");
                return false;
            }
            if(birth.value.trim().length !== 8){
                alert("8자리로 입력하세요.ex) 19900101");
                return false;
            }else if(birth.value.length >8){
            	alert("8자리로 입력하세요.ex) 19900101");
                return false;
            }
            if(phone.value == ""){
                alert("휴대전화번호를 입력하세요.");
                return false;
            }
            
            let input = document.getElementById("phone").value;
            let phone_format = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
            
            if(phone_format.test(input)){
                return true;
            }else{
            	alert("휴대전화번호 형식에 맞게 입력해주세요.");
            	return false;
            }
            
        }
        //현재 시간
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
        function onlyNumber(obj){
        	 $(obj).keyup(function(){                 
        		$(this).val($(this).val().replace(/[^0-9]/g,""));        
        		});
        }

    </script>
</head>
<body onload="getTime()">
    <form action="insert.jsp" method="post" onsubmit="return join();">
        <table width="1500" border="0">
            <tr>
                <td colspan="8" style="height: 50px;"></td>
            </tr>
            <tr>
                <td colspan="8" style="text-align: center; font-size: 30px; font-weight: bold; padding-bottom: 10px;">회원가입</td>
            </tr>
            <tr>
                <td width = "150"></td>
                <td id="aa" style="width: 300px;">* 아이디</td>
                <td>
                   <table>
                       <tr>
                           <td><input type="text" id="id" placeholder="아이디를 입력하시오." name="id"></td>
                       </tr>
                       <tr>
                          <td style="color: gray; padding-left: 50px;">ID는 4자 이상으로 이루어져야 합니다.</td>      
                       </tr>
                   </table>
                </td>
                <td colspan="5" rowspan="6"></td>
            </tr>
                    <tr>
                <td></td>
                <td id="aa">* 비밀번호</td>
                <td>
                    <table>
                       <tr>
                           <td><input type="text" id="pw" placeholder="비밀번호를 입력하시오." name="pw"></td>
                       </tr>
                       <tr>
                          <td style="color: gray; padding-left: 50px;">비밀번호는 6자리 이상으로 이루어져야 합니다.</td>
                       </tr>
                   </table>
                </td>
            </tr>
            <tr>
                <td></td>
                <td id="aa">* 이름</td>
                <td>
                    <input type="text" id="name" placeholder="이름을 입력하시오." name="name">
                </td>
            </tr>
            <tr>
                <td></td>
                <td id="aa">* 닉네임</td>
                <td>
                    <input type="text" id="nickname" placeholder="닉네임을 입력하시오." name="nickname">
                </td>
            </tr>
            <tr>
                <td></td>
                <td id="aa">* 생년월일</td>
                <td>
                   <table>
                       <tr>
                           <td><input type="number" id="birth" placeholder="생년월일을 입력하시오." name="birth" maxlength="8" onkeydown="onlyNumber(this)"></td>
                       </tr>
                       <tr>
                          <td style="color: gray; padding-left: 50px;">8자리로 입력하세요. ex) 19901010</td>
                       </tr>
                   </table>
                </td>
            </tr>
            <tr>
                <td></td>
                <td id="aa">* 휴대전화번호</td>
                <td>
                   <table>
                       <tr>
                           <td><input type="number" id="phone" placeholder="휴대전화번호를 입력하시오." name="phone" maxlength="11" onkeydown="onlyNumber(this)"></td>
                       </tr>
                       <tr>
                          <td style="color: gray; padding-left: 50px;">11자리로 입력하세요. ex) 01012345678</td>
                       </tr>
                   </table>
                </td>
            <tr>
                <td colspan="8" align="center"><button id="create" name="create">등록</button></td>
            </tr>  
        </table>
    </form> 
</body>
</html>
<br>
<center>
<%@ include file="/include/footer.jsp" %>
</center>
