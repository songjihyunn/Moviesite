<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");

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

//원글 내용
String sql="select * from "+code+" where uid="+uid;

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(sql);

String subject = "";
String comment = "";
int fid = 0;
String thread = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	fid = rs.getInt("fid");
	thread = rs.getString("thread");
}

rs.close();
stmt.close();
conn.close();
%>

<style>
input , textarea {
	border:1px solid #e9e9e9;
	background:#f7f7f7;
}
</style>

<table width=100% height=50 border=0>
	<tr>
		<td align=center style="color:#777;font-size:14px;font-weight:bold;">[<%=bbs_title %>]_답변쓰기</td>
	</tr>
</table>

<center>
<form name="board" method="post" action="reply_insert.jsp" ENCTYPE="multipart/form-data">
<input type="hidden" name="code" value="<%=code%>">
<input type="hidden" name="field" value="<%=field%>">
<input type="hidden" name="search" value="<%=search%>">
<input type="hidden" name="page_now" value="<%=page_now%>">
<input type="hidden" name="fid" value="<%=fid%>">
<input type="hidden" name="thread" value="<%=thread%>">
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=28>옵션</td>
		<td>
			<input type="radio" name="gongji" value="2" checked>일반 
			<input type="radio" name="gongji" value="3">비밀 
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=28>제목</td>
		<td><input name="subject" style="height:20px;width:99%;" value="Re:<c:out value="<%=subject%>" escapeXml="true" />"></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="comment" style="height:92px;width:99%;">Re:<%=comment%></textarea>
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=28>첨부</td>
		<td><input type="file" name="file1"></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
</table>
<br>
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center"><button>작성완료</button></td>
	</tr>
</table>
<br>
</form>
</center>

<%@ include file="/include/footer.jsp" %>