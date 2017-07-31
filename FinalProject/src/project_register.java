

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;

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
			Set<Integer> skills=new HashSet<Integer>();
			if(selected!=null)
			{
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
			}
			
			Project project =new Project(userID,projectName,brief,description);
			project.setSkillSet(skills);
			
			project.addProjectToDB(st);
			
			
			HttpSession session =request.getSession();
			Vector<Project> projects=new Vector<Project>();
			
			session.setAttribute("projectname", project.getProjectName());
	         
	        
	         
			  sql = "SELECT * FROM projects;";
			  rs = st.executeQuery(sql);
			  
			  while(rs.next()) {
				  int adminId = rs.getInt("adminID");
				  int projectID = rs.getInt("projectID");
				  projectName = rs.getString("projectName");
				  String projectAbstract = rs.getString("abstract");
				  description = rs.getString("description");
				  Project p = new Project(adminId, projectName, projectAbstract, description);
				  p.addProjectID(projectID);
				  p.setOpenstatus(rs.getBoolean("openstatus"));
				  projects.add(p);
			  }
			  for(int i = 0; i < projects.size(); i++) {
				  int projectID = projects.get(i).getProjectID();
				  sql = "SELECT skillID FROM project_skill WHERE projectID='" + projectID + "';";
				  ResultSet r = st.executeQuery(sql);
				  while(r.next()) {
					  int skill = r.getInt("skillID");
					  projects.get(i).addSkill(skill);
				  }
			  }
			  session.setAttribute("projects", projects);
			
			  RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/project_detail.jsp");
		         dispatch.forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
