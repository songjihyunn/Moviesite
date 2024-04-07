<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();	//내가 만든 세션 속성들 삭제 처리
	
	response.sendRedirect("/");	//첫 페이지 이동
%>