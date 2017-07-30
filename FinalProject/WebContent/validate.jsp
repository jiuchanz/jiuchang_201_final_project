<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement" 
		 import ="backend.PasswordStorage"	%>
<%
	String uname = request.getParameter("uname");
	String psw = request.getParameter("psw");
	String errorMessage = "";
	if(uname == null || uname.trim().length() == 0 || psw == null || psw.trim().length() == 0){
		errorMessage = "<font color=\"red\">Please enter a username and password</font>";
	}
	String username, password;
	boolean login=false;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/studentgrades?user=root&password=root");
		Connection conn = DriverManager.getConnection("jdbc:mysql://janus.c0lfgkv3xxys.us-west-1.rds.amazonaws.com:3306/janus?user=root&password=password");
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("SELECT username,userPassword FROM janus.users " + 
				"	where username = '" + uname+"';");
		while(rs.next()) {
			username = rs.getString("username");
			password = rs.getString("userPassword");
			try{
			if(username.equals(uname) && PasswordStorage.verifyPassword(psw, password)){
				login=true;
			}
			} catch (Exception e){
				login = false;
			}
		}
		rs.close();
		st.close();
		conn.close();
	}catch(SQLException sqle) {
		System.out.println("sqle: " + sqle.getMessage());
	}catch(ClassNotFoundException cnfe) {
		System.out.println("cnfe: " + cnfe.getMessage());
	}
	if(!login){
		errorMessage = "<font color=\"red\">Incorrect username and password</font>";
	}
%>
<%= errorMessage %>