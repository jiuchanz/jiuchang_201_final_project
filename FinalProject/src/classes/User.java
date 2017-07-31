package classes;

import java.util.*;




import java.util.Set;



public class User {

	private String fname;
	private String lname;
	private String username;
	private String password;
	private int id	;  //get from databases
	private String resumeUrl ;
	private List<Integer> skills = new ArrayList<Integer>();
	private Set<Integer> projects=new HashSet<Integer>();
	private String email;
	private String aboutMe;
	private String phone;
	private String imgUrl;
	private String bio;
	private String location;
	public User(String username,String password)
	{
		this.username=username;
		this.password=password;
		this.id=0;
		resumeUrl="";
		email="";
		aboutMe="";
		phone="";
		imgUrl="";
		
	}
	public void setFName(String fname) {
		this.fname = fname;
	}
	public void setLName(String lname) {
		this.lname = lname;
	}
	public void setID(int id) {
		this.id = id;
	}
	public void setResumeURL(String resumeUrl) {
		this.resumeUrl = resumeUrl;
	}
	public void addSkills(int skill) {
		skills.add(skill);
	}
	public void setBio(String bio) {
		this.bio=bio;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public void setPhone(String p) {
		this.phone = p;
	}
	public void setEmail(String e) {
		email = e;
	}
	public String getFname() {return fname;}
	public String getLname() {return lname;}
	public String getUsername() {return username;}
	public String getPassword() {return password;}
	public int 	  getID()		{return id;}
	public String getResumeUrl() {return resumeUrl;}
	public Set<Integer> getProjects() {return projects;}
	public List<Integer> getSkills() {return skills;}
	public String getEmail() 	{return email;}
	public String getAboutMe()  {return aboutMe;}
	public String getPhone()    {return phone;}
	public String getImgUrl()  {return imgUrl;}
	public String getBio() {return bio;}
	public String getLocation() {return location;}
	public void insertProject( int projectID ) {this.projects.add(projectID);} 
	
	public void updateDatabase() {
		
	}
}

