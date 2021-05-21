<%@page import="app.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="app.dao.UserDao"%>
<%@page import="app.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="app.helper.ConnectionProvider"%>
<%@page import="app.dao.PostDao"%>
<%@page import="app.entities.Post"%>
<%@page import="app.entities.User"%>
<%@page errorPage="errorPage.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("loginPage.jsp");
}
%>

<%
int pid = Integer.parseInt(request.getParameter("post_id"));
PostDao d = new PostDao(ConnectionProvider.getConnection());
Post p = d.getPostByPostId(pid);
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=p.getPtitle()%></title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/myStyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(0% 0%, 100% 0%, 100% 87%, 75% 87%, 75% 100%, 42% 87%, 0 86%);
}

.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-content {
	font-weight: 100;
	font-size: 25px;
}

.post-user-info {
	
}

body {
	background:
		url('https://image.freepik.com/free-photo/technology-digital-wave-background_34629-909.jpg');
	background-size: cover;
	background-attachment: fixed;
}
</style>
</head>
<body>


	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span class="fa fa-code">&nbsp</span>MyBLog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="profile.jsp">Home
						<span class="sr-only">(current)</span>
				</a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> Our List </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming</a> <a
							class="dropdown-item" href="#">Robotics</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Electronics</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal">Post</a></li>
			</ul>
			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#profile-modal"
					style="color: rgb(255, 250, 250);"> <span
						style="color: rgb(255, 250, 250);" class="fa fa-user"></span><span>
							Hello,</span> <%=user.getName()%>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="logout"
					style="color: rgb(255, 250, 250);"> <span
						style="color: rgb(255, 250, 250);" class="fa fa-sign-out"></span>
						Logout
				</a></li>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="col-md-6 offset-md-3">
			<div class="card mt-4 mb-4">
				<div class="card-header primary-background">
					<h4 class="post-title" style="color: white;"><%=p.getPtitle()%></h4>
				</div>

				<div class="card-body">
					<img class="card-img-top my-2" style="height: 20vw;"
						src="blogPics/<%=p.getPpic()%>" alt="Card image cap">
					<div class="row my-3 row-user">
						<div class="col-md-8">
							<hr style="width: 25vw;">
							<%
							UserDao userDao = new UserDao(ConnectionProvider.getConnection());
							User userName = userDao.getUserByPostId(p.getUserid());
							String name = userName.getName();
							%>
							<p class="post-user-info">
								By <strong style="font-size: 13px;"><em><span><%=name%>
									</span></em></strong> on <strong style="font-size: 13px;"><em><%=DateFormat.getDateTimeInstance().format(p.getPdate())%></em></strong>
							</p>
							<hr style="width: 25vw;">
						</div>
						<div class="col-md-4"></div>
					</div>
					<p class="post-content" style="font-weight: 10px;"><%=p.getPcontent()%>
						<br>
				</div>
				<div class="card-footer text-center primary-background">

					<%
					LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
					%>
					<a href="#" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)"
						class="btn btn-outline-primary btn-sm"
						style="color: white; border: 1px solid white;"><i
						class="fa fa-thumbs-o-up"><span class="like-counter"><%=ld.countLike(p.getPid())%></span></i></a>
				</div>

			</div>
		</div>
	</div>



	<div class="modal" id="profile-modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title">MyBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body text-center">

					<div class="container">
						<img src="pics/<%=user.getProfile()%>" style="width: 7vw">
						<h5 class="modal-title" style="margin-bottom: 0.5vw;"><%=user.getName()%></h5>

						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getDateTime().toString()%></td>
									</tr>

								</tbody>
							</table>
						</div>

						<div id="profile-edit" style="display: none">
							<h3>Please edit carefully</h3>
							<form action="edit" method="POST" enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<td>About :</td>
										<td><textarea rows="3" class="form-control"
												name="user_about">
										<%=user.getAbout()%>
										</textarea></td>
									</tr>
									<tr>
										<td>Update image:</td>
										<td><input type="file" name="image" class="form-control"></td>
									</tr>

								</table>
								<div class="container">
									<button type="submit" class="btn btn-outline-primary"
										style="margin-left: 6.5vw;">Save</button>
								</div>
							</form>
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary primary-background text-white">Edit</button>
				</div>
			</div>
		</div>
	</div>



	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Add your post</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="addPost" method="POST">
						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>Select category...</option>
								<%
								PostDao post = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = post.getAllCategories();
								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>

							</select>
						</div>

						<div class="form-group">
							<input name="ptitle" type="text" placeholder="Enter post title"
								class="form-control" />
						</div>

						<div class="form-group">
							<textarea name="pcontent" class="form-control"
								placeholder="Enter your content" rows="8" cols=""></textarea>
						</div>

						<div class="form-group">
							<textarea name="pcode" class="form-control"
								placeholder="Enter your program(if any)" rows="" cols=""></textarea>
						</div>

						<div class="form-group">
							<label><strong>Select your picture : </strong></label> <input
								name="ppic" type="file">
						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>




	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
		$(document).ready(function() {
			let editStatus = false;
			$('#edit-profile-button').click(function() {

				if (editStatus == false) {
					$("#profile-details").hide()
					$("#profile-edit").show();
					editStatus = true;
					$(this).text("Back")
				} else {
					$("#profile-details").show()
					$("#profile-edit").hide();
					editStatus = false;
					$(this).text("Edit")
				}

			})

		});
	</script>

	<script>
		$(document).ready(
				function(e) {
				$("#add-post-form").on("submit",
											function(event) {
												event.preventDefault();
												console.log("submitted")

												let form = new FormData(this);
												$
														.ajax({
															url : "addPost",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																console
																		.log(data);
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"Saved Successfully!",
																			"success");
																} else {
																	swal(
																			"Error Occured!",
																			"Something went wrong!",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																swal(
																		"Error!",
																		"Something went wrong!",
																		"error");
															},
															processData : false,
															contentType : false
														})
											})
						})
	</script>

</body>
</html>