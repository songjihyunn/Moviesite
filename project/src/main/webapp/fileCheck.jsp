<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String subject=request.getParameter("subject");
	String filename1=request.getParameter("filename1");
	String filename2=request.getParameter("filename2");
	String origfilename1=request.getParameter("origfilename1");
	String origfilename2=request.getParameter("origfilename2");
%>
<html>
<head>
<title>파일 업로드 확인 및 다운로드</title>
</head>
<body>

올린 사람 : <%=name %><br>
제목 : <%=subject %><br>
파일명1 : <a href="upload/<%=origfilename1 %>" download><%=origfilename1 %></a><br>
파일명2 : <a href="upload/<%=origfilename2 %>" download><%=origfilename2 %></a><p>
<img src="/upload/<%=origfilename1 %>"><br>	
<img src="/upload/<%=origfilename2 %>"><br>
</body>
</html>