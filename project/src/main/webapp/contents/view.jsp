<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code");	//db: table명
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
%>

<style>
input , textarea {
	border:1px solid #e9e9e9;
	background:#f7f7f7;
}
</style>

<table width=100% height=50 border=0>
	<tr>
		<td align=center style="font-size:21px;font-weight:bold;">[<%=bbs_title %>]_상세보기</td>
	</tr>
</table>

<%
String sql = "select * from "+code+" where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id = ""; //작성자
if(rs.next()){
	String g = rs.getString("gongji");
	String g_h = "";
	if(g.equals("1")){
		g_h = "공지글";
	}else if(g.equals("2")){
		g_h = "일반글";
	}else{
		g_h = "비밀글";
	}	
	
	//commnet 개행처리
	String comment = rs.getString("comment");
	pageContext.setAttribute("cmt", comment);
	pageContext.setAttribute("LF", "\n");
	String file1 = rs.getString("file1");	//첨부파일
	
	id = rs.getString("id");
	
	//비밀글일때
	if(g.equals("3")){
		if(session_level != null && ( session_level.equals("10") || session_id.equals(id) )){
		}else{
%>
	<script>
		alert('비밀글입니다. 확인 하실 수 없습니다.');
		window.history.back();
	</script>
<%
		}
	}
%>
<center>
<table width="1000" border="0" cellpadding="0" cellspacing="0" style="font-weight: bold">
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=26>옵션</td>
		<td><%=g_h %></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=26>제목</td>
		<td><%=rs.getString("subject") %></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
	<%
		java.sql.Date openDate = rs.getDate("open_d");
	    String formatDate = "";
	    java.sql.Date updateDate = openDate;
	    
	    if (openDate != null) {
	       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	       formatDate = sdf.format(openDate);
	       updateDate = java.sql.Date.valueOf(formatDate);
	    } else {
	       formatDate = "No Date";
	    }

	%>
	<%if(code.equals("info")) {%>
		<td height=28>개봉일</td>
        <td style="width: 25; height:35;font-weight: bold;"><%=updateDate%></td>
        <%} %>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td>내용</td>
		<td style = "padding-bottom: 10px;">
			${fn:replace(cmt, LF, '<br>')}<br>
			<%if(!file1.equals("")){ //첨부파일 존재 %>
			<% 
				String imagePath = "/upload/" + file1;
			
			int resizedWidth = 200;
			%>
			<img src = "<%=imagePath%>" style = "max-width: <%=resizedWidth%>px;">
			<%} %>
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
</table>
<br>
<%
}
rs.close();
stmt.close();
con.close();
%>
<!-- 한줄 댓글 목록 -->
<%
//댓글 목록
String sql_comment="select * from comment where tb_table='"+code+"' and tb_uid="+uid;

Connection conn_comment=DriverManager.getConnection(url, user, password);
Statement stmt_comment=conn_comment.createStatement();
ResultSet rs_comment=stmt_comment.executeQuery(sql_comment);
%>
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<% 
	while(rs_comment.next()){
		String mem_id = rs_comment.getString("tb_id");
		int mem_uid = rs_comment.getInt("uid");
	%>
	<tr>
		<td><%=rs_comment.getString("tb_id") %></td>
		<td>
			<%=rs_comment.getString("tb_comment") %>
			<% if(session_level != null && (session_level.equals("10") || mem_id.equals(session_id))){ 
			%>
			<img src="img/comment_del.gif" onclick="comment_delete(<%=mem_uid%>)">
			<%} %>
		</td>
		<td><%=rs_comment.getString("tb_date") %></td>
	</tr>
	<%
	} 
	%>
</table>
<form action="comment_insert.jsp" method="post" onsubmit="return send()">
<input type="hidden" name="code" value="<%=code %>">
<input type="hidden" name="uid" value="<%=uid %>">


<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr height=30>
		<td width=610><input id="view_comment" name="view_comment" style="width:99%"></td>
		<td width=90 align=right>
			<%if(session_id != null){ %>
			<button>댓글등록</button>
			<%}else{ %>
			<input type="button" onclick="javascript:alert('로그인 후 사용 가능합니다..')" value="댓글등록">
			<%} %>
		</td>
	</tr>
	<tr><td colspan=2 height=1 width=100% bgcolor=#97b1ec></td></tr>
</table>
</form>

<script>
function send(){
	member_id = "<%=session_id%>";
	if(member_id == null){
		alert("로그인을 한 후 작성하실 수 있습니다.");
		return false;
	}
	if(!view_comment.value){
		alert("댓글 내용을 입력하세요.");
		view_comment.focus();
		return false;
	}
}
function delete_go(){
	result = confirm("삭제하시겠습니까?");
	if(result == true){
		location.href = "delete.jsp?code=<%=code%>&uid=<%=uid%>";
	}
}
function comment_delete(num){
	result = confirm("한줄 댓글을삭제하시겠습니까?");
	if(result == true){
		location.href = "comment_delete.jsp?code=<%=code%>&uid=<%=uid%>"+num;
	}
}
</script>
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><a href="list.jsp?code=<%=code%>">[목록]</a></td>
		<td align=right>
		<%if(session_level !=null && (session_level.equals("10") || session_id.equals(id))){ %>
			<a href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>">[수정]</a>
			<a onclick="delete_go()">[삭제]</a>
		<%}else{ %>
			<span onclick="alert('작성자만 수정하실 수 있습니다.')">[수정]</span>
			<span onclick="alert('작성자만 삭제하실 수 있습니다.')">[삭제]</span>
		<%} %>
		</td>
	</tr>
</table>
<br>
<%@ include file="/include/footer.jsp" %>
</center>

