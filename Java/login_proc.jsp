﻿<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pw = request.getParameter("pw");

boolean login = false;

String url = "jdbc:sqlserver://192.168.133.101:1819;databaseName=MarioEIS;user=devSa;password=mario12#$;";
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
Connection conn;
Statement stmt;
ResultSet rs;

conn = DriverManager.getConnection(url);
stmt = conn.createStatement();
rs = stmt.executeQuery("SELECT * FROM MARIOEIS..USER_LIST WHERE ID ='"+id+"' AND PW = '"+pw+"'");
while(rs.next()){
	stmt = conn.createStatement();
	stmt.executeUpdate("UPDATE MARIOEIS..USER_LIST SET LOGIN_DT = CONVERT(VARCHAR(8), GETDATE(), 112) WHERE ID ='"+id+"' AND PW = '"+pw+"'");
	session.setAttribute("id", id);
	session.setMaxInactiveInterval(60*60);

	
	login = true;
	
}
stmt.close();
rs.close();
conn.close();

if(login == true){
	response.sendRedirect("main.jsp");
}
else{
	out.println("<script>alert('아이디 또는 비밀번호를 확인하세요');history.go(-1);</script>");
}


%>