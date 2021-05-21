<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Here</title>
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
	<%@include file="mainNavbar.html"%>
	<main class="primary-background banner-background" style="height: 75vh;">
		<div class="container">
			<div class="col-md-5 offset-md-3" style="margin: auto">
				<div class="card">
					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-3x fa-user-circle"></span> <br> Register
						here
					</div>
					<div class="card-body">
						<form id="reg-form" action="register" method="POST">

							<div class="form-group">
								<label for="user_name">FullName</label> <input name="user_name"
									type="text" class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter your name">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									name="user_email" type="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email"> <small id="emailHelp"
									class="form-text text-muted">We'll never share your
									email with anyone else.</small>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									name="user_password" type="password" class="form-control"
									id="exampleInputPassword1" placeholder="Password">
							</div>
							<div class="form-group">
								Select Gender <br> <input type="radio" id="male"
									name="gender" value="male"> <label for="male">Male</label>
								<input type="radio" id="female" name="gender" value="female">
								<label for="female">Female</label>
							</div>
							<div class="form-box">
								<textarea name="about" class="form-control" id="" cols="30"
									rows="2" placeholder="Enter something about yourself"></textarea>
							</div>
							<div class="form-check">
								<input name="check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree Terms and Conditions</label>
							</div>
							<div class="container"
								style="margin-left: 1vw; margin-top: 0.5vw; display: none;"
								id="loader">
								<span class="fa fa-refresh fa-spin fa-1.5x"></span>
							</div>

							<button id="submit-btn" type="submit" class="btn btn-primary"
								style="margin-top: 1vh;">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>

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
			console.log("loaded......")
			$('#reg-form').on('submit', function(event) {

				event.preventDefault();
				let form = new FormData(this);
				
				$('#submit-btn').hide();
				$('#loader').show();

				$.ajax({
					url : "register",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data)
						$('#submit-btn').show();
						$('#loader').hide();
						if(data.trim()=='Done') {
							
						swal("Registered Successfully")
						.then((value) => {
						  window.location="loginPage.jsp"
						});
						
						}
						else {
							swal(data);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						$('#submit-btn').show();
						$('#loader').hide();
						swal("Something went wrong. Try again");
						
					},
					processData : false,
					contentType : false
				});
			});
		});
	</script>


</body>
</html>