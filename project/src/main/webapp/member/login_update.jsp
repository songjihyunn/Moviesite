<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/include/header.jsp" %>

<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");

String sql = "select count(*) from member where id  = '"+id+"'";	//총 게시물 수

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);	//select

int total = 0;

while(rs.next()){
	total = rs.getInt(1);
}

if(total == 1){	//존재하는 아이디
	//아이디, 비밀번호 매칭 작업 - 로그인 완료 처리
	String sql2 = "select count(*) from member where id  = '"+id+"' and pw= '"+pw+"'";

	Connection conn2 = DriverManager.getConnection(url, user, password);
	Statement stmt2 = conn2.createStatement();
	ResultSet rs2 = stmt2.executeQuery(sql2);

	int total2 = 0;
	
	if(rs2.next()){
		total2 = rs2.getInt(1);
	}
	
	if(total2 ==1){
		//세션 처리 - 로그인 완료
		String sql3 = "select * from member where id  = '"+id+"'";

		Connection conn3 = DriverManager.getConnection(url, user, password);
		Statement stmt3 = conn3.createStatement();
		ResultSet rs3 = stmt3.executeQuery(sql3);	//select

		if(rs3.next()){
			session.setAttribute("id", rs3.getString("id"));
			session.setAttribute("name", rs3.getString("name"));
			session.setAttribute("pw", rs3.getString("pw"));
			session.setAttribute("level", rs3.getString("level"));
		}
	}else{
%>
		<script>
			alert("비밀번호가 틀립니다.");
			history.back();
		</script>
<%
	}

}else{
	%>
	<script>
		alert("아이디가 존재하지 않습니다.");
		history.back();
	</script>
<%
}
%>

<script>
	location.href="/";
</script>