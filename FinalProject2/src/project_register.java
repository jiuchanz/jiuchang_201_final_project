

import java.io.IOException;
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
		List<String> skillnames = null;
		
		try {
			String sql="SELECT userID FROM users where lname='"+lname+"' and fname='"+fname+"';";
			ResultSet rs=st.executeQuery(sql);
			int userID=0;
			while(rs.next())
			{
				userID=rs.getInt("userID");
			}
			//System.out.println(userID);
			List<Integer> skills=new  ArrayList<Integer>();
			skillnames = new ArrayList<String>();
			for(int h=0;h<selected.length;h++)
			{
				sql="SELECT skillID FROM skills where skillname='"+selected[h]+"' ;";
				rs=st.executeQuery(sql);
				int skillID=0;
				while(rs.next())
				{
					skillID=rs.getInt("skillID");
					//System.out.println(skillID);
				}
				skills.add(skillID);
				skillnames.add(selected[h]);
				
			}
			Project project =new Project(userID,projectName,brief,description);
			/*
			for (int temp =0; temp < skills.size(); temp++) {
			
				project.addSkill(skills.get(temp));
			} */ 
			project.addProjectToDB(st);
			List<User> recommendUsers = project.recommendUsers(st);
			HttpSession session =request.getSession();
	        
	         session.setAttribute("recommendUsers", recommendUsers);
	         session.setAttribute("user",new User("guest","root"));
	         sql="select * from skills";
			  ResultSet r=st.executeQuery(sql);
			  Vector<String> skillnames1=new Vector<String> ();
			  skillnames1.add("");
			  while(r.next())
			  {
				  skillnames1.add(r.getString("skillName"));
			  }
			  request.getSession().setAttribute("skillnames",skillnames1);
			  request.getSession().setAttribute("projectname", projectName);
			  
			  Vector<Project> projects = new Vector<Project>(1,1);
			  sql = "SELECT * FROM projects;";
			  rs = st.executeQuery(sql);
			  int pID=0;
			  while(rs.next()) {
				  int adminId = rs.getInt("adminID");
				  int projectID = rs.getInt("projectID");
				  String projectName1 = rs.getString("projectName");
				  String projectAbstract = rs.getString("abstract");
				  String description1 = rs.getString("description");
				  Project p = new Project(adminId, projectName1, projectAbstract, description1);
				  p.addProjectID(projectID);
				  projects.add(p);
				  if(p.getProjectName().equals(project.getProjectName())) pID=p.getProjectID();
			  }
			  request.getSession().setAttribute("projects", projects);
			  
	         RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/project_detail.jsp?userID="+userID+"&pID=" + pID);
	         dispatch.forward(request, response);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
