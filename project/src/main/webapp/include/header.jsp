<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 개행 처리, sql 이스케이프 처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%@ include file="/include/dbconnection.jsp" %>
    <style>
        /*전체*/
        *{
            padding: 0px;
            margin: 0px;
            position: relative;
            font-family: "Sunflower", sans-serif;
        }
        /*전체form*/
		#bd{
            display:grid;
            justify-content: center;
        /*상단 메뉴바*/
        #bar{
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
        #out, #create_up{
        	color: black;
        	 text-decoration: none;	
        }
    </style>
    <script type="text/javascript">
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
<body onload="getTime()">
<%
String session_id = (String)session.getAttribute("id");
String session_name = (String)session.getAttribute("name");
String session_phone = (String)session.getAttribute("phone");
String session_level = (String)session.getAttribute("level");
%>

    <form id ="bd" action="" onsubmit="return join();" onload="getTime();'">
        <table width="1500" border=0>
           <tr height="50">
               <td colspan="8"></td>
           </tr>
           <tr height= "50">
                <td width="150"></td>
                <td></td>
                <td width="200">
                   <div id="current_date" style="font-weight: bold;">
                        <script>
                            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
                            document.getElementById("current_date").innerHTML = new Date().toLocaleString('ko-KR', options);
                        </script>
                    </div>
                    <p id="WhatTimeIsItNow" style="font-weight: bold;"></p>
                </td>     <!--로고-->
                <td width="700" colspan="3" style="text-align: center;">
                   <a href="/">
                        <img src="../img/logo2.PNG" style="width:100px; height: 100px; padding-left: 100px;">
                    </a>
                </td>
                <td width="300">
                   <table border=0 style="text-align: right; width: 300px;  height: 100%; text-decoration: none;">
                       <tr>
                           <td style="text-align: right;">   
                           <%
							if(session_level != null && session_level.equals("10")){ //관리자라면
								out.print("<a href='/admin/' style='color:red'>[관리자]</a>");
							%>
							<%
							}
							%>
                           <%if(session_name !=null){ %>
                           <strong><%=session_name %>님<br></strong><br>	<!-- 로그인 후 -->
                               <a id="out" href = "/member/logout.jsp" style="font-color: black;">[로그아웃]</a>
                               <a id="create_up" href = "/member/create_up.jsp">[회원수정]</a>
                           <%}else{%><!-- 로그인 전 -->
                            <!--상단 로그인 버튼-->
                           <button type="button" id="login" onClick="location.href='../member/login.jsp'" style="width: 80px; height: 70px;">
                                <img src="../img/login.PNG" style="width: 50px; height: 50px; text-align: center; ">
                                   <br>
                                   <span>로그인</span>
                               </button>
                           </td>
                           <!--상단 회원가입 버튼-->
                           <td style="text-align: left;">        
                               <button type="button" id="login" onClick="location.href='../member/create.jsp'" style="width: 80px; height: 70px;">
                               <img src="../img/join.PNG" style="width: 50px; height: 50px; text-align: center; ">
                                   <br>
                                   <span>회원가입</span>
                                </button>
                           </td>
                           <%} %>
                       </tr>
                   </table>  
                <td width="150"></td>
            <tr>
                <td colspan="8" style="height: 20px;"></td>
            </tr>
            <tr><!--상단 메뉴바-->
               <td></td>
               <td  colspan="6" style="background-color: 0099FF; height: 50px; border-radius: 5px;">
               <table id="menu">
                   <tr>
                   <td>
                   		<a href="/contents/list.jsp?code=free" id="bar" style="padding-left: 50px;">자유게시판</a>
                    	<a href="/contents/list.jsp?code=info" id="bar" style="padding-left: 50px;">영화</a>
                    	<a href="/contents/list.jsp?code=notice" id="bar" style="padding-left: 50px;">공지사항</a>
                    	<a href="/contents2/list.jsp?code=qna" id="bar" style="padding-left: 50px;">Q&A</a>
                   </td>
                   </tr>
               </table>
               </td>
               <td></td>
            </tr>
           </table>
          </form>
</body>
</html>