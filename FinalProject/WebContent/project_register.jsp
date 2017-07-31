<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<%session.setMaxInactiveInterval(1000); %>
<%@ page import="classes.*"%>
<%
		
		User u = (User)request.getSession().getAttribute("currUser");
		String fname = u.getFname();
		String lname = u.getLname();
		String bio=u.getBio();
		System.out.println(fname);
		String username=u.getUsername();
	%>
<html>
	<head>
		<title>Project Registration</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta HTTP-EQUIV = "refresh" content =" <%=session.getMaxInactiveInterval() %>; URL=index.jsp"/>
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		<script type="text/javascript">
			function showOrHide1() {
    			var div1 = document.getElementById("showorhide1");
    			if (div1.style.display == "block") {
        			div1.style.display = "none";
    			}
    			else {
        			div1.style.display = "block";
    			}
			}
			function showOrHide2(){
				var div2 = document.getElementById("showorhide2");
    			if (div2.style.display == "block"){
        			div2.style.display = "none";
    			}
    			else{
        			div2.style.display = "block";
    			}
			}
			function showOrHide3(){
    			var div3 = document.getElementById("showorhide3");
    			if (div3.style.display == "block"){
        			div3.style.display = "none";
    			}
    			else{
        			div3.style.display = "block";
    			}
			}
		</script>
		<script src="project_register.js"></script>
	</head>
	<body onload="connect('<%=username%>')">
		<!-- Header -->
			<section id="header">
				<header>
					<span class="image avatar"><img src="images/miller.jpg" alt="" /></span>
					<h1 id="logo"><a href="#"><%=fname %><%=lname %></a></h1>
					<p><%=bio %></p>
				</header>
				<nav id="nav">
					<ul>
						<li><a href="#one" class="active">Project Registration</a></li>
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
									<b><h3>Create a Project</h3></b>
									
									<div class="features">
										<article>
											<form method="post" action="project_register">
												<div class="row uniform">
													<div class="12u"><input type="text" name="projectname" id="pname" placeholder="Project Name" /></div>
												</div><hr/>
												<%! String[] programming = {"Java", "C++", "Python", "HTML/CSS", "Javascript", "PHP", "Fortran", "Assembly"}; %>										
												<%! String[] app = {"Ppt", "Excel", "Word", "Keynote", "Pages", "Numbers", "Matlab", "Solidworks", "autoCAD", "Photoshop"};%>
												<%! String[] softskills = {"Communication", "Marketing", "Accounting", "Writing", "Public speaking", "Research", "Management"};%>
												Skills:
												<fieldset><legend id="legendTitle">Programming:		<a href="javascript:showOrHide1();"><i class="glyphicon glyphicon-chevron-down"></i></a></legend>
													<div id="showorhide1" style="display:none;">
													<%for(int h = 0; h < programming.length; h++){ %>
														<input type ="checkbox" id ="programming<%=h%>" name = "skill" value=<%=programming[h] %> >
														<label for="programming<%=h%>"><%=programming[h]%></label>
													<%}//ends for %>
													</div>
												</fieldset>
												<fieldset><legend id="legendTitle">Applications: 	<a href="javascript:showOrHide2();"><i class="glyphicon glyphicon-chevron-down"></i></a></legend>
													<div id="showorhide2" style="display:none;">
														<%for(int i = 0; i < app.length; i++){ %>
															<input type ="checkbox" id ="application<%=i%>" name = "skill" value =<%=app[i]%>>
															<label for="application<%=i%>"><%=app[i]%></label>
														<%}//ends for %>
													</div>
												</fieldset>
												<fieldset><legend id="legentdTitle">Softskills: 	<a href="javascript:showOrHide3();"><i class="glyphicon glyphicon-chevron-down"></i></a></legend>
													<div id="showorhide3" style="display:none;">
														<%for(int j = 0; j < softskills.length; j++){%>
																<input type ="checkbox" id ="softskills<%=j%>" name = "skill" value =<%=softskills[j]%>>
																<label for="softskills<%=j%>"><%=softskills[j]%></label>
														<%}//ends for %>
													</div>
												</fieldset><br/>
												Abstract:
												<div class="row uniform">
													<div class="12u"><input type="text" name="abstract" id="abstract" placeholder="A short sentence describing the project"/></div>
												</div><br/>
												Detailed Description:
												<div class="row uniform">
													<div class="12u"><textarea name="description" id="description" placeholder="Detailed Project Description" rows="6"></textarea></div>
												</div><hr/>
												<div class="row uniform">
													<div class="12u">Project Contact:</div>
													<div class="6u 12u(xsmall)"><input type="text" name="fname" id="fname" placeholder="first name" /></div>
													<div class="6u 12u(xsmall)"><input type="text" name="lname" id="lname" placeholder="last name" /></div>
													<div class="12u"><input type="text" name="email" id="email" placeholder="email" /></div>
												</div><hr/>
												<div class="row uniform">
													<div class="12u">
														<ul class="actions">
															<li><input type="submit" class="special"  value="Create Project"  /></li>
															<li><input type="reset" value="Reset form" /></li>
															<li><input type="submit" name="cancel" value="Cancel"/></li>
															
														</ul>
													</div>
												</div>
											</form>
											<button onclick="send()">Send feed to others</button>
										</article>
									</div>
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