package backend;
import classes.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class edit_profile
 */
@WebServlet("/edit_profile")
public class edit_profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] selected = request.getParameterValues("skill");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String bio = request.getParameter("bio");
		User u = (User)request.getSession().getAttribute("currUser");
		u.setBio(bio);
		u.setEmail(email);
		u.setFName(fname);
		u.setLName(lname);
		u.setPhone(phone);
		SQL db=new SQL();
		Statement st=db.getSt();
		String username = u.getUsername();
		try {
    		st.execute("UPDATE users SET fname='" + fname + "', lname='" + lname
    				+ "', email='" + email + "', phone='" + phone + "' WHERE username='" + username + "';");
    		ResultSet rs = st.executeQuery("SELECT userID FROM users WHERE username='" + username + "';");
    		List<Integer> skills = new  ArrayList<Integer>();
    		if(selected != null) {
    			for(int i = 0 ; i < selected.length; i++)
    			{
    				String sql="SELECT skillID FROM skills where skillname='"+selected[i]+"' ;";
    				rs=st.executeQuery(sql);
    				int skillID=0;
    				if(rs.next())
    				{
    					skillID=rs.getInt("skillID");
    				}
    				skills.add(skillID);
    				u.addSkills(skillID);
    			}
    			String sql = "SELECT userID FROM users WHERE username='" + username + "';";
    			rs = st.executeQuery(sql);
    			int userID = 0;
    			while(rs.next()) {userID = rs.getInt("userID");}
    			sql = "INSERT INTO user_skills (userID, skillID) VALUES ";
    			for(int i = 0; i < skills.size() - 1; i++) {
    				sql += "('" + userID + "', '" + skills.get(i) + "'), ";
    			}
    			sql += "('" + userID + "', '" + skills.get(skills.size()-1) + "'); ";
    			st.execute(sql);
    		}
			
			
    	}catch(SQLException sqle) {
    		System.out.println("sqle: " + sqle.getMessage());
    	}
		request.getSession().setAttribute("currUser", u);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/profile.jsp");
        dispatch.forward(request, response);
	}

}