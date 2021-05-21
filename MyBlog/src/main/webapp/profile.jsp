<%@page import="app.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="app.helper.ConnectionProvider"%>
<%@page import="app.dao.PostDao"%>
<%@page import="app.entities.Message"%>
<%@page import="app.entities.User"%>
<%@page errorPage="errorPage.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("loginPage.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Your Profile</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/myStyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

	<%
	Message m = (Message) session.getAttribute("message2");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%> text-center" role="alert">
		<%=m.getContent()%></div>
	<%
	session.removeAttribute("message2");
	}
	%>


	<main>
		<div class="container">
			<div class="row mt-4">
				<!--first col-->
				<div class="col-md-4">
					<!--categories-->
					<div class="list-group">
						<a href="#" onclick="getPosts(0, this)"
							class="c-link list-group-item list-group-item-action active">
							All Posts </a>
						<!--categories-->

						<%
						PostDao d = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list1 = d.getAllCategories();
						for (Category cc : list1) {
						%>
						<a href="#" onclick="getPosts(<%=cc.getCid()%>, this)"
							class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>


						<%
						}
						%>
					</div>

				</div>

				<!--second col-->
				<div class="col-md-8">
					<!--posts-->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>

					<div class="container-fluid" id="post-container"></div>
				</div>

			</div>

		</div>

	</main>


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
		$(document)
				.ready(
						function(e) {
							$("#add-post-form")
									.on(
											"submit",
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



	<script>
	function getPosts(cid, temp) {
		$("#loader").show();
		$("#post-container").hide()
		$(".c-link").removeClass('active')
		$.ajax({
			url: "loadPost.jsp",
			data:{cid:cid},
			success: function(data, textStatus, jqXHR) {
				console.log(data);
				$("#loader").hide();
				$("#post-container").show();
				$('#post-container').html(data)
				$(temp).addClass('active')
			}
		})
	}
		$(document).ready(function (e) {
			let allPostRef=$('.c-link')[0]
			getPosts(0, allPostRef)
		})
	</script>

</body>
</html>











