<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code");	//db: table명


//검색
String field, search, sql_search;

if(request.getParameter("search") != null && !request.getParameter("search").equals("")){	//검색을 한다면
	field = request.getParameter("field");
	search = request.getParameter("search");
	sql_search = " and "+field+" like '%"+search+"%'";
}else{
	field = "";
	search = "";
	sql_search = "";
}

//게시판 이름
String bbs_title = "";
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

/*전체 게시판 메뉴바(번호, 제목, 글쓴이, 날짜)*/
#all_bar{
    font-weight: bold;
    font-size: 18px;
    background-color: #96C8FF;
    text-align: center;
}
</style>
<table width=100% height=80 border=0>
	<tr>
		<td align=center style="font-size:25px;font-weight:bold;">[<%=bbs_title %>]</td>
	</tr>
</table>

<%
/////총 게시물 수 시작/////
String sql = "select count(*) from "+code+" where gongji != '1'";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

int total_record = 0;	
if(rs.next()){
	total_record = rs.getInt(1);
}

rs.close();
stmt.close();
con.close();
/////총 게시물 수 끝/////

//페이징 관련 변수들
int page_now = 1;	//현재 페이지
if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));
}

int num_per_page = 10; //한 페이지당 출력 게시물 수
int page_per_block = 3; //한 블럭당 출력 링크 수
int total_page = (int)Math.ceil(total_record / (double)num_per_page); //총 페이지 수
int first = num_per_page * (page_now - 1); //limit 시작 값
%>

<center>
<table width="1000" border="0">
	<tr>
		<td style=" font-weight: bold;">Total : <%=total_record %></td>
		<td align = "right">
			<form action="list.jsp" method="get">
				<input type="hidden" name = "code" value ="<%=code %>">
				<select name = "field" style="height: 20px;">
					<option value = 'subject' <%if(field.equals("subject")){%>selected<%}%>>제목</option>
					<option value = 'comment' <%if(field.equals("comment")){%>selected<%}%>>내용</option>
					<option value = 'name' <%if(field.equals("name")){%>selected<%}%>>글쓴이</option>
				</select>
				<input name = "search" value="<%=search %>" style="height: 20px;">
				<button>검색</button>
			</form>
		</td>
	</tr>
</table>

<table width="1000" border="0" id="all_table">
	<tr id="all_bar">
		<td width="60" align="center"><b>번호</b></td>
		<td width="440"><b>제목</b></td>
		<td width="100" align="center"><b>글쓴이</b></td>
		<td width="100" align="center"><b>날짜</b></td>
	</tr>
<%
if(page_now ==1){
	//공지글
	String sql_notice = "select * from "+code+ " where gongji='1'";
	
	Connection con_notice = DriverManager.getConnection(url, user, password);
	Statement stmt_notice = con_notice.createStatement();
	ResultSet rs_notice = stmt_notice.executeQuery(sql_notice);
	
	while(rs_notice.next()){
		int uid = rs_notice.getInt("uid");
		String signdate = rs_notice.getString("signdate");
		signdate = signdate.substring(0, 10);
		String file1 = rs_notice.getString("file1");
		String subject = rs_notice.getString("subject");
		
		//제목길이 ... 처리
		int len_num = subject.length();
		if(len_num > 30){
			subject = subject.substring(0, 30) + "...";
		}else{
			subject = subject;
		}
%>
	<tr height=22>
		<td align = center style="color: red">[공지]</td>
		<td  style = "padding-left: 10px;">
			<a href="view.jsp?code=<%=code%>&uid=<%=uid%>"><%=subject %></a>
			<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
		</td>
		<td align = center>관리자</td>
		<td align = center><%=signdate %></td>
	</tr>
	<tr><td colspan=4 style="border-top:1px solid #e5ecef"></td></tr>
<%
	}//while
}//if
%>

<%
//일반글, 비밀글
String s = "select * from "+code+" where gongji != '1' "+sql_search+ " order by uid desc limit "+first+","+num_per_page;

Connection c = DriverManager.getConnection(url, user, password);
Statement st = c.createStatement();
ResultSet rs2 = st.executeQuery(s);

int num = total_record - ((page_now - 1) * num_per_page); //넘버링 처리
while(rs2.next()){
	//String signdate = rs2.getString("signdate").substring(0, 10);
	int uid = rs2.getInt("uid");
	String signdate = rs2.getString("signdate");
	signdate = signdate.substring(0,10);
	String file1 = rs2.getString("file1"); //rename 파일명
	String gongji = rs2.getString("gongji");
	String id = rs2.getString("id");
	String subject = rs2.getString("subject");
	
	int len_num = subject.length();
	
	if(len_num > 30){
		subject = subject.substring(0, 30) + "...";
	}else{
		subject = subject;
	}
	
	//2일전까지 최신글 처리
	java.util.Date signdate2, day2;
	java.util.Date today = new java.util.Date();//현재날짜
	
	java.util.Date day_22 = new java.util.Date(today.getTime() - (long)(1000*60*60*24*2));//현재날짜 - 2일
	SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd");	//년-월-일 변경
	String day_2 = bbb.format(day_22);
	
	day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
	signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
%>
	<tr height=22>
		<td align = center><%=num %></td>
		<td style = "padding-left: 10px;">
			<%if( gongji.equals("3") ){//비밀글 %>
				<%if( session_level != null && (session_level.equals("10") || session_id.equals(id)) ){ %>
					<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><%=subject %></a>
				<%}else{ %>
					<span onclick="alert('관리자 or 작성자만 보실 수 있습니다.')"><%=subject %></span>
				<%} %>
			<%}else{ //일반글 %>
				<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><%=subject %></a>
			<%} %>
			
			<%if(signdate2.getTime() >= day2.getTime()){ %><img src = "img/main_new.gif"><%} %>
			<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
			<%if(gongji.equals("3")){//비밀글 %><img src = "img/icon_secret.gif"><%} %>
		</td>
		<td align = center><%=rs2.getString("name") %></td>
		<td align = center><%=signdate %></td>
	</tr>
	<tr><td colspan=4 style="border-top:1px solid #e5ecef"></td></tr>
<%
	num--;
}
%>

<%
if(total_record == 0){
	out.print("<tr><td colspan=4 height=150 align=center>게시물이 없습니다.</td></tr>");
}
%>	
</table>
<table width="1000" border="0">
	<tr>
		<td style = "padding-top: 20px;"><a href = "list.jsp?code=<%=code %>">[새로고침]</a></td>
		<td align=right style = "padding-top: 20px;">
			<%if(session_id != null){ //로그인 후 %>
			<a href="write.jsp?code=<%=code%>">[글쓰기]</a>
			<%}else{ %>
			[로그인 후 작성하실 수 있습니다.]
			<%} %>
		</td>
	</tr>
</table>
<br>

<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="text-align: center">

<style>
	.page_on {
		padding:0px 5px;
		color:blue;
		border:1px solid blue;
		font-weight:bold;
	}
	.page_off {
		padding:0px 5px;
		color:black;
		border:1px solid black;
	}
</style>

<%
//페이징 처리 시작
int total_block = 0;
int block = 0;
int first_page = 0;
int last_page = 0;
int direct_page = 0;
int my_page = 0;

total_block = (int)Math.ceil(total_page / (double)page_per_block); //총 블럭 수
block = (int)Math.ceil(page_now / (double)page_per_block); //현재 블럭
first_page = (block - 1) * page_per_block; //블럭내 시작하는 수
last_page = block * page_per_block; //블럭내 끝나는 수

if(total_block <= block) { //마지막 블럭일 때
	last_page = total_page; //반복문 변수 처리
}

//이전 블럭 처리			
if(block != 1){ //첫 블럭이 아니라면
%>
	<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=first_page%>"><img src="img/btn_left.gif"></a>&nbsp;&nbsp;
<%
}

//블럭내 페이지 수 출력 
for(direct_page = first_page + 1; direct_page <= last_page; direct_page++){
	if(page_now == direct_page){
%>
		<span class="page_on"><%=direct_page%></span>&nbsp;
<%
	}else{
%>
		<span class="page_off"><a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=direct_page%>"><%=direct_page%></a></span>&nbsp;
<%
	}
}

//다음 블럭 처리
if(block < total_block) { //다음 블럭 존재
%>
	&nbsp;<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=last_page + 1%>"><img src="img/btn_right.gif"></a>
<%
}
//페이징 처리 끝 /////////////////////////////			
%>
		</td>
	</tr>
</table>
<br>
<%@ include file="/include/footer.jsp" %>
</center>


