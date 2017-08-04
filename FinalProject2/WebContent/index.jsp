<%@ page import="classes.*, java.sql.*, java.util.Vector"%>
<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		<%
			SQL sq = new SQL();
			Statement st = sq.getSt();
		  String sql = "SELECT * FROM projects;";
		  ResultSet rs = st.executeQuery(sql);
		  Vector<Project> projects = new Vector<Project>(1,1);
		  while(rs.next()) {
			  int adminId = rs.getInt("adminID");
			  int projectID = rs.getInt("projectID");
			  String projectName = rs.getString("projectName");
			  String projectAbstract = rs.getString("abstract");
			  String description = rs.getString("description");
			  Project p = new Project(adminId, projectName, projectAbstract, description);
			  p.addProjectID(projectID);
			  projects.add(p);
		  }
		  //add skills to projects
		  for(int i = 0; i < projects.size(); i++) {
			  int projectID = projects.get(i).getProjectID();
			  sql = "SELECT skillID FROM project_skill WHERE projectID='" + projectID + "';";
			  ResultSet r = st.executeQuery(sql);
			  while(r.next()) {
				  int skill = r.getInt("skillID");
				  projects.get(i).addSkill(skill);
			  }
		  }
		%>		
		<script>
			// Get the modal
			var modal = document.getElementById('id01');
			// When the user clicks anywhere outside of the modal, close it
			window.onclick = function(event) {
    			if (event.target == modal) {
        			modal.style.display = "none";
    			}
			}
			
			//login
			function validate(){
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "validate.jsp?uname=" + document.login.uname.value +
					"&psw=" + document.login.psw.value, false);
				xhttp.send();
				if (xhttp.responseText.trim().length > 0) {
					document.getElementById("formerror").innerHTML = xhttp.responseText;
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body>
		<!-- Header -->
			<section id="header">
				<header>
					<span class="image avatar"><img src="images/Non_Transparent.png" alt="" /></span>
					<h1 id="logo"><a href="#">Guest User</a></h1>
					<button onclick="document.getElementById('id01').style.display='block'" >Login/Register</button>
				</header>
				<nav id="nav">
					<ul>
						<li><a href="#one" class="active">Listings</a></li>
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
						<!-- Login Window -->
						<div id="id01" class="modal">
  							<form name="login" class="modal-content animate" action="Login" onsubmit="return validate();" method="POST">
   								<div class="imgcontainer">
     								<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
    							</div>
    							<div class="container">
    								<div id="formerror"></div>
     								<label><b>Username</b></label>
      								<input type="text" placeholder="Enter Username" name="uname" required>
      								<label><b>Password</b></label>
      								<input type="password" placeholder="Enter Password" name="psw" required><br/>
      								<span class="psw">First time user? <a href="user_register.jsp">Register</a></span>
      								<button type="button" onclick="document.getElementById('id01').style.display='none'"style="margin-right: 16px"  class="cancelbtn">Cancel</button>
      								<input type="submit" class="special" value="Login"/>
      								<!-- <button type="submit">Login</button> -->
    							</div>
  							</form>
						</div>
						
						<!-- One -->
							<section id="one">
								<div class="container">								
									<% for (int i=0;i<projects.size();i++){								
									%>									
									<div class="features">
										<article>
											<a href="#" class="image"><img src="images/light2.jpg"  onerror = "this.src = 'images/light.jpg'"/></a>
											<div class="inner">
												<h4><%=projects.get(i).getProjectName() %></h4>
												<p><%=projects.get(i).getProjectAbstract() %></p>
											</div>
										</article>
										
									</div>
									<%}%>
									
									<div id="addition"></div>	
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

	</body>
</html>