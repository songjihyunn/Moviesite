<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp" %>

<%
String sql = "SELECT * FROM member WHERE id = '" + session_id + "'";
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()){

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
<table width="100%"  height=50 border=0>
	<tr>
		<td align=center>
			<form action="create_update.jsp" method="post" onsubmit="">
			<table width="1500" border="0">
            <tr>
                <td colspan="8" style="height: 50px;"></td>
            </tr>
            <tr>
                <td colspan="8" style="text-align: center; font-size: 30px; font-weight: bold; padding-bottom: 10px;">회원수정</td>
            </tr>
            <tr>
                <td width = "150"></td>
                <td id="aa" style="width: 300px;">* 아이디</td>
                <td>
                   <table>
                       <tr>
                           <td><input type="text" id="id" placeholder="아이디를 입력하시오." name="id"  value="<%=rs.getString("id")%>" readonly></td>
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
                           <td><input id="birth" name="birth" value="<%=rs.getString("birth")%>" readonly></td>
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
                           <td><input type="number" id="phone" placeholder="휴대전화번호를 입력하시오." name="phone"></td>
                       </tr>
                       <tr>
                          <td style="color: gray; padding-left: 50px;">8자리로 입력하세요. ex) 01012345678</td>
                       </tr>
                   </table>
                </td>
            <tr>
                <td colspan="8" align="center"><button id="create" name="create">변경</button></td>
            </tr>  
        </table>
			</form>
		</td>
	</tr>
</table>
<center>
<%@ include file="/include/footer.jsp" %>
</center>
<%
}

rs.close();
stmt.close();
conn.close();
%>
