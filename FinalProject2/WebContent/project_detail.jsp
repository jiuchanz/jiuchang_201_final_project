<%@ page import="classes.*, backend.*, java.sql.*, java.util.*"%>
<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<%if(session.isNew()){response.sendRedirect("index.jsp"); return;}
	Vector<Project> projects=(Vector<Project>) request.getSession().getAttribute("projects");
	Map<Integer,User> UserMap =(HashMap<Integer,User>) request.getSession().getAttribute("userMap");

	String userIDStr=request.getParameter("userID");
	if(userIDStr==null) {userIDStr=(String) request.getSession().getAttribute("p_duserID");}
	int userID=Integer.valueOf(userIDStr);
	request.getSession().setAttribute("p_duserID", String.valueOf(userID));
	
	
	
	User u=UserMap.get(userID);
	String projectName=(String) request.getSession().getAttribute("projectname");
	String projectID="";
	Project project=null;
	//ADD CLICKING NAME OF PROJECT IN LIST FUNCTIONALITY
		if(request.getParameter("pName") != null){
			projectName = request.getParameter("pName");
			projectName = projectName.replaceAll("%20", " ");
			session.setAttribute("projectname", projectName);
			for(int i=0;i<projects.size();i++)
			{
				if(projects.get(i).getProjectName().equals(projectName)){
					project=projects.get(i);
				}
			}
		}//END FUNCTIONALITY

	if(projectName==null)
	{
		projectID=request.getParameter("pID");
		System.out.println(projectID);
		//System.out.println(projectID);
		for(int i=0;i<projects.size();i++)
		{
			//System.out.println(projects.get(i).getProjectID());
			if(projects.get(i).getProjectID()==Integer.valueOf(projectID))
				project=projects.get(i);
		}
		
	}
	else
	{
		//System.out.println(projectName);
		//System.out.println("");
		for(int i=0;i<projects.size();i++)
		{
			//System.out.println(projects.get(i).getProjectName());
			if(projects.get(i).getProjectName().equals(projectName))
				project=projects.get(i);
		}
	}
	
	//System.out.println(projectID);
	
	
	
	Vector<String> skillnames=(Vector<String>) request.getSession().getAttribute("skillnames");
	
	List<User> recUser=new ArrayList<User>();
	//System.out.print(project.getProjectName());
     recUser = project.get_rec();
%> 
<html>
	<head>
		<title>Profile</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta HTTP-EQUIV = "refresh" content =" <%=session.getMaxInactiveInterval() %>; URL=index.jsp"/>
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		
		<% 
		String username = u.getUsername();
		String fname = u.getFname();
		if(fname==null){fname="";}
		String lname = u.getLname();
		if(lname==null){lname="";} 
		String full_name = fname+" "+lname+" ";%>
		<script>
		//***************RAISA JOIN PROJECT*********************
		 function Join(u_name, proID){
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "join_project.jsp?username=" + u_name +
				"&projectID=" + proID, false);
			xhttp.send();
			xhttp.responseText.trim();
			document.getElementById("join").innerHTML = xhttp.responseText;
			System.out.println(xhttp.responseText);
		 }
		//***************END JOIN PROJECT**************************
		</script>
		<script src="project_detail.js"></script>
	</head>
	<body onload ="connect('<%=full_name%>')">
		<!-- Header -->
			<section id="header">
				<header>
					<span class="image avatar"><img src="images/Non_Transparent.png" alt="" /></span>
					<h1 id="logo"><a href="#"><%=fname %> <%=lname %></a></h1>
					<p>
						<%if(u.getBio()!=null){ %>
							<%=u.getBio()%>
						<%} %>
					</p>
				</header>
				<nav id="nav">
					<ul>
						<li><a href="user_listing.jsp?userID=<%=userID%>">Listing</a></li>
						<li><a href="profile.jsp?userID=<%=userID%>">Profile</a></li>
						<li><a href="#one" class="active">Project Info</a></li>
						<li><a href="#two">Skillset</a></li>
						<li><a href="#three">Details</a></li>
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
									<b><h3>Project Name:<%=project.getProjectName()%> </h3></b>
								</div>
							</section>
						<!-- Two -->
							<section id="two">
								<div class="container">
									<h3>Skillsets</h3>
									<p><%for(int idx:project.getSkillSet()){%>
										<%=skillnames.get(idx)%>
										<%}//ends for%></p>
								</div>
							</section>
						<!-- Three -->

							
								<section id="three">
								<div class="container">
									<h3>Abstract:</h3><p><%=project.getProjectAbstract() %></p>
									<h3>Description:</h3><br/>
									<p><%=project.getProjectDescription() %></p>
									<%
										if(u.getID()!=project.getProjectContactID()){
									%>
										<div id="join">
											<button class="special" onclick="Join('<%=username%>', <%=project.getProjectID()%>)">Join</button>
										</div>
									<%
										}else{
									%>
											<h3>Recommended users:</h3>
										
											<form name="rec_user"  onsubmit ="loop_it(document.rec_user, <%=project.getProjectID()%>)" >
												
												<fieldset>
														<%
														for(int i = 0; i < recUser.size(); i++){
															if(!username.equals(recUser.get(i).getUsername())){
																String recName = recUser.get(i).getUsername();
																String fName = recUser.get(i).getFname();
																String lName = recUser.get(i).getLname();
															
													%>
												
														<input type="checkbox" id="users<%=i%>" name="recUsers" value="<%=recName %>" onClick="this.checked">
														<label for="users<%=i%>"><%=fName %> <%=lName %></label>
													<%	}//ends if
													
															}	
													%>
												</fieldset>
												<input type="submit" class="special" name="notify" value="Send Invitation" >
												
											</form>
											
									<%
										}
									%>
								</div>
							</section>
					</div>
				<!-- Footer -->
					<section id="footer">
						<div class="container">
							<ul class="copyright">
								<li>&copy; Janus. All rights reserved.</li><li>CSCI201L</li>
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