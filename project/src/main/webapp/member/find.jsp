<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ page import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String phone = request.getParameter("phone");

String id = ""; // 아이디 초기화
String pw = ""; // 비밀번호 초기화

try {
    
    // 아이디 찾기 SQL 쿼리
    String idSql = "SELECT id, pw FROM member WHERE name = ? AND phone = ?";
    try (Connection conn = DriverManager.getConnection(url, user, password);
         PreparedStatement idPstmt = conn.prepareStatement(idSql)) {
        idPstmt.setString(1, name);
        idPstmt.setString(2, phone);

        try (ResultSet idRs = idPstmt.executeQuery()) {
            if (idRs.next()) {
                id = idRs.getString("id"); // 아이디 값 설정
                pw = idRs.getString("pw"); // 비밀번호 값 설정
            }
        }
    }
} catch (SQLException e) {
    // SQLException 처리
    e.printStackTrace();
}
%>

<script>
//아이디 찾기 버튼 클릭 시 실행되는 JavaScript 함수
function check1() {
    var name = document.getElementById("name").value;
    var phone = document.getElementById("phone").value;
    
    if (name.trim() === "" || phone.trim() === "") {
        alert("이름과 휴대전화번호를 모두 입력해주세요.");
    } else {
        // 폼 데이터를 서버로 전송합니다.
        document.getElementById("findForm").submit();
    }
}

// 서버로부터 받은 아이디 값 확인 및 알림창 표시
window.onload = function() {
    var id = "<%= id %>";
    var pw = "<%= pw %>";
    
    if (id.trim() !== "" && pw.trim() !== "") {
        alert("회원님의 아이디는: " + id + "\n회원님의 비밀번호는: " + pw);
    }
};

    function getTime() {
        var d = new Date();
        var hur = d.getHours();
        var min = d.getMinutes();
        var sec = d.getSeconds();
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
    }
</script>

<style>
    * {
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
    
    a {
        margin-left: 10px;
        text-align: left;
        word-spacing: 20px;
        font-size: 20px;
        font-weight: bold;
        color: white;
        text-align: center;
        text-decoration: none;
    }

    .found {
        font-size: 25px;
        font-weight: bold;
        padding-bottom: 5px;
    }

    .info-table {
        border: 1px solid gray;
        width: 450px;
        height: 250px;
        border-radius: 20px;
    }

    .check-button {
        background-color: skyblue;
        color: white;
        font-size: 20px;
        width: 80px;
        height: 50px;
        font-weight: bold;
        border-radius: 10px;
    }
</style>
<body id="bd" onload="getTime()">
    <form id="findForm" method="post" action="find.jsp">
        <table width="1500" border="0">
            <tr>
                <td style="height: 70px;"></td>
            </tr>
            <tr>
                <td width="525"></td>
                <td colspan="8">
                    <table class="info-table">
                        <tr>
                            <td class="found" style="padding-left: 10px;">아이디/비밀번호 찾기</td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px;">
                                이름: <input id="name" name="name" style="width: 300px; height: 30px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px;">
                                휴대전화번호: <input id="phone" name="phone" style="width: 300px; height: 30px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <button class="check-button" type="button" onclick="check1()">확인</button>
                            </td>
                        </tr>
                    </table>
                </td>
                
            </tr>
            <tr>
                <td style="height: 70px;"></td>
            </tr>
        </table>
        <center>
        	<%@ include file="/include/footer.jsp" %>
        </center>
        	
    </form>
</body>

