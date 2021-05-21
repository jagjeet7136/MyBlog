<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
session.removeAttribute("currentUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/myStyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>MyBLog Home</title>
<style>
body {
	background:
		url('https://image.freepik.com/free-photo/technology-digital-wave-background_34629-909.jpg');
	background-size: cover;
	background-attachment: fixed;
}
</style>
</head>
<body>

	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-rss-square">&nbsp</span>MyBLog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="loginPage.jsp">Login</a>
				<li class="nav-item"><a class="nav-link"
					href="registerPage.jsp">Sign up</a></li>
			</ul>
		</div>
	</nav>
	
	<!-- banner -->

	<div class="container-fluid banner-background p-0 m-0"
		style="height: 50vh;">
		<div class="jumbotron primary-background text-white">
			<div class="container">
				<h3 class="display-4">Welcome to MyBlog</h3>

				<p style="margin-top: 10px;">
					Blogging is good for your career. A well-executed blog sets you
					apart as an expert in your field. <strong><em>Penelope
							Trunk</em></strong>
				</p>
			</div>
		</div>
	</div>

</body>
</html>