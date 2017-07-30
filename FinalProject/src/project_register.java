

import java.io.IOException;
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
import javax.servlet.http.HttpSession;

import classes.Project;
import classes.SQL;
import classes.User;

/**
 * Servlet implementation class project_register
 */
@WebServlet("/project_register")
public class project_register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] selected = request.getParameterValues("skill");
		
			
		String projectName=request.getParameter("projectname");
		String description=request.getParameter("description");
		String brief=request.getParameter("abstract");
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		String email=request.getParameter("email");
		SQL db=new SQL();
		Statement st=db.getSt();
		
		try {
			String sql="SELECT userID FROM users where lname='"+lname+"' and fname='"+fname+"';";
			ResultSet rs=st.executeQuery(sql);
			int userID=0;
			while(rs.next())
			{
				userID=rs.getInt("userID");
			}
			System.out.println(userID);
			List<Integer> skills=new  ArrayList<Integer>();
			for(int h=0;h<selected.length;h++)
			{
				sql="SELECT skillID FROM skills where skillname='"+selected[h]+"' ;";
				rs=st.executeQuery(sql);
				int skillID=0;
				while(rs.next())
				{
					skillID=rs.getInt("skillID");
				}
				skills.add(skillID);
				
			}
			Project project =new Project(userID,projectName,brief,skills,description);
			project.addProjectToDB(st);
			
			HttpSession session =request.getSession();
	         session.setAttribute("project",project);
	         session.setAttribute("user",new User("guest","root"));
	         RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/project_detail.jsp");
	         dispatch.forward(request, response);
			
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
