package classes;
import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Project {
	private String projectName;
	private int projectID;
	private Set<Integer> skills = new HashSet<Integer>();
	private String projectAbstract;
	private String description;
	private int administratorID;
	private boolean openstatus=true;
	public Project(int userId, String projectName, String projectAbstract, String description) {
		administratorID = userId;
		this.projectName = projectName;
		this.projectAbstract = projectAbstract;
		this.description = description;
	}//ends project constructor
	public void setOpenstatus(boolean value){this.openstatus=value;}
	public boolean getOpenstatus() {return openstatus;}
	public int getProjectID() {
		return projectID;
	}
	public void addProjectID(int p) {
		projectID = p;
	}
	
	public String getProjectName() {
		return projectName;
	}//ends getProjectName
	public String getProjectAbstract() {
		return projectAbstract;
	}//ends getProjectName
	public String getProjectDescription() {
		return description;
	}//ends getProjectDescription
	public Integer getProjectContactID() {
		return administratorID;	
	}//ends getProjectContactID
	public Set<Integer> getSkillSet(){
		return skills;
	}//ends getSkillSet
	public Project getProject() {
		return this;
	}//ends getProject
	
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}//ends getProjectName
	public void setProjectAbstract(String projectAbstract) {
		this.projectAbstract = projectAbstract;
	}//ends getProjectName
	public void setProjectDescription(String description) {
		this.description = description;
	}//ends getProjectDescription
	public void addSkill(int skill) {
		skills.add(skill);
	}
	public void setSkillSet(Set<Integer> skills) {this.skills=skills;}
	public void addProjectToDB(Statement st)
	{
		int projectID=0;
		try {
			String sql="insert into projects (projectname,abstract,description,adminID,openstatus) value ('"+projectName+"','"+projectAbstract+"','"+description+"','"+administratorID+"',1);";
			System.out.println(sql);
			st.execute(sql);
			sql="select projectID from projects where projectname='"+projectName+"';";
			System.out.println(sql);
			ResultSet rs=st.executeQuery(sql);
			
			while(rs.next())
				projectID=rs.getInt("projectID");
			sql="insert into project_skill (skillID,projectID) value";
			int idx=0;
			for(Integer i : skills)
			{
				if(idx>0) sql+=",";
				sql+="("+i+","+projectID+")";
				idx=1;
				
			}
			sql+=";";
			System.out.println(sql);
			st.execute(sql);
			sql="insert into user_projects (userID,projectID) value("+administratorID+","+projectID+");";
			System.out.println(sql);
			st.execute(sql);
			
			
			
			    
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}//ends project class
