<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<style>
/*전체 게시판 메뉴바(번호, 제목, 글쓴이, 날짜)*/
#all_bar{
    font-weight: bold;
    font-size: 18px;
    background-color: #96C8FF;
    text-align: center;
}
</style>
<%

String code = request.getParameter("code");	//db: table명

//검색
String keyword, sql_search;

if(request.getParameter("keyword") != null && !request.getParameter("keyword").equals("")){ //검색을 한다면
	keyword = request.getParameter("keyword");
	sql_search = " and ( subject like '%"+keyword+"%' or comment like '%"+keyword+"%' ) ";
}else{
	keyword = "";
	sql_search = "";
}

//게시판 이름
String[] bbs_name = new String[] { "free", "info", "notice", "qna"};
%>

<%
//////////// 총 게시물 수 시작 ////////////
int total_record = 0;

for(int i=0; i<bbs_name.length; i++){
	String sql = "select count(*) from "+bbs_name[i]+ " where gongji != '1' "+sql_search;

	Connection con = DriverManager.getConnection(url, user, password);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(sql);

	if(rs.next()){
		total_record += rs.getInt(1);
	}

	rs.close();
	stmt.close();
	con.close();
}
////////////총 게시물 수 끝 ////////////
%>

<center>
<table border="0">
<tr>
<td style = "width: 200px; height: 100px; text-align: center">
	<strong style = "font-size: 25px;">[검색 결과]</strong>
</td>
</tr>
</table>
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr id = "all_bar">
		<td width="100" align="center"><b>게시판</b></td>
		<td width="440"><b>제목</b></td>
		<td width="100" align="center"><b>글쓴이</b></td>
		<td width="100" align="center"><b>날짜</b></td>
	</tr>
<%
//일반글, 비밀글
for(int i=0; i<bbs_name.length; i++){
	String s = "select * from "+bbs_name[i]+" where gongji != '1' "+sql_search+ " order by uid desc";
	
	Connection c = DriverManager.getConnection(url, user, password);
	Statement st = c.createStatement();
	ResultSet rs2 = st.executeQuery(s);
	
	while(rs2.next()){
		//String signdate = rs2.getString("signdate").substring(0, 10);
		int uid = rs2.getInt("uid");
		String signdate = rs2.getString("signdate");
		signdate = signdate.substring(0, 10);
		String file1 = rs2.getString("file1");//rename 파일명
		String gongji = rs2.getString("gongji");
		String id = rs2.getString("id"); //작성자
		String subject = rs2.getString("subject");
		
		//제목 길이 ... 처리
		int len_num = subject.length();
		
		if(len_num > 30){
			subject = subject.substring(0,30) + "...";
		}else{
			subject = subject;
		}
		
		//2일전까지 최신글 처리
		java.util.Date signdate2, day2;
	
		java.util.Date today = new java.util.Date(); //현재 날짜
	
		java.util.Date day_22 = new java.util.Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
		SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
		String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입
	
		day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
		signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
%>
<tr height=22>
		<td align=center><%=bbs_name[i]%></td>
		<td style = "padding-left: 10px;">
			<%if( gongji.equals("3") ){//비밀글 %>
				<%if( session_level != null && (session_level.equals("10") || session_id.equals(id)) ){ %>
					<a href="/bbs/view.jsp?code=<%=bbs_name[i]%>&uid=<%=uid%>"><%=subject %></a>
				<%}else{ %>
					<span onclick="alert('관리자 or 작성자만 보실 수 있습니다.')"><%=subject %></span>
				<%} %>
			<%}else{ //일반글 %>
				<a href="/bbs/view.jsp?code=<%=bbs_name[i]%>&uid=<%=uid%>"><%=subject %></a>
			<%} %>			

			<%if(signdate2.getTime() >= day2.getTime()){%><img src="img/main_new.gif"><%}%>
			<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
			<%if(gongji.equals("3")){//비밀글 %><img src="img/icon_secret.gif"><%} %>
		</td>
		<td align=center><%=rs2.getString("name") %></td>
		<td align=center><%=signdate %></td>
	</tr>
	<tr><td colspan=4 style="border-top:1px solid #e5ecef"></td></tr>
<%
	}
}
%>

<%
if(total_record == 0){
	out.print("<tr><td colspan=4 height=150 align=center>게시물이 없습니다.</td></tr>");
}
%>
</table>

</center>
<table>
<tr>
<td style = "height: 20px;"></td>
</tr>
</table>
<%@ include file="/include/footer.jsp" %>