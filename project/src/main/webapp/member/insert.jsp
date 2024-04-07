<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/dbconnection.jsp" %>
    
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String birth = request.getParameter("birth");
String phone = request.getParameter("phone");
%>

id: <%=id %><br>
pw: <%=pw %><br>
name: <%=name %><br>
nickname: <%=nickname %><br>
birth: <%=birth %><br>
phone: <%=phone %><br>


<%

String s = "select count(*) from member where id = '"+id+"'";
Connection c = DriverManager.getConnection(url, user, password);
Statement st = c.createStatement();
ResultSet rs = st.executeQuery(s);

int num = 0;
if(rs.next()){
	num = rs.getInt(1);
}

rs.close();
st.close();
c.close();

if(num == 1){
%>
	<script>
		alert("아이디가 존재합니다. \n다른 아이디를 이용하세요.");
		history.back();
	</script>
<%	
}else{
	String sql = "insert into member values ('"+id+"','"+pw+"','"+name+"','"+nickname+"','"+birth+"','"+phone+"', '1')";

	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	
}
%>
<script>
	alert("회원가입을 완료하였습니다.");
	location.href='/';
</script>
