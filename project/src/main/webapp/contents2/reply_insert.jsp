<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨짐 방지

//파일 저장 폴더 생성 경로(프로젝트 안에 upload 폴더 생성 및 지정 추천) 
//String uploadPath=request.getRealPath("/upload");
String uploadPath="D:\\jsp_academy\\project\\src\\main\\webapp\\upload"; //window 폴더 경로
int size=10*1024*1024; //파일 최대 사이즈 (10메가)

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code=multi.getParameter("code");
String gongji=multi.getParameter("gongji");
String subject=multi.getParameter("subject");
String comment=multi.getParameter("comment");

String field=multi.getParameter("field");
String search=multi.getParameter("search");
String page_now = multi.getParameter("page_now");

int fid = Integer.parseInt(multi.getParameter("fid"));
String thread=multi.getParameter("thread");

Enumeration files=multi.getFileNames();

//첨부파일1
String file1=(String)files.nextElement(); //첨부파일1 존재한다면
String file1_name=multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename=multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경

if(file1_name == null){ //첨부파일1 없다면
	file1_name = ""; //null 값이 아닌 비어있는 값으로 대체
	file1_rename = ""; //null 값이 아닌 비어있는 값으로 대체
}

//홑따옴표 처리
subject = subject.replaceAll("'", "''" );
comment = comment.replaceAll("'", "''" );

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd");
String signdate = cal.format(today);

//thread 값 설정
//locate('AB' , 'ABA') = 1 :: 첫항의 'AB'가 두번째 항의 내용 중에 1번째 자리부터 매칭이 있는지 여부
String sql_fid = "select right(thread,1) as thread_right from "+code+" where fid = "+fid+" AND length(thread) = length('"+thread+"')+1 AND locate('"+thread+"',thread) = 1 ORDER BY thread DESC limit 1";

Connection conn_count=DriverManager.getConnection(url, user, password);
Statement stmt_count=conn_count.createStatement();
ResultSet rs_count=stmt_count.executeQuery(sql_fid);

String new_thread  = thread + "A";
if(rs_count.next()){ //형제 thread 추출
	String r_thread = rs_count.getString("thread_right");
	new_thread  = thread + (char)(r_thread.charAt(0) + 1);
}

rs_count.close();
stmt_count.close();
conn_count.close();

//디비 입력
String sql = "INSERT INTO "+code+" (id,name,subject,comment,signdate,ref,gongji,file1,file1_o,fid,thread)";
	sql = sql + " VALUES ('"+session_id+"','"+session_name+"','"+subject+"','"+comment+"','"+signdate+"',0,'"+gongji+"','"+file1_rename+"','"+file1_name+"',"+fid+",'"+new_thread+"')";

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();
%>
<script>
	location.href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>