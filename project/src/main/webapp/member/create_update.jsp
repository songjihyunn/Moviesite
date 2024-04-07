<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");	//한글 깨짐 방지

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String birth = request.getParameter("birth");
String phone = request.getParameter("phone");

//회원수정 처리 부분
String sql = "update member set pw = '"+pw+"', name = '"+name+"', nickname = '"+nickname+"', birth = '"+birth+"', phone = '"+phone+"' where name = '"+session_name+"' ";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();

%>
<script>
	alert("수정 완료");
	location.href="/";
</script>