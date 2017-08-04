<%@ page import="classes.*"%>
<%@ page import="java.util.Vector,java.util.Map,java.util.HashMap"
 %>
<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<%session.setMaxInactiveInterval(1000); %>
<html>
	<head>
		<title>Home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta HTTP-EQUIV = "refresh" content =" <%=session.getMaxInactiveInterval() %>; URL=index.jsp"/>
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		<script src="user_listing.js"></script>
		<%
		Map<Integer,User> UserMap =(HashMap<Integer,User>) request.getSession().getAttribute("userMap");
		//System.out.println((Integer)request.getSession().getAttribute("userID"));
		int userID=Integer.valueOf((String) request.getParameter("userID"));
		
		//System.out.println(userID);
		User u=UserMap.get(userID);
		String fname = u.getFname();
		String lname = u.getLname();
		//System.out.println(fname);
		String username=u.getUsername();
		Vector<Project> projects=(Vector<Project>) request.getSession().getAttribute("projects");
		//System.out.println(projects.get(0).getProjectName());
	%>
	</head>
	<body onload="connect('<%=username%>')">
	
		<!-- Header -->
			<section id="header">
				<header>
					<span class="image avatar"><img src="images/Non_Transparent.png" alt="" /></span>


					<h1 id="logo"><a href="#"><%=fname %> <%=lname %></a></h1>
					<p>
						<%if(u.getBio() != null){ %>
							<%=u.getBio() %>
						<%} %>
					</p>
					
					<ul class ="notification-container">
    						<li><a onclick="document.getElementById('id01').style.display='block'">
    						<i class = "icon fa-globe fa-2x" id="ccc"></i>
        					<span class="notification-counter">1</span>
        					</a>
   					 	</li>
					</ul>

				</header>
				<nav id="nav">
					<ul>
						<li><a href="#one" class="active">Listings</a></li>
						<li><a href="profile.jsp?userID=<%=userID%>">Profile</a></li>
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
							<div id="id01" class="modal">
							<form class="modal-content animate"  method="POST">
   								<div class="imgcontainer">
     								<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
    							</div>
    							<div class="container">
    								<div id = "notify"></div>	
    							</div>
    							<div class="container" > 
      								<button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Close</button>
      								
    							</div>
  							</form>
							</div>
			
					
					
						<!-- One -->
							<section id="one">
								<div class="container">
								
								
								
									<% for (int i=0;i<projects.size();i++) 
									{
										
									
									%>
									
									<div class="features">
										<article>
											<a href="#" class="image"><img src="images/light2.jpg"  onerror = "this.src = 'images/light.jpg'"/></a>
											<div class="inner">
												<h4><a href="project_detail.jsp?pName=<%=projects.get(i).getProjectName()%>&userID=<%=u.getID()%>"><%= projects.get(i).getProjectName() %></a></h4>

												<p><%=projects.get(i).getProjectAbstract() %></p>
											</div>
										</article>
										
									</div>
									<% }%>
									
									<div id="addition"></div>	
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