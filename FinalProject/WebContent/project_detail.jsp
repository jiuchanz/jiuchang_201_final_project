<%@ page import="classes.*, backend.*, java.sql.*, java.util.*"%>
<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<%if(session.isNew()){response.sendRedirect("index.jsp"); return;}
	Vector<Project> projects=(Vector<Project>) request.getSession().getAttribute("projects");
	String projectName=(String) request.getSession().getAttribute("projectname");
	String projectID="";
	if(projectName==null) projectID=request.getParameter("projectInput");
	System.out.println(projectID);
	Project project=null;
	for(int i=0;i<projects.size();i++)
	{
		if(projects.get(i).getProjectID()==Integer.valueOf(projectID))
			project=projects.get(i);
	}
	List<String> skillnames = (List<String>)session.getAttribute("skillNames");
	skillnames=new ArrayList<String>();
	List<User> recUser = (List<User>)session.getAttribute("recommendUsers");
	recUser=new ArrayList<User>();
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
		<script src="user_listing.js"></script>
		<% User u = (User)request.getSession().getAttribute("currUser");
		String username = u.getUsername();
		String fname = u.getFname();
		if(fname==null){fname="";}
		String lname = u.getLname();
		if(lname==null){lname="";} %>
	</head>
	<body>
		<!-- Header -->
			<section id="header">
				<header>
					<span class="image avatar"><img src="images/miller.jpg" alt="" /></span>
					<h1 id="logo"><a href="#"><%=fname %> <%=lname %></a></h1>
					<p>Insert user bio</p>
				</header>
				<nav id="nav">
					<ul>
						<li><a href="user_listing.jsp">Listing</a></li>
						<li><a href="profile.jsp">Profile</a></li>
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
									<p><%for(int h = 0; h < skillnames.size(); h++){%>
										<%=skillnames.get(h)%>
										<%}//ends for%></p>
								</div>
							</section>
						<!-- Three -->
							<section id="three">
								<div class="container">
									<h3>Abstract:</h3>
									<p><%=project.getProjectAbstract()%></p>
									<h3>Description:</h3>
									<p><%=project.getProjectDescription()%></p>
									<h3>Recommended Users: </h3>
									<fieldset>
										<legend id="legendTitle"></legend>
										<div>
											<p><%for(int h = 0; h < recUser.size(); h++){
												if(!username.equals(recUser.get(h).getUsername())){%>
													<%=recUser.get(h).getFname()%> <%=recUser.get(h).getLname()%>	
												<%}
												else{%>
													No Recommended Users
												
												<%}//ends else
											}//ends for%></p>	
										</div>
									</fieldset>
								</div>
							</section>
					</div>
				<!-- Footer -->
					<section id="footer">
						<div class="container">
							<ul class="copyright">
								<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
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