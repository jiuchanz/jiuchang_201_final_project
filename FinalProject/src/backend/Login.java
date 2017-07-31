package backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.*;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection conn;
    private Statement st;
    public ResultSet rs;
    private User u = null;
    /**
     * 
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String username=request.getParameter("uname");
		  String password=request.getParameter("psw");
		  u = new User(username, password);
		  Vector<Project> projects = new Vector<Project>(1,1);
		  
		  try {
			  String sql = "SELECT fname, lname, email, phone, userID FROM users WHERE username='" + username + "';";
			  rs = st.executeQuery(sql);
			  if(rs.next()) {
				  u.setFName(rs.getString("fname"));
				  u.setLName(rs.getString("lname"));
				  u.setEmail(rs.getString("email"));
				  u.setPhone(rs.getString("phone"));
				  u.setID(rs.getInt("userID"));
			  }
			  //System.out.println(u.getFname() + " " + u.getLname() + " " + u.getEmail() + " " + u.getPhone());
			  //add skills to user
			  int userID = u.getID(); 
			  sql = "SELECT skillID FROM user_skills WHERE userID='" + userID + "';";
			  rs = st.executeQuery(sql);
			  while(rs.next()){
				  u.addSkills(rs.getInt("skillID"));
			  }
			  //add projects to user class
			  sql = "SELECT projectID FROM user_projects WHERE userID='" + userID + "';";
			  rs = st.executeQuery(sql);
			  while(rs.next()) {
				  u.insertProject(rs.getInt("projectID"));
			  }
			  //create all projects
			  sql = "SELECT * FROM projects;";
			  rs = st.executeQuery(sql);
			  while(rs.next()) {
				  int adminId = rs.getInt("adminID");
				  int projectID = rs.getInt("projectID");
				  String projectName = rs.getString("projectName");
				  String projectAbstract = rs.getString("abstract");
				  String description = rs.getString("description");
				  Project p = new Project(adminId, projectName, projectAbstract, description);
				  p.addProjectID(projectID);
				  projects.add(p);
			  }
			  //add skills to projects
			  for(int i = 0; i < projects.size(); i++) {
				  int projectID = projects.get(i).getProjectID();
				  sql = "SELECT skillID FROM project_skill WHERE projectID='" + projectID + "';";
				  ResultSet r = st.executeQuery(sql);
				  while(r.next()) {
					  int skill = r.getInt("skillID");
					  projects.get(i).addSkill(skill);
				  }
			  }
			  
		  }catch(SQLException sqle) {
			  System.out.println("sqle: " + sqle.getMessage());
		  }
		  request.getSession().setAttribute("projects", projects);
		  request.getSession().setAttribute("currUser", u);
		  request.getRequestDispatcher("user_listing.jsp").forward(request, response);
	}

}