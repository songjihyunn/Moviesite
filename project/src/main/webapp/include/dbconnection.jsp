
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
//디비 접속	
Class.forName("com.mysql.jdbc.Driver");
//Class.forName("org.mariadb.jdbc.Driver")
String url="jdbc:mysql://localhost:3306/project1?useUnicode=true&characterEncoding=utf8";
String user="root";
String password="1111";
%>