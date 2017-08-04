<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="classes.*, java.sql.*"%>
<%
	String username = request.getParameter("username");
	int projectID = Integer.valueOf(request.getParameter("projectID"));
	String output= "";
	try{
		SQL sq = new SQL();
		Statement st = sq.getSt();
		String sql = "SELECT userID FROM users WHERE username ='" + username +"';";
		ResultSet rs = st.executeQuery(sql);
		int userID = 0;
		if(rs.next()){
			userID = rs.getInt("userID");
		}
		sql = "INSERT INTO user_projects (userID, projectID) VALUES (" + userID + "," + projectID + ");";
		st.execute(sql);
		output = "SUCCESS";
	}catch(SQLException sqle) {
		  output = "FAIL";
		  System.out.println("sqle: " + sqle.getMessage());
	}
%>
<%= output %>