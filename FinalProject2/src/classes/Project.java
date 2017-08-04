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
	private List<User> rec_user = new ArrayList<User>();
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
	public int getProjectContactID() {
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
	public List<User> get_rec(){
		return rec_user;
	}
	public Map<Integer, Integer> matchSort(Map<Integer, List<Integer>> map, Map<Integer, Integer> results) {
		// count the frequency of projectskill and userskill matching
		// sort in descending order
		for (Integer projectSkill : skills) {
			//System.out.println("projectSkill:" + projectSkill);
			for (Map.Entry<Integer, List<Integer>> entry : map.entrySet()) {
				List<Integer> valueList = entry.getValue();
				for (Integer num : valueList) {
					if (projectSkill == num) {
						results.put(entry.getKey(), results.get(entry.getKey()) + 1);
					} // ends if
				} // ends for
			} // ends for
		} // ends for

		MyComparator comp = new MyComparator(results);
		Map<Integer, Integer> newMap = new TreeMap(comp);
		newMap.putAll(results);

		return newMap;
	}// ends matchSort
	
	public List<User> recommendUsers(Statement st) {
		System.out.println("*******recommendUser for ProjectID: " + this.projectID + " ************");

		List<User> result = new ArrayList<User>();
		if (this.projectID != 0) {
			Map<Integer, List<Integer>> map = new HashMap<Integer, List<Integer>>();
			Map<Integer, Integer> results = new HashMap<Integer, Integer>();
			int user = 0;
			int skill = 0;
			try {
				String getUsersSkills = "Select userID, skillID From janus.user_skills" + "";
				ResultSet rs = st.executeQuery(getUsersSkills);
				System.out.println("recommendUsers Query Results: ");
				while (rs.next()) {
					user = rs.getInt("userID");
					skill = rs.getInt("skillID");
					System.out.print("\tuser:" + user);
					System.out.println("\tskill:" + skill);
					if (map.containsKey(user)) {
						System.out.println("Found user in map, adding user and skill:");
						System.out.println("\tuser: " + user + "\tskill: " + skill);
						map.get(user).add(skill);
					} // ends if
					else {
						List<Integer> values = new ArrayList<Integer>();
						System.out.println("First Time:  Adding user and skill to map and results: ");
						values.add(skill);
						map.put(user, values);
						System.out.println("user: " + user + "\tskill: " + skill);
						System.out.println("Initialize results array with user, 0");
						results.put(user, 0);

					} // ends else
				} // ends while

				// get a list of recommend userID's
				results = matchSort(map, results);
				System.out.println("Print sorted results:");
				for (Map.Entry<Integer, Integer> mp : results.entrySet()) {
					System.out.println(mp.getKey() + " " + mp.getValue());
				}
				System.out.println("End of map for");

				for (Map.Entry<Integer, Integer> dres : results.entrySet()) {
					String getUserInfo = "Select userID, username, userPassword, fname, lname, email From janus.users";
					rs = st.executeQuery(getUserInfo);
					while (rs.next()) {
						if (rs.getInt("userID") == dres.getKey()) {
							User person = new User(rs.getString("username"), rs.getString("userPassword"));
							person.setID(rs.getInt("userID"));
							person.setFName(rs.getString("fname"));
							person.setLName(rs.getString("lname"));
							person.setEmail(rs.getString("email"));
							result.add(person);
						} // ends if
					} // ends while
				} // ends for

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // ends catch
		} // ends if
		else {
			System.out.println("Hit the projectID == 0, set result to null");
			result = null;
		} // ends else
		this.rec_user = result;
		return result;
	}// ends recommentUsers

	public void addProjectToDB(Statement st)
	{
		int projectID=0;
		try {
			String sql="insert into projects (projectname,abstract,description,adminID,openstatus) value ('"+projectName+"','"+projectAbstract+"','"+description+"','"+administratorID+"',1);";
			//System.out.println(sql);
			st.execute(sql);
			sql="select projectID from projects where projectname='"+projectName+"';";
			//System.out.println(sql);
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
			//System.out.println(sql);
			st.execute(sql);
			sql="insert into user_projects (userID,projectID) value("+administratorID+","+projectID+");";
			//System.out.println(sql);
			st.execute(sql);
			
			
			
			    
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}//ends project class

class MyComparator implements Comparator<Integer> {
	Map<Integer, Integer> map = new HashMap<Integer, Integer>();

	public MyComparator(Map<Integer, Integer> map) {
		this.map = map;
	}

	public int compare(Integer o1, Integer o2) {
		if (((Integer) map.get(o2)) == ((Integer) map.get(o1))) {
			return (Integer) map.get(o1);
		}
		return ((Integer) map.get(o2)).compareTo((Integer) map.get(o1));
	}
}