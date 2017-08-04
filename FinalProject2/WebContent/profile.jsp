<%@ page import="classes.*, backend.*, java.sql.*, java.util.*"%>
<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<%session.setMaxInactiveInterval(1000); %>
<html>
	<head>
		<title>Profile</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta HTTP-EQUIV = "refresh" content =" <%=session.getMaxInactiveInterval() %>; URL=index.jsp"/>
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<body>
	<%
		
		Map<Integer,User> UserMap =(HashMap<Integer,User>) request.getSession().getAttribute("userMap");
	int userID=Integer.valueOf((String) request.getParameter("userID"));

		
		//System.out.println(userID);
		User u=UserMap.get(userID);
		
		//System.out.println(u.getFname());
		Vector<Project> projects=(Vector<Project>) request.getSession().getAttribute("projects");
		String username = u.getUsername();
		String fname = u.getFname();
		if(fname==null){fname="";}
		String lname = u.getLname();
		if(lname==null){lname="";}
		String email = u.getEmail();
		if(email==null){email="";}
		String phone = u.getPhone();
		if(phone==null){phone="";}
		String bio = u.getBio();
		if(bio==null){bio="";}
		String location = u.getLocation();
		if(location==null){location="";}
		//get skills from database
		SQL db=new SQL();
		Statement st=db.getSt();
		//System.out.println(username);
		List<Integer> skillID = u.getSkills();
		List<String> skills = new ArrayList<String>();
		String sql;
	    ResultSet rs;
	    for(int i = 0; i < skillID.size(); i++){
	    	sql = "SELECT skillName FROM skills WHERE skillID='" + skillID.get(i) + "';";
	    	rs = st.executeQuery(sql);
	    	while(rs.next()){
	    		skills.add(rs.getString("skillName"));
	    	}
	    }
	%>
		<!-- Header -->
			<section id="header">
				<header>
					<span class="image avatar"><img src="images/Non_Transparent.png" alt="" /></span>
					<!-- GET NAME FROM SERVLET -->
					<h1 id="logo"><a href="#"><%=fname %> <%=lname %></a></h1>
					<p>
					<%if(u.getBio()!=null){ %>
						<%=u.getBio()%>
					<%} %>
					</p>
				</header>
				<nav id="nav">
					<ul>
						<li><a href="user_listing.jsp?userID=<%=userID%>">Listings</a></li>
						<li><a href="#one" class="active">Profile</a></li>
						<li><a href="#two">Projects</a></li>
						<li><a href="edit_profile.jsp?userID=<%=userID%>">Edit Profile</a></li>
					</ul>
				</nav>
				<footer>
					<ul class="icons">
						<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
						<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
						<li><a href="#" class="icon fa-envelope"><span class="label">Email</span></a></li>
					</ul>
				</footer>
			</section>

		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<!-- One -->
							<section id="one">
								<div class="container">
									<b><h3>Profile Info</h3></b>
									<b>Name:</b> <%=fname %> <%=lname %><br/>
									<b>Email:</b> <%=email %><br/>
									<b>Phone:</b> <%=phone %><br/>
									<b>Location: <%=location %></b><br/>
									<b>Skills:</b>
									<%
										for(int i = 0; i < skills.size()-1; i++){
											String currSkill = skills.get(i);
									%>
										<%=currSkill %>,
									<%
										}
										String currskill = skills.get(skills.size()-1);
									%>
										<%=currskill %>
									<br/>
								</div>
							</section>
						<!-- Two -->
							<section id="two">
								<div class="container">
									<h3>Projects</h3>
									<script>
									function changeType() {
									    var x = document.getElementById("projects").value;
									    if(x=='current')
								    	{
									    	document.getElementById("pastProject").style.display='none';
									    	document.getElementById("adminProject").style.display='none';
									    	document.getElementById("currentProject").style.display='block';
								    	}
									    else if(x=='past')
									    {
									    	document.getElementById("currentProject").style.display='none';
									    	document.getElementById("adminProject").style.display='none';
									    	document.getElementById("pastProject").style.display='block';
									    }
									    else 
								    	{
									    	document.getElementById("pastProject").style.display='none';
									    	document.getElementById("currentProject").style.display='none';
									    	document.getElementById("adminProject").style.display='block';
									    	
								    	}
									    	
									}
									</script>
									<select id="projects" onchange="changeType()">
										<option value="current">Current Projects</option>
										<option value="past">Past Projects</option>
										<option value="admin">Admin Projects</option>
									</select><br/>
					<%//******************************RAISA UPDATE PROFILE START**********************************%>
									<div id="currentProject">
									<%
									
									for(int i=0;i<projects.size();i++) 
									{
										
										Project project=projects.get(i);
										if(!u.getProjects().contains(project.getProjectID()))
											continue;
										
										if(project.getOpenstatus()==false)
										{
											continue;
										}
									%>
										<div class="features">
											<article>
												<a href="#" class="image"><img src="images/light2.jpg"  onerror = "this.src = 'images/light.jpg'"/></a>
												<div class="inner">
													<%String link = "project_detail.jsp?pName=" + project.getProjectName() + "&userID=" + userID; %>
													<h4><a href="<%=link %>"><%=project.getProjectName() %></a></h4>
													<p><%=project.getProjectAbstract() %></p>
												</div>
											</article>										
										</div>
										
									<%	
									}
									%>
									
									</div>
									<div id="pastProject" style="display: none">
									<%
									
									for(int i=0;i<projects.size();i++) 
									{
										
										Project project=projects.get(i);
										if(!u.getProjects().contains(project.getProjectID()))
											continue;
										
										if(project.getOpenstatus()==true)
											continue;
									%>
										<div class="features">
											<article>
												<a href="#" class="image"><img src="images/light2.jpg"  onerror = "this.src = 'images/light.jpg'"/></a>
												<div class="inner">
													<%String link = "project_detail.jsp?pName=" + project.getProjectName() + "&userID=" + userID; %>
													<h4><a href="<%=link %>"><%=project.getProjectName() %></a></h4>
													<p><%=project.getProjectAbstract() %></p>
												</div>
											</article>										
										</div>
										
									<%	
									}
									%>
									
									</div>
									<div id="adminProject" style="display:none">
									<%for(int i=0;i<projects.size();i++) 
									{
										
										Project project=projects.get(i);
										int adminID=project.getProjectContactID();
										if(adminID!=userID)
											continue;
									%>
										<div class="features">
											<article>
												<a href="#" class="image"><img src="images/light2.jpg"  onerror = "this.src = 'images/light.jpg'"/></a>
												<div class="inner">
													<%String link = "project_detail.jsp?pName=" + project.getProjectName() + "&userID=" + userID; %>
													<h4><a href="<%=link %>"><%=project.getProjectName() %></a></h4>
													<p><%=project.getProjectAbstract() %></p>
												</div>
											</article>										
										</div>
										
									<%	
									}
									%>
						<%//******************************RAISA UPDATE PROFILE END**********************************%>
									</div>
									
									
									<form method="POST" action="project_register.jsp?userID=<%=userID%>">
										<input type="submit" name="createProject" value="Create Project" class="special"/>
									</form>
								</div>
							</section>
					</div>
				<!-- Footer -->
					<section id="footer">
						<div class="container">
							<ul class="copyright">
								<li>&copy; Janus. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
							</ul>
						</div>
					</section>
			</div>
		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollzer.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>