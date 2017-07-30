package backend;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.User;

/**
 * Servlet implementation class User_register
 */
@WebServlet("/User_register")
public class User_register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection conn;
    private Statement st;
    private ResultSet rs;
    private User u = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public User_register() {
        super();
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


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
		rs = st.executeQuery("SELECT username FROM janus.users " + 
				"	where username = '" + username+"';");
		if(rs.next()) {
			request.setAttribute("message", "This username is taken, please choose another one");
			request.getRequestDispatcher("/user_register.jsp").forward(request, response);
		} else {
		String hash = PasswordStorage.createHash(password);
		st.execute("INSERT into janus.users(username,userPassword) values('"+username+"','"+hash+"');");
		
		rs = st.executeQuery("SELECT username FROM janus.users " + 
				"	where username = '" + username+"';");
		rs.next();
		}
		
		
		
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

}
