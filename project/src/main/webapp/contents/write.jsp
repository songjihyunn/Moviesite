<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code"); //db: table명
    
String bbs_title = "";	//게시판 이름
if(code.equals("free")){
	bbs_title="자유게시판";
}else if(code.equals("info")){
	bbs_title="영화";
}else if(code.equals("notice")){
	bbs_title="공지사항";
}else if(code.equals("qna")){
	bbs_title="Q&A";
}
%>
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
        /*등록, 돌아가기 버튼*/
        #finish, #list{
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
        /*내용의 placeholder*/
        ::-webkit-input-placeholder {
           color: gray;
            text-align: start;
        }
        /*내용 input*/
        #comment{
            width: 800px; 
            height: 400px; 
            padding: 10px; 
            font-size: 15px;
            word-break: break-all;
            margin-left: 57px;
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
    <script type="text/javascript">
    var fileCheck = document.getElementById("file1");
        function finishh(){
            if(subject.value == ""){
                alert("제목을 입력하세요.");
                return false;
            }
            if(comment.value==""){
                alert("내용을 입력하세요.");
                return false;
            }
            if(open_d.value==""){
            	alert("개봉일을 입력하세요.");
            	return false;
            }
            if(!fileCheck.files || fileCheck.files[0]){
            	alert("파일을 첨부해주세요.");
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
<body id="bd" onload="getTime()">
    <form action="insert.jsp" method="post" ENCTYPE="multipart/form-data">
    <input type="hidden" name="code" value="<%=code%>">    
        <table width="1200" border="0">
            <tr><td colspan="8" style="height: 50px;"></td></tr>
            <tr>
                <td width="100px;" rowspan="7"></td>
                <td colspan="5" style="border-bottom: 1px solid black; font-size: 21px; font-weight: bold; padding-left: 10px;"> <%=bbs_title %> 글쓰기</td>
            </tr>
            <tr>
                <td style= "height:25; padding-top: 10px; padding-left: 10px; font-weight: bold;">옵션
                	<input type= "radio" name="gongji" value="2" checked style="margin-left: 50px;">일반
                	<input type= "radio" name="gongji" value="3">비밀
                	<%if(session_level != null && session_level.equals("10")){ %>
                		<input type= "radio" name="gongji" value="1" >공지
                	<%} %>
                </td>
               </tr>
            <tr>
                <td colspan="5">
                    <strong style="padding-left: 10px;">제목</strong>
                    <input id="subject" name="subject" style="margin-left: 50px; width: 700px; font-size: 18px;">
                </td>
            </tr>
            <tr>
                <td width="800px;">
                	<strong style="padding-left: 10px; vertical-align: top;">내용</strong>
                	<textarea name="comment" id="comment" style="margin-left: 50px; width: 700px;" placeholder="내용을 입력하세요"></textarea>
                </td>
            </tr>
            <tr>
            <%if(code.equals("info")) {%>
            <td height=28 style="font-weight: bold; padding-bottom: 10px;">
            	<strong style="padding-left: 10px;">개봉일</strong>
            	<input type = "date" id = "open_d" name ="open_d" style=" margin-left: 35px;" required>
            </td>
            <%} %>
            </tr>
            <tr>
            	<td height=28 style="font-weight: bold; padding-left: 10px;">첨부
					<input type="file" name="file1" id = "file1" style="margin-left: 50px;">
				</td>
			</tr>
            <tr>
                <td colspan="5" style="text-align: right;">
                    <button id="finish" onClick="finishh()">등록</button>
                    <button id="list" onClick="history.go(-1);">돌아가기</button>
                </td>
            </tr>
        </table>
    </form> 
</body>
</html>