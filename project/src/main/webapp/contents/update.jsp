<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%

//파일 저장 폴더 생성 경로(프로젝트 안에 upload 폴더 생성 및 지정 추천) 

String uploadPath="C:\\jsp\\project\\src\\main\\webapp\\upload"; //window 폴더 경로
int size=10*1024*1024; //파일 최대 사이즈 (10메가)

request.setCharacterEncoding("utf-8");

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String uid = multi.getParameter("uid");
String page_now = multi.getParameter("page_now");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");
String updateDate = multi.getParameter("open_d");

Enumeration files=multi.getFileNames();

//첨부파일1
String file1=(String)files.nextElement(); //첨부파일1 존재한다면
String file1_name=multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename=multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경

if(file1_name == null){ //첨부파일1 없다면
	file1_name = ""; //null 값이 아닌 비어있는 값으로 대체
	file1_rename = ""; //null 값이 아닌 비어있는 값으로 대체
}

String open_d = multi.getParameter("open_d");
if(open_d == null){
	open_d="2024-04-04";
}

//이스케이프 처리
subject = subject.replaceAll("'", "''" ); //좌측의 값을 우측의 값으로 치환
comment = comment.replaceAll("'", "''" );

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(today);

//디비 수정
String sql;
if(file1_name != null && file1_name != ""){ //첨부파일 존재
	sql = "update "+code+" set subject='"+subject+"',comment='"+comment+"',gongji='"+gongji+"',file1='"+file1_rename+"',file1_o='"+file1_name+"',open_d='"+updateDate+"' where uid="+uid;
}else{
	sql = "update "+code+" set subject='"+subject+"',comment='"+comment+"',gongji='"+gongji+"',open_d='"+updateDate+"' where uid="+uid;
}

Connection conn=DriverManager.getConnection(url, user, password); 
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();

response.sendRedirect("list.jsp?code="+code+"&page_now="+page_now);
%>