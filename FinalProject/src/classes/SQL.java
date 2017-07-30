package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServlet;

public class SQL {
	private Connection conn;
    private Statement st;
    private ResultSet rs;
    private User u = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SQL(){
        // TODO Auto-generated constructor stub
        try {
    		Class.forName("com.mysql.jdbc.Driver");
    		conn = DriverManager.getConnection("jdbc:mysql://janus.c0lfgkv3xxys.us-west-1.rds.amazonaws.com:3306/janus?user=root&password=password");
    		st = conn.createStatement();
    		
    	}catch(SQLException sqle) {
    		System.out.println("sqle: " + sqle.getMessage());
    	}catch(ClassNotFoundException cnfe) {
    		System.out.println("cnfe: " + cnfe.getMessage());
    	}
    }
    public Statement getSt() {return st;}
}
